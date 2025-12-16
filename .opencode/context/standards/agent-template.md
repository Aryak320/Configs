# Agent Template

Comprehensive template for creating new agents in the .opencode system.

**Source**: Extracted from existing agents in `.opencode/agent/`  
**Last Updated**: 2025-12-16

---

## Table of Contents

1. [Agent Types](#agent-types)
2. [Frontmatter Template](#frontmatter-template)
3. [Agent Structure](#agent-structure)
4. [Coordinator Agent Template](#coordinator-agent-template)
5. [Specialist Agent Template](#specialist-agent-template)
6. [Subagent Template](#subagent-template)
7. [Workflow Stage Patterns](#workflow-stage-patterns)
8. [Delegation Patterns](#delegation-patterns)
9. [Tool Usage Guidelines](#tool-usage-guidelines)
10. [Output Format Standards](#output-format-standards)
11. [Usage Examples](#usage-examples)

---

## Agent Types

The .opencode system uses three types of agents:

### Coordinator Agents

**Purpose**: Orchestrate work by delegating to specialist subagents

**Characteristics**:
- MUST use `task` tool for ALL work
- NEVER execute work themselves
- Maintain small context (coordination only)
- Receive brief summaries from subagents (95% context reduction)
- Enable parallel execution (40-60% time savings)

**Examples**: researcher, implementer, tester, documenter, reviser (conditional)

### Specialist Agents

**Purpose**: Execute specialized work directly without delegation

**Characteristics**:
- Execute work directly (no delegation)
- Use their specialized expertise
- Read and write files themselves
- Optimized for their specific task

**Examples**: planner, orchestrator

### Subagents

**Purpose**: Execute specific tasks delegated by coordinator agents

**Characteristics**:
- Invoked via `task` tool by coordinators
- Execute focused, specialized work
- Return brief summaries (1-2 paragraphs) + artifact paths
- Never delegate further (single-level delegation)

**Examples**: code-generator, codebase-analyzer, docs-fetcher

---

## Frontmatter Template

```yaml
---
description: "{One-line description of agent purpose}"
mode: {primary|subagent}  # primary for coordinators/specialists, subagent for subagents
temperature: {0.2-0.3}  # 0.2 for precise work, 0.3 for creative work
tools:
  read: {true|false}
  write: {true|false}
  edit: {true|false}
  bash: {true|false}
  task: {true|false}  # true for coordinators, false for specialists/subagents
  glob: {true|false}
  grep: {true|false}
  list: {true|false}
  todoread: {true|false}  # optional
  todowrite: {true|false}  # optional
permissions:
  write:
    "{path_pattern}": "{allow|deny}"
    "**/*.secret": "deny"  # always deny secrets
    "**/.env*": "deny"  # always deny env files
  edit:
    "{path_pattern}": "{allow|deny}"
  bash:
    "rm -rf *": "deny"  # always deny dangerous commands
    "sudo *": "deny"  # always deny sudo
context:
  lazy: true  # always use lazy context loading
---
```

### Frontmatter Guidelines

**Mode**:
- `primary`: Coordinator or specialist agents (top-level)
- `subagent`: Subagents invoked by coordinators

**Temperature**:
- `0.2`: Precise, deterministic work (code generation, implementation, testing)
- `0.3`: Creative work (research, planning, documentation)

**Tools**:
- **Coordinators**: `task: true` (primary tool), `read: true`, `write: true` (for state files), `bash: true` (for git)
- **Specialists**: `read: true`, `write: true`, `edit: true`, `bash: false`, `task: false`
- **Subagents**: `read: true`, `write: true`, `edit: false`, `bash: false`, `task: false`

**Permissions**:
- Always deny: `**/*.secret`, `**/.env*`, `rm -rf *`, `sudo *`
- Allow specific paths based on agent role
- Use `**` for recursive patterns

---

## Agent Structure

All agents follow this structure:

```markdown
# {Agent Name}

**Role**: {One-line role description}

**Purpose**: {Detailed purpose explanation}

---

## Core Responsibilities

- {Responsibility 1}
- {Responsibility 2}
- {Responsibility 3}
...

---

{AGENT_TYPE_SPECIFIC_SECTIONS}

---

## Workflow

<{workflow_name}_workflow>
  <stage id="1" name="{StageName}">
    <action>{What this stage does}</action>
    <process>
      1. {Step 1}
      2. {Step 2}
      3. {Step 3}
      ...
    </process>
    <output>
      - {Output 1}
      - {Output 2}
    </output>
  </stage>
  
  <stage id="2" name="{NextStageName}">
    ...
  </stage>
</{workflow_name}_workflow>

---

## Integration Points

<integrations>
  <{integration_name}>
    <path>{file_path}</path>
    <access>{read|write|read-write}</access>
    <operations>
      - {Operation 1}
      - {Operation 2}
    </operations>
  </{integration_name}>
</integrations>

---

## Output Format

<output_format>
  <success>
    {Success output template}
  </success>
  
  <failure>
    {Failure output template}
  </failure>
</output_format>

---

## Constraints

<constraints>
  <{constraint_category}>
    - {Constraint 1}
    - {Constraint 2}
  </{constraint_category}>
</constraints>

---

## Usage

{How this agent is invoked and used}

**Example**:
```
{Usage example}
```

**Result**:
- {Expected result 1}
- {Expected result 2}
```

---

## Coordinator Agent Template

Use this template for agents that delegate ALL work to subagents.

```markdown
# {Agent Name}

**Role**: {Coordination role}

**Purpose**: Coordinate {subagent_type} subagents to {accomplish_goal}

---

## Core Responsibilities

- {Coordination responsibility 1}
- Delegate to specialized {subagent_type} subagents
- Collect brief summaries and artifact paths from subagents
- {Coordination responsibility 2}
- {Coordination responsibility 3}

---

<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate ALL {work_type} work to subagents.
    DO NOT {execute_work_yourself}. DO NOT {do_task_yourself}.
    
    Your role is COORDINATION and ORCHESTRATION, not execution.
    
    **Correct approach**:
    ```
    task(
      subagent_type="subagents/{category}/{subagent-name}",
      description="{Brief task description}",
      prompt="{Detailed instructions with:
              - {Requirement 1}
              - {Requirement 2}
              - Expected output format (brief summary + artifact paths)}"
    )
    ```
    
    **Incorrect approach** (NEVER DO THIS):
    - {Anti-pattern 1}
    - {Anti-pattern 2}
    - {Anti-pattern 3}
    
    ALWAYS delegate to specialist subagents.
  </instruction>
  
  <instruction id="delegation_workflow">
    For each {task_unit} in the {workflow}:
    
    1. **Determine task type**:
       - {Task type 1}? → Use {subagent-1} subagent
       - {Task type 2}? → Use {subagent-2} subagent
       - {Task type 3}? → Use {subagent-3} subagent
    
    2. **Update {state_tracking}** to {in_progress_status}
    
    3. **Invoke subagent via task tool**:
       ```
       task(
         subagent_type="subagents/{category}/{subagent}",
         description="Brief task description",
         prompt="Detailed instructions with:
                 - {Requirement 1}
                 - {Requirement 2}
                 - Expected output format (brief summary + artifact paths)"
       )
       ```
    
    4. **Receive brief summary** from subagent (1-2 paragraphs)
    
    5. **Update {state_tracking}** to {completed_status}
    
    Never skip step 3. Always use the task tool for {work_type} work.
  </instruction>
  
  <instruction id="parallel_execution">
    When executing {parallel_unit} with multiple independent {tasks}:
    
    1. Identify {tasks} in current {parallel_unit} (no dependencies between them)
    2. Update all {task} statuses to {in_progress_status}
    3. Launch all subagents simultaneously using task tool (max 5 concurrent)
    4. Monitor completion status
    5. Collect brief summaries as they complete
    6. Update {task} statuses to {completed_status}
    7. {Post_processing_step}
    8. Move to next {parallel_unit}
    
    Example for {parallel_unit} with 3 parallel {tasks}:
    ```
    # Launch all three simultaneously
    task(subagent_type="subagents/{category}/{subagent-1}", ...)
    task(subagent_type="subagents/{category}/{subagent-2}", ...)
    task(subagent_type="subagents/{category}/{subagent-3}", ...)
    
    # Receive 3 brief summaries
    # Update {task} statuses
    # {Post_processing_step}
    ```
  </instruction>
</critical_instructions>

---

<tool_usage>
  <task_tool>
    **Primary tool for this agent**. Use to delegate ALL {work_type} work.
    
    **Syntax**:
    ```
    task(
      subagent_type="subagents/{category}/{subagent-name}",
      description="Brief description (1 sentence)",
      prompt="Detailed instructions including:
              - {Requirement 1}
              - {Requirement 2}
              - {Path information}
              - Expected output format (brief summary + artifact paths)"
    )
    ```
    
    **Available subagents**:
    - `subagents/{category}/{subagent-1}` - {Description}
    - `subagents/{category}/{subagent-2}` - {Description}
    - `subagents/{category}/{subagent-3}` - {Description}
    
    **When to use**:
    - ALWAYS for {task_type_1}
    - ALWAYS for {task_type_2}
    - ALWAYS for {task_type_3}
    - ANY {work_type} work
    
    **Never**:
    - {Anti-pattern 1}
    - {Anti-pattern 2}
    - Skip delegation for "simple" {tasks}
  </task_tool>
  
  <read_tool>
    Use to read:
    - {Allowed_read_1}
    - {Allowed_read_2}
    
    DO NOT use to read:
    - {Prohibited_read_1} (delegate to {subagent})
    - {Prohibited_read_2} (delegate to {subagent})
  </read_tool>
  
  <write_tool>
    Use ONLY for:
    - {Allowed_write_1}
    - {Allowed_write_2}
    
    DO NOT use for:
    - {Prohibited_write_1} (delegate to {subagent})
    - {Prohibited_write_2} (delegate to {subagent})
  </write_tool>
  
  <bash_tool>
    Use for:
    - Git commits (after {completion_event})
    - Git status checks
    - Directory operations (if needed)
    
    DO NOT use for:
    - {Prohibited_bash_1} (delegate to {subagent})
    - {Prohibited_bash_2} (delegate to {subagent})
  </bash_tool>
</tool_usage>

---

## Workflow

<{workflow_name}_workflow>
  <stage id="1" name="{InitialStage}">
    <action>{Initial action}</action>
    <process>
      1. {Step 1}
      2. {Step 2}
      ...
    </process>
    <output>
      - {Output 1}
      - {Output 2}
    </output>
  </stage>
  
  <stage id="2" name="{DelegationStage}">
    <action>Invoke {subagent_type} subagents in parallel</action>
    <process>
      1. **INVOKE SUBAGENTS VIA TASK TOOL** (1-5 concurrent, max 5):
         
         For each {task_unit}, use task tool with appropriate subagent:
         
         **{Task_Type_1}**:
         ```
         task(
           subagent_type="subagents/{category}/{subagent-1}",
           description="{Task description}",
           prompt="{Task details}
                   
                   {Requirement 1}:
                   {Specification}
                   
                   {Requirement 2}:
                   {Specification}
                   
                   Expected output:
                   - Brief summary (1-2 paragraphs)
                   - {Output 1}
                   - {Output 2}
                   - Artifact path"
         )
         ```
         
         **{Task_Type_2}**:
         ```
         task(
           subagent_type="subagents/{category}/{subagent-2}",
           description="{Task description}",
           prompt="{Task details}
                   
                   {Requirement 1}:
                   {Specification}
                   
                   Expected output:
                   - Brief summary (1-2 paragraphs)
                   - {Output 1}
                   - Artifact path"
         )
         ```
      
      2. Subagents write findings to their artifact files
      3. Subagents return brief summary (1-2 paragraphs) + artifact path
      4. **Collect all summaries** without reading full artifacts
      5. **Never use read tool on artifact files** - only use summaries
    </process>
    <subagent_types>
      - {subagent-1}: {Description}
      - {subagent-2}: {Description}
      - {subagent-3}: {Description}
    </subagent_types>
    <context_preservation>
      - Subagents return brief summaries only
      - Full artifacts written to files
      - Coordinator never reads full artifacts
      - 95% context reduction through metadata passing
    </context_preservation>
    <output>
      - Brief summaries from each subagent
      - Artifact file paths
      - Completion status
    </output>
  </stage>
  
  <stage id="3" name="{SynthesisStage}">
    <action>{Synthesis action}</action>
    <process>
      1. Compile brief summaries from all subagents
      2. {Synthesis step 1}
      3. {Synthesis step 2}
      ...
    </process>
    <output>
      - {Synthesized output}
    </output>
  </stage>
  
  <stage id="4" name="{FinalizationStage}">
    <action>{Finalization action}</action>
    <process>
      1. {Finalization step 1}
      2. {Finalization step 2}
      3. Commit to git
      4. Update state files
    </process>
    <output>
      - {Final output}
      - Commit hash
    </output>
  </stage>
</{workflow_name}_workflow>

---

## {Subagent_Type} Coordination

<subagent_coordination>
  <parallel_execution>
    <max_concurrent>5 subagents</max_concurrent>
    <strategy>
      - Launch all subagents simultaneously
      - Monitor completion status
      - Collect results as they complete
      - No blocking on individual subagent completion
    </strategy>
  </parallel_execution>
  
  <subagent_invocation>
    <pattern>
      For each {task_unit}:
        1. Create artifact file: {artifact_path_pattern}
        2. Write {task_context} at top of file
        3. Invoke appropriate subagent via Task tool
        4. Pass: artifact_path, {requirement_1}, {requirement_2}
        5. Receive: brief_summary, artifact_path, {metadata}
    </pattern>
  </subagent_invocation>
  
  <error_handling>
    <subagent_failure>
      - Log error to .opencode/logs/errors.log
      - Continue with other subagents (partial success)
      - Mark failed {task_unit} in {output_artifact}
      - Include error summary in final report
    </subagent_failure>
    <retry_logic>
      - Retry failed subagent once after 2s delay
      - If retry fails, mark as incomplete
      - Proceed with available {results}
    </retry_logic>
  </error_handling>
</subagent_coordination>

---

## Delegation Examples

<delegation_examples>
  <example_1>
    <scenario>{Example scenario 1}</scenario>
    <{task_units}>{Number} {task_units} ({task_type_1}, {task_type_2}, {task_type_3})</{task_units}>
    <invocation>
      ```
      # {Task_Unit} 1: {Task_Type_1}
      task(
        subagent_type="subagents/{category}/{subagent-1}",
        description="{Task description}",
        prompt="{Task details}
                
                {Requirement 1}:
                {Specification}
                
                Expected output:
                - Brief summary (1-2 paragraphs)
                - {Output 1}
                - Artifact path"
      )
      
      # {Task_Unit} 2: {Task_Type_2}
      task(
        subagent_type="subagents/{category}/{subagent-2}",
        description="{Task description}",
        prompt="{Task details}
                
                {Requirement 1}:
                {Specification}
                
                Expected output:
                - Brief summary (1-2 paragraphs)
                - {Output 1}
                - Artifact path"
      )
      ```
    </invocation>
    <expected_output>
      {Number} brief summaries from subagents:
      
      1. {Subagent-1}: "{Brief summary text}"
      
      2. {Subagent-2}: "{Brief summary text}"
      
      Coordinator synthesizes these summaries into {output_artifact}.
    </expected_output>
  </example_1>
</delegation_examples>

---

{REMAINING_STANDARD_SECTIONS}
```

---

## Specialist Agent Template

Use this template for agents that execute work directly without delegation.

```markdown
# {Agent Name}

**Role**: {Specialist role}

**Purpose**: {Direct execution purpose}

---

## Core Responsibilities

- {Direct responsibility 1}
- {Direct responsibility 2}
- {Direct responsibility 3}

---

<agent_classification>
  ## Specialist Agent (No Delegation)
  
  The {agent_name} agent is a **SPECIALIST** agent that does NOT delegate to subagents.
  
  ### Why No Delegation?
  
  The {agent_name}'s core competency IS {core_task}. Delegating {core_task} would be counterproductive because:
  
  1. **Specialized Expertise**: The {agent_name} is specifically designed and optimized for {core_task}
  2. **Holistic Understanding**: {Core_task} requires understanding {context}, which can't be easily subdivided
  3. **Direct Execution**: The {agent_name} directly {executes_work} - this is its primary function
  4. **No Benefit from Delegation**: Breaking {core_task} into sub-tasks would add complexity without improving quality or efficiency
  
  ### What the {Agent_Name} Does Directly
  
  ✅ **Direct Execution** (no delegation):
  - {Direct task 1}
  - {Direct task 2}
  - {Direct task 3}
  - {Direct task 4}
  
  ### Contrast with Coordinator Agents
  
  **Coordinator agents** ({coordinator_examples}):
  - Delegate ALL work to specialist subagents
  - Maintain small context (coordination only)
  - Receive brief summaries from subagents
  - Never execute work themselves
  
  **Specialist agents** ({agent_name}):
  - Execute work directly (no delegation)
  - Use their specialized expertise
  - Read and write files themselves
  - Are optimized for their specific task
  
  The {agent_name} is a specialist because {core_task} IS its specialty.
</agent_classification>

---

## Workflow

<{workflow_name}_workflow>
  <stage id="1" name="{Stage1}">
    <action>{Direct action 1}</action>
    <process>
      1. {Direct step 1}
      2. {Direct step 2}
      3. {Direct step 3}
      ...
    </process>
    <output>
      - {Output 1}
      - {Output 2}
    </output>
  </stage>
  
  <stage id="2" name="{Stage2}">
    <action>{Direct action 2}</action>
    <process>
      1. {Direct step 1}
      2. {Direct step 2}
      ...
    </process>
    <output>
      - {Output 1}
    </output>
  </stage>
  
  {ADDITIONAL_STAGES}
</{workflow_name}_workflow>

---

{REMAINING_STANDARD_SECTIONS}
```

---

## Subagent Template

Use this template for subagents invoked by coordinator agents.

```markdown
# {Subagent Name}

**Role**: {Subagent role}

**Purpose**: {Focused task execution purpose}

---

## Core Responsibilities

- {Focused responsibility 1}
- {Focused responsibility 2}
- {Focused responsibility 3}
- Return brief summary with artifact paths

---

## {Task_Type} Workflow

<{workflow_name}_workflow>
  <stage id="1" name="ParseRequirements">
    <action>Understand task requirements from coordinator</action>
    <process>
      1. Receive task specification from coordinator
      2. Parse requirements and constraints
      3. Identify target {artifacts}
      4. Validate prerequisites
    </process>
    <output>
      - Parsed requirements
      - Target {artifacts}
    </output>
  </stage>
  
  <stage id="2" name="Execute{Task}">
    <action>{Execute task action}</action>
    <process>
      1. {Execution step 1}
      2. {Execution step 2}
      3. {Execution step 3}
      ...
    </process>
    <output>
      - {Execution output 1}
      - {Execution output 2}
    </output>
  </stage>
  
  <stage id="3" name="WriteArtifacts">
    <action>Write {artifacts} to files</action>
    <process>
      1. Determine artifact path from requirements
      2. Write {artifact_content} to file
      3. Validate artifact was created successfully
    </process>
    <output>
      - Artifact file path
    </output>
  </stage>
  
  <stage id="4" name="ReturnSummary">
    <action>Create brief summary for coordinator</action>
    <process>
      1. Summarize {task_results} (1-2 paragraphs)
      2. Include artifact paths
      3. Include {metadata}
      4. Return summary to coordinator
    </process>
    <summary_format>
      {Summary template with placeholders}
    </summary_format>
    <output>
      - Brief summary (1-2 paragraphs)
      - Artifact paths
      - {Metadata}
    </output>
  </stage>
</{workflow_name}_workflow>

---

## {Artifact_Type} Patterns

<{artifact_type}_patterns>
  <pattern_1>
    <description>{Pattern description}</description>
    <template>
      ```
      {Pattern template}
      ```
    </template>
  </pattern_1>
  
  <pattern_2>
    <description>{Pattern description}</description>
    <template>
      ```
      {Pattern template}
      ```
    </template>
  </pattern_2>
</{artifact_type}_patterns>

---

## Output Contract

<output>
  <created_artifacts>
    <list>Array of artifact paths created</list>
    <validation>Each artifact exists and is valid</validation>
  </created_artifacts>
  
  <summary_return>
    <format>Brief text summary (1-2 paragraphs)</format>
    <includes>
      - {Artifacts} created with paths
      - {Results} summary
      - {Metadata}
      - Any issues encountered
    </includes>
  </summary_return>
</output>

---

## Error Handling

<error_handling>
  <error_type_1>
    <condition>{Error condition}</condition>
    <action>
      - {Error handling action 1}
      - {Error handling action 2}
      - Return error to coordinator
    </action>
  </error_type_1>
  
  <error_type_2>
    <condition>{Error condition}</condition>
    <action>
      - {Error handling action 1}
      - {Error handling action 2}
    </action>
  </error_type_2>
</error_handling>

---

## Usage

Invoked by {coordinator_agent} for {task_type} tasks.

**Input**:
- `{input_1}`: {Description}
- `{input_2}`: {Description}
- `{input_3}`: {Description}

**Output**:
- Brief summary (1-2 paragraphs)
- Artifact paths
- {Metadata}

**Example**:
```
Task: {Example task}
{Input_1}: {Example value}
{Input_2}: {Example value}

{Task_Type} Result:
"{Example brief summary with artifact paths and metadata}"
```
```

---

## Workflow Stage Patterns

### Standard Stage Structure

```xml
<stage id="{N}" name="{StageName}">
  <action>{What this stage does}</action>
  <process>
    1. {Step 1}
    2. {Step 2}
    3. {Step 3}
    ...
  </process>
  <output>
    - {Output 1}
    - {Output 2}
  </output>
</stage>
```

### Common Stage Types

#### Initialization Stage

```xml
<stage id="1" name="Initialize">
  <action>Set up initial state and validate prerequisites</action>
  <process>
    1. Read input parameters
    2. Validate prerequisites
    3. Initialize state tracking
    4. Create necessary directories
  </process>
  <output>
    - Validated parameters
    - Initial state
  </output>
</stage>
```

#### Delegation Stage (Coordinator Agents)

```xml
<stage id="2" name="DelegateWork">
  <action>Invoke subagents to execute work</action>
  <process>
    1. **INVOKE SUBAGENTS VIA TASK TOOL**:
       
       ```
       task(
         subagent_type="subagents/{category}/{subagent}",
         description="{Task description}",
         prompt="{Detailed instructions}"
       )
       ```
    
    2. Subagents execute work and write artifacts
    3. Subagents return brief summaries
    4. Collect summaries without reading full artifacts
  </process>
  <output>
    - Brief summaries from subagents
    - Artifact paths
  </output>
</stage>
```

#### Execution Stage (Specialist/Subagent)

```xml
<stage id="2" name="ExecuteWork">
  <action>Perform specialized work directly</action>
  <process>
    1. {Execution step 1}
    2. {Execution step 2}
    3. {Execution step 3}
    4. Validate results
  </process>
  <output>
    - {Work product 1}
    - {Work product 2}
  </output>
</stage>
```

#### Synthesis Stage (Coordinator Agents)

```xml
<stage id="3" name="SynthesizeResults">
  <action>Combine subagent summaries into final output</action>
  <process>
    1. Compile brief summaries from all subagents
    2. Identify key findings across summaries
    3. Create synthesized output artifact
    4. Link to detailed subagent artifacts
  </process>
  <output>
    - Synthesized output artifact
    - Links to detailed artifacts
  </output>
</stage>
```

#### Finalization Stage

```xml
<stage id="4" name="Finalize">
  <action>Commit results and update state</action>
  <process>
    1. Stage all created/modified files
    2. Create git commit
    3. Update state files
    4. Log completion
  </process>
  <output>
    - Commit hash
    - Updated state
    - Log entry
  </output>
</stage>
```

---

## Delegation Patterns

### Parallel Delegation (Coordinator Agents)

```markdown
## Parallel Execution Pattern

For {parallel_unit} with multiple independent {tasks}:

1. Identify {tasks} in current {parallel_unit}
2. Launch all subagents simultaneously (max 5 concurrent)
3. Monitor completion status
4. Collect brief summaries as they complete
5. Process results

**Example**:
```
# Launch 3 subagents in parallel
task(subagent_type="subagents/{category}/{subagent-1}", ...)
task(subagent_type="subagents/{category}/{subagent-2}", ...)
task(subagent_type="subagents/{category}/{subagent-3}", ...)

# Receive 3 brief summaries
# Process summaries
```
```

### Sequential Delegation (Coordinator Agents)

```markdown
## Sequential Execution Pattern

For {workflow} with dependencies between {tasks}:

1. Execute {task_1} via subagent
2. Wait for {task_1} completion
3. Use {task_1} results as input to {task_2}
4. Execute {task_2} via subagent
5. Continue sequentially

**Example**:
```
# Task 1: Analyze codebase
task(subagent_type="subagents/analysis/codebase-analyzer", ...)
# Receive summary_1

# Task 2: Generate recommendations based on analysis
task(
  subagent_type="subagents/analysis/recommendation-generator",
  prompt="Based on analysis: {summary_1}..."
)
# Receive summary_2
```
```

### Conditional Delegation

```markdown
## Conditional Delegation Pattern

Delegate only when specific conditions are met:

1. Evaluate condition
2. If condition met:
   - Invoke subagent via task tool
   - Receive brief summary
3. If condition not met:
   - Execute directly or skip

**Example**:
```
if {needs_additional_research}:
  task(
    subagent_type="subagents/research/docs-fetcher",
    description="Fetch additional documentation",
    prompt="..."
  )
else:
  # Use existing research
```
```

---

## Tool Usage Guidelines

### Task Tool (Coordinator Agents Only)

**Purpose**: Delegate work to subagents

**Usage**:
```
task(
  subagent_type="subagents/{category}/{subagent-name}",
  description="Brief description (1 sentence)",
  prompt="Detailed instructions including:
          - {Requirement 1}
          - {Requirement 2}
          - Expected output format (brief summary + artifact paths)"
)
```

**When to use**:
- ALWAYS for work that should be delegated
- NEVER for coordinator's own coordination tasks

### Read Tool

**Purpose**: Read files from filesystem

**Coordinator agents** - Use to read:
- Input parameters
- State files
- Configuration files

**Coordinator agents** - DO NOT use to read:
- Full artifacts from subagents (use summaries only)
- Files that subagents should analyze

**Specialist/Subagent** - Use to read:
- Input files for processing
- Configuration files
- Standards files

### Write Tool

**Purpose**: Write new files

**Coordinator agents** - Use ONLY for:
- State files
- Synthesized output artifacts
- Configuration files

**Coordinator agents** - DO NOT use for:
- Artifacts that subagents should create

**Specialist/Subagent** - Use for:
- Creating new artifacts
- Writing output files

### Edit Tool

**Purpose**: Modify existing files

**Coordinator agents** - Use ONLY for:
- Updating state files
- Updating metadata

**Specialist/Subagent** - Use for:
- Modifying existing artifacts
- Updating configuration files

### Bash Tool

**Purpose**: Execute shell commands

**All agents** - Use for:
- Git operations (commit, status)
- Directory operations (mkdir, ls)

**All agents** - DO NOT use for:
- Dangerous commands (rm -rf, sudo)
- Work that should be delegated to subagents

---

## Output Format Standards

### Success Output

```markdown
## ✅ {Task} Complete: {Subject}

**{Artifact_Type}**: `{artifact_path}`
**Status**: {status_description}

### {Summary_Section}

{High-level summary of results}

### {Details_Section}

{Detailed breakdown of results}

### Next Steps

{Recommended next actions}

**Commit**: {commit_hash} (if applicable)
```

### Partial Success Output

```markdown
## ⚠️ {Task} Partially Complete: {Subject}

**Completed**: {N} of {M} {units}
**Failed**: {List of failed units}

{Success output format}

### Issues Encountered

{List of errors and failures}

**Note**: {Explanation of partial success}
```

### Failure Output

```markdown
## ❌ {Task} Failed: {Subject}

**Error**: {Error message}
**Details**: {Error details}

**Logs**: `{log_path}`

### Recovery Options

1. {Recovery option 1}
2. {Recovery option 2}
3. {Recovery option 3}
```

### Brief Summary Format (Subagents)

Subagents return brief summaries (1-2 paragraphs) to coordinators:

```
{Summary_sentence_1}. {Summary_sentence_2}. {Key_finding_1}. {Key_finding_2}. 
{Metadata}: {value}. Artifact: {artifact_path}. {Issues_if_any}.
```

**Example**:
```
Analyzed 47 Lua files in NeoVim configuration. Found 23 plugins with lazy-loading, 8 without. 
Current setup uses event-based loading for UI plugins. Identified 3 optimization opportunities. 
Confidence: High. Artifact: .opencode/specs/001_lazy_loading/reports/codebase_analysis.md. No issues encountered.
```

---

## Usage Examples

### Example 1: Creating a Coordinator Agent

```markdown
# Research Coordinator Agent

**Role**: Research orchestrator for {domain} analysis

**Purpose**: Coordinate parallel research subagents to gather comprehensive information

---

## Core Responsibilities

- Break research into focused subtopics
- Delegate to specialized research subagents in parallel
- Collect brief summaries from subagents
- Synthesize findings into OVERVIEW.md

---

<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate ALL research work to subagents.
    DO NOT read files yourself. DO NOT fetch documentation yourself.
    
    Your role is COORDINATION and ORCHESTRATION, not execution.
  </instruction>
</critical_instructions>

---

<tool_usage>
  <task_tool>
    **Primary tool for this agent**. Use to delegate ALL research work.
    
    **Available subagents**:
    - `subagents/research/codebase-analyzer` - Analyze codebase
    - `subagents/research/docs-fetcher` - Fetch documentation
    - `subagents/research/best-practices-researcher` - Research best practices
  </task_tool>
</tool_usage>

---

{WORKFLOW_STAGES}

---

{REMAINING_SECTIONS}
```

### Example 2: Creating a Specialist Agent

```markdown
# Planning Specialist Agent

**Role**: Implementation plan creator

**Purpose**: Transform research findings into detailed implementation plans

---

## Core Responsibilities

- Read research reports directly
- Create phased implementation plans
- Define dependencies and waves
- Generate plan metadata

---

<agent_classification>
  ## Specialist Agent (No Delegation)
  
  The planner agent is a **SPECIALIST** agent that does NOT delegate to subagents.
  
  ### Why No Delegation?
  
  The planner's core competency IS plan creation. Delegating plan creation would be counterproductive.
  
  ### What the Planner Does Directly
  
  ✅ **Direct Execution** (no delegation):
  - Reads research reports
  - Analyzes findings
  - Creates implementation plans
  - Defines phases and dependencies
</agent_classification>

---

{WORKFLOW_STAGES}

---

{REMAINING_SECTIONS}
```

### Example 3: Creating a Subagent

```markdown
# Code Generator Subagent

**Role**: Create new code files

**Purpose**: Generate new code following standards and best practices

---

## Core Responsibilities

- Generate new code files
- Follow coding standards
- Add documentation
- Return brief summary with file paths

---

## Generation Workflow

<generation_workflow>
  <stage id="1" name="ParseRequirements">
    <action>Understand generation requirements</action>
    <process>
      1. Receive task specification from coordinator
      2. Parse requirements
      3. Identify target file locations
    </process>
  </stage>
  
  <stage id="2" name="GenerateCode">
    <action>Create code following standards</action>
    <process>
      1. Load standards
      2. Generate code structure
      3. Add documentation
      4. Validate syntax
    </process>
  </stage>
  
  <stage id="3" name="WriteFiles">
    <action>Write generated code to files</action>
    <process>
      1. Write code to file
      2. Validate file creation
    </process>
  </stage>
  
  <stage id="4" name="ReturnSummary">
    <action>Create brief summary for coordinator</action>
    <process>
      1. List created files
      2. Summarize functionality
      3. Return summary
    </process>
  </stage>
</generation_workflow>

---

{REMAINING_SECTIONS}
```

---

## Template Selection Guide

Use this guide to choose the appropriate template:

### Choose Coordinator Agent Template When:

- Agent needs to orchestrate multiple subagents
- Work can be parallelized across specialists
- Context preservation is critical (95% reduction needed)
- Examples: researcher, implementer, tester, documenter

### Choose Specialist Agent Template When:

- Agent's core competency IS the work itself
- Work requires holistic understanding
- Delegation would add complexity without benefit
- Examples: planner, orchestrator

### Choose Subagent Template When:

- Agent executes focused, specialized work
- Agent is invoked by coordinator agents
- Agent returns brief summaries to coordinator
- Examples: code-generator, codebase-analyzer, docs-fetcher

---

## Best Practices

### For All Agents

1. **Clear Purpose**: One-line role description + detailed purpose
2. **Explicit Responsibilities**: Bullet list of core responsibilities
3. **Structured Workflow**: XML-tagged workflow stages with clear steps
4. **Integration Points**: Document all external integrations
5. **Error Handling**: Comprehensive error handling patterns
6. **Usage Examples**: Concrete examples of agent invocation

### For Coordinator Agents

1. **Mandatory Delegation**: Critical instructions section enforcing delegation
2. **Tool Usage**: Explicit tool usage guidelines (task tool primary)
3. **Parallel Execution**: Instructions for parallel subagent invocation
4. **Context Preservation**: Never read full artifacts, only summaries
5. **Delegation Examples**: Concrete examples of subagent invocation

### For Specialist Agents

1. **Agent Classification**: Explain why no delegation is needed
2. **Direct Execution**: List all tasks executed directly
3. **Contrast with Coordinators**: Clarify difference from coordinator agents
4. **Specialized Expertise**: Emphasize specialized knowledge

### For Subagents

1. **Focused Scope**: Single, well-defined responsibility
2. **Brief Summaries**: Return 1-2 paragraph summaries to coordinators
3. **Artifact Paths**: Always include artifact paths in output
4. **Metadata**: Include relevant metadata (confidence, statistics, etc.)
5. **No Further Delegation**: Subagents never delegate to other subagents

---

## Validation Checklist

Before finalizing a new agent, verify:

- [ ] Frontmatter is complete and correct
- [ ] Agent type (coordinator/specialist/subagent) is clear
- [ ] Core responsibilities are listed
- [ ] Workflow stages are structured with XML tags
- [ ] Tool usage is documented (especially task tool for coordinators)
- [ ] Delegation patterns are clear (for coordinators)
- [ ] Output format is specified
- [ ] Error handling is comprehensive
- [ ] Integration points are documented
- [ ] Usage examples are provided
- [ ] Constraints are listed
- [ ] Brief summary format is specified (for subagents)

---

## References

- **Existing Agents**: `.opencode/agent/`
- **Standards**: `/home/benjamin/.config/STANDARDS.md`
- **Lua Coding Standards**: `.opencode/context/standards/lua-coding-standards.md`
- **Documentation Standards**: `.opencode/context/standards/documentation-standards.md`
- **Testing Standards**: `.opencode/context/standards/testing-standards.md`
