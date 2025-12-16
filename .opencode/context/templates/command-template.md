# Command Template

Template for creating new .opencode commands with consistent structure and delegation patterns.

## Template Structure

```markdown
---
description: "{Brief one-line description of what this command does}"
---

<{command_name}_request>
  <{param_1}>$ARGUMENTS[0]</{param_1}>
  <{param_2}>$ARGUMENTS[1]</{param_2}>
  <!-- Add more parameters as needed -->
</_{command_name}_request>

<context>
  <system_context>{High-level system this command operates within}</system_context>
  <domain_context>{Specific domain knowledge or area of focus}</domain_context>
  <task_context>{What this command accomplishes}</task_context>
  <execution_context>{How the command executes - key steps or workflow}</execution_context>
</context>

<role>{Command's role in the system - what it coordinates or executes}</role>

<task>{Single sentence describing the primary task this command performs}</task>

<instructions>
  1. Route this request to the {agent_name} agent: @{agent_name}
  2. Pass the {param_name} from $ARGUMENTS
  3. The {agent_name} will:
     - {Step 1: What the agent does first}
     - {Step 2: Next action}
     - {Step 3: Subsequent actions}
     - {Step 4: Final actions}
  4. Return {what gets returned to user}
</instructions>

<{delegation_or_agent}_behavior>
  ## How the {Agent Name} Works
  
  The {agent_name} agent acts as a **{COORDINATOR|SPECIALIST}**.
  
  ### What the {Agent Name} Does
  
  ✅ **{Coordination|Execution}**:
  - {Primary responsibility 1}
  - {Primary responsibility 2}
  - {Primary responsibility 3}
  - {Primary responsibility 4}
  
  ✅ **State Management** (if applicable):
  - {State management task 1}
  - {State management task 2}
  
  ### What the {Agent Name} Delegates (for COORDINATOR agents)
  
  🔄 **{Category of Work}**:
  - {Task type 1} → `subagents/{category}/{subagent-name}`
  - {Task type 2} → `subagents/{category}/{subagent-name}`
  - {Task type 3} → `subagents/{category}/{subagent-name}`
  
  ### Why {Delegation|No Delegation}?
  
  {For COORDINATOR agents}:
  💡 **Context Window Efficiency**:
  - {Agent name} maintains small context (coordination only)
  - Subagents load only what they need for their task
  - Brief summaries instead of full {artifacts} (95% context reduction)
  - Enables parallel execution of {independent tasks}
  
  💡 **Specialist Expertise**:
  - {subagent-1} knows how to {specialized skill}
  - {subagent-2} knows how to {specialized skill}
  - Each subagent is optimized for its task type
  
  💡 **Better Quality**:
  - Specialists produce higher quality {output}
  - Focused {work type} per {unit of work}
  - Comprehensive {coverage} through {delegation pattern}
  
  {For SPECIALIST agents}:
  💡 **Direct Execution Benefits**:
  - {Task type} IS the {agent}'s core competency
  - Holistic understanding required for {task}
  - No benefit from delegation - would add complexity
  - Direct execution ensures {quality attribute}
  
  ### Example Execution Flow
  
  ```
  User: /{command} {example arguments}
  
  {Agent Name}:
    1. {First action with details}
       - {Sub-detail 1}
       - {Sub-detail 2}
    
    2. {Second action}
    
    3. {For COORDINATOR: Delegates to subagents}
       
       {For parallel execution}:
       task(
         subagent_type="subagents/{category}/{subagent}",
         description="{What this subagent does}",
         prompt="{Specific instructions for subagent}"
       )
       
       task(
         subagent_type="subagents/{category}/{subagent}",
         description="{What this subagent does}",
         prompt="{Specific instructions for subagent}"
       )
    
    4. {For COORDINATOR: Receives brief summaries}
       - {Subagent 1}: "{Brief summary of work done}"
       - {Subagent 2}: "{Brief summary of work done}"
    
    5. {Subsequent actions}
    
    6. {Final action}
    
    7. Returns: "{What gets returned to user}"
  
  Result: {Summary of what was accomplished}
  {For COORDINATOR: Context metrics}
  Context: {Agent} saw ~{N} tokens (summaries) instead of ~{M} tokens (full {artifacts}) = {X}% reduction
  {For parallel execution: Time savings}
  Time: {Parallel pattern} saved {X}% time vs sequential
  ```
</{delegation_or_agent}_behavior>

<usage_examples>
  <example_1>
    <command>/{command} {example args 1}</command>
    <result>{What happens with these arguments}</result>
  </example_1>
  
  <example_2>
    <command>/{command} {example args 2}</command>
    <result>{What happens with these arguments}</result>
  </example_2>
  
  <example_3>
    <command>/{command} {example args 3}</command>
    <result>{What happens with these arguments}</result>
  </example_3>
</usage_examples>
```

## Template Usage Guide

### 1. Frontmatter

The frontmatter contains metadata about the command:

```yaml
---
description: "Brief one-line description (imperative mood: 'Creates...', 'Executes...', 'Analyzes...')"
---
```

**Guidelines**:
- Keep description under 100 characters
- Use imperative mood (action-oriented)
- Focus on what the command does, not how
- Examples: "Creates phased implementation plans", "Executes implementation plans in waves"

### 2. Request Parameters

Define the command's input parameters using XML-style tags:

```xml
<command_name_request>
  <param_name>$ARGUMENTS[0]</param_name>
  <optional_param>$ARGUMENTS[1]</optional_param>
</command_name_request>
```

**Guidelines**:
- Use semantic parameter names (e.g., `plan_path`, `research_prompt`, `topic`)
- Index arguments starting from 0
- Document optional parameters with comments
- Keep parameter structure simple and flat

### 3. Context Section

Provide four levels of context for the command:

```xml
<context>
  <system_context>Broad system this operates within</system_context>
  <domain_context>Specific domain or area of expertise</domain_context>
  <task_context>What this command accomplishes</task_context>
  <execution_context>How it executes (key workflow steps)</execution_context>
</context>
```

**Guidelines**:
- **system_context**: High-level system (e.g., "NeoVim configuration management system")
- **domain_context**: Specific area (e.g., "Plugin optimization and lazy-loading")
- **task_context**: Primary goal (e.g., "Create implementation plans from research")
- **execution_context**: Key workflow (e.g., "Read research, create phases, commit to git")

### 4. Role and Task

Define the command's role and primary task:

```xml
<role>Command's role in the system</role>
<task>Single sentence describing primary task</task>
```

**Guidelines**:
- **role**: What the command coordinates or executes (e.g., "Research coordinator", "Implementation executor")
- **task**: One clear sentence about the primary task
- Keep both concise and action-oriented

### 5. Instructions

Provide step-by-step routing instructions:

```xml
<instructions>
  1. Route this request to the {agent_name} agent: @{agent_name}
  2. Pass the {param_name} from $ARGUMENTS
  3. The {agent_name} will:
     - {Action 1}
     - {Action 2}
     - {Action 3}
  4. Return {output} to user
</instructions>
```

**Guidelines**:
- Always start with routing to the appropriate agent
- Specify which parameters to pass
- List key actions the agent will perform
- Describe what gets returned to the user
- Keep instructions clear and sequential

### 6. Agent Behavior Documentation

This is the most important section - it documents how the agent works and whether it delegates.

#### For COORDINATOR Agents

Use this structure for agents that delegate to subagents:

```xml
<delegation_behavior>
  ## How the {Agent Name} Works
  
  The {agent_name} agent acts as a **COORDINATOR**, not an executor.
  
  ### What the {Agent Name} Does
  
  ✅ **Coordination**:
  - {Coordination task 1}
  - {Coordination task 2}
  
  ✅ **State Management**:
  - {State task 1}
  - {State task 2}
  
  ### What the {Agent Name} Delegates
  
  🔄 **{Work Category}**:
  - {Task type} → `subagents/{category}/{subagent}`
  
  ### Benefits of Delegation
  
  💡 **Context Window Efficiency**:
  - Brief summaries instead of full artifacts (95% context reduction)
  - Enables parallel execution
  
  💡 **Specialist Expertise**:
  - Each subagent optimized for its task
  
  💡 **Better Quality**:
  - Specialists produce higher quality output
  
  ### Example Execution Flow
  
  ```
  User: /{command} {args}
  
  {Agent}:
    1. {Preparation steps}
    2. {Delegation with task() calls}
    3. {Receives brief summaries}
    4. {Synthesis/coordination}
    5. Returns: {output}
  
  Result: {Summary}
  Context: {Context reduction metrics}
  Time: {Time savings from parallelization}
  ```
</delegation_behavior>
```

#### For SPECIALIST Agents

Use this structure for agents that execute directly:

```xml
<agent_behavior>
  ## How the {Agent Name} Works
  
  The {agent_name} agent is a **SPECIALIST** that executes directly (no delegation).
  
  ### Why No Delegation?
  
  1. **Specialized Expertise**: {Task} IS the {agent}'s core competency
  2. **Holistic Understanding**: Requires understanding entire context
  3. **Direct Execution**: Primary function is to {task}
  4. **No Benefit from Delegation**: Would add complexity without improving quality
  
  ### What the {Agent Name} Does
  
  ✅ **Direct Execution**:
  - {Task 1}
  - {Task 2}
  - {Task 3}
  
  ### Example Execution Flow
  
  ```
  User: /{command} {args}
  
  {Agent}:
    1. {Direct execution steps}
    2. {Processing}
    3. {Output generation}
    4. Returns: {output}
  
  Result: {Summary of direct execution}
  ```
</agent_behavior>
```

**Guidelines**:
- Clearly identify agent type: COORDINATOR or SPECIALIST
- For coordinators: Document delegation pattern, subagents used, and benefits
- For specialists: Explain why direct execution is preferred
- Include realistic execution flow example with actual task() calls for coordinators
- Show context reduction metrics for coordinators (e.g., "95% reduction")
- Show time savings for parallel execution (e.g., "40-60% time savings")

### 7. Usage Examples

Provide 2-3 concrete usage examples:

```xml
<usage_examples>
  <example_1>
    <command>/{command} {realistic args}</command>
    <result>{What happens}</result>
  </example_1>
  
  <example_2>
    <command>/{command} {different args}</command>
    <result>{Different outcome}</result>
  </example_2>
</usage_examples>
```

**Guidelines**:
- Use realistic file paths and arguments
- Show different use cases or scenarios
- Keep results concise but informative
- Demonstrate command flexibility

## Command Types and Patterns

### Primary Workflow Commands

Commands that coordinate major workflows (research, planning, implementation):

- **Pattern**: COORDINATOR agents with parallel subagent delegation
- **Examples**: `/research`, `/implement`, `/revise`
- **Key Features**:
  - Break work into subtasks
  - Delegate to specialized subagents
  - Synthesize results
  - Update state and commit to git

### Specialist Commands

Commands that perform focused tasks directly:

- **Pattern**: SPECIALIST agents with direct execution
- **Examples**: `/plan`, `/health-check`
- **Key Features**:
  - Execute task directly
  - No delegation needed
  - Specialized expertise
  - Return focused output

### Utility Commands

Commands that provide information or perform simple operations:

- **Pattern**: Simple execution, minimal coordination
- **Examples**: `/help`, `/show-state`, `/todo`
- **Key Features**:
  - Read and display information
  - Simple state queries
  - No complex delegation
  - Quick execution

## Context Loading Strategy

Commands should load relevant context files based on their needs:

### For Research Commands
- `context/standards/lua-coding-standards.md`
- `context/standards/plugin-standards.md`
- `context/domain/{relevant-domain}.md`

### For Planning Commands
- `context/templates/plan-template.md`
- `context/processes/planning-workflow.md`
- `context/standards/validation-rules.md`

### For Implementation Commands
- `context/processes/implementation-workflow.md`
- `context/standards/testing-standards.md`
- `context/processes/git-integration.md`

### For Documentation Commands
- `context/standards/documentation-standards.md`
- `context/templates/commit-message-template.md`

## Agent Routing Patterns

### Direct Agent Routing

For commands that route to a single agent:

```xml
<instructions>
  1. Route this request to the {agent_name} agent: @{agent_name}
  2. Pass the {param} from $ARGUMENTS
  3. The {agent_name} will {perform task}
  4. Return {output} to user
</instructions>
```

### Conditional Routing

For commands that may route to different agents based on input:

```xml
<instructions>
  1. Analyze the {input parameter}
  2. If {condition}, route to @{agent_1}
  3. If {other condition}, route to @{agent_2}
  4. Pass appropriate parameters
  5. Return results to user
</instructions>
```

### Subagent Delegation

For coordinator agents that delegate to subagents (documented in agent_behavior section):

```
task(
  subagent_type="subagents/{category}/{subagent-name}",
  description="Brief description of what this subagent does",
  prompt="Detailed instructions for the subagent including context and requirements"
)
```

## Input Validation

Commands should validate inputs before routing to agents:

```xml
<instructions>
  1. Validate {param_1} exists and is {valid format}
  2. Check {param_2} meets {requirements}
  3. If validation fails, return error message
  4. If validation passes, route to @{agent_name}
  5. Return results to user
</instructions>
```

## Output Format

Commands should specify expected output format:

### For File Creation
- Return file path(s) created
- Include brief summary of contents
- Mention git commit if applicable

### For Analysis/Research
- Return path to OVERVIEW.md or summary file
- List key findings
- Include links to detailed reports

### For Execution
- Return execution status
- List completed phases/tasks
- Include commit hashes if applicable

### For Information Display
- Format output clearly
- Organize by category or priority
- Include actionable next steps

## Error Handling

Commands should handle common error scenarios:

```xml
<instructions>
  1. Validate inputs
  2. If {error condition}:
     - Return clear error message
     - Suggest corrective action
     - Do not proceed to agent routing
  3. If validation passes, route to agent
  4. If agent returns error:
     - Parse error message
     - Provide user-friendly explanation
     - Suggest next steps
</instructions>
```

## Standards Compliance

All commands must follow:

1. **Markdown Formatting**: Use proper CommonMark syntax
2. **XML Structure**: Well-formed XML tags for structured data
3. **Naming Conventions**: Use kebab-case for command names, snake_case for parameters
4. **Documentation**: Include comprehensive agent behavior documentation
5. **Examples**: Provide realistic, tested usage examples
6. **Context**: Load appropriate context files for the task
7. **Delegation**: Clearly document delegation patterns and benefits

## Testing New Commands

After creating a command:

1. Test with various argument combinations
2. Verify agent routing works correctly
3. Check output format matches specification
4. Validate error handling for edge cases
5. Ensure documentation is clear and accurate
6. Test integration with existing workflows

## Migration from Old Patterns

If updating an existing command:

1. Add frontmatter if missing
2. Restructure to match template sections
3. Add comprehensive agent_behavior or delegation_behavior section
4. Update examples to be more realistic
5. Add context loading strategy
6. Document delegation patterns clearly
7. Include execution flow examples with metrics
