# Delegation Best Practices

**Version**: 1.0  
**Date**: 2025-12-15  
**Status**: Active

---

## Overview

This guide documents best practices for delegation patterns in the NeoVim configuration management system. It provides templates, examples, and guidelines for creating coordinator and specialist agents.

---

## Agent Classification

### Coordinator Agents

**Definition**: Agents that delegate ALL work to specialist subagents.

**Characteristics**:
- Use task tool for all work execution
- Maintain small context (coordination only)
- Receive brief summaries from subagents (95% context reduction)
- Enable parallel execution (40-60% time savings)
- Never execute work themselves

**Examples**:
- Researcher (delegates to research subagents)
- Implementer (delegates to implementation subagents)
- Tester (delegates to test subagents)
- Documenter (delegates to documentation subagents)

### Specialist Agents

**Definition**: Agents that execute work directly without delegation.

**Characteristics**:
- Execute work themselves (no subagents)
- Use specialized expertise for their specific task
- Read and write files directly
- No benefit from delegation

**Examples**:
- Planner (plan creation IS its specialty)
- Orchestrator (routing IS its specialty)

### Conditional Coordinators

**Definition**: Agents that delegate only when specific conditions are met.

**Characteristics**:
- Delegate conditionally based on requirements
- Read existing artifacts directly when sufficient
- Flexible approach based on task needs

**Examples**:
- Reviser (delegates only when new research is needed)

---

## Coordinator Agent Template

### Frontmatter

```yaml
---
description: "{Agent description}"
mode: primary
temperature: 0.2-0.3
tools:
  read: true
  write: true
  edit: true
  bash: true
  task: true  # REQUIRED for coordinators
  glob: true
  grep: true
permissions:
  write:
    "{allowed_paths}": "allow"
    "**/*": "deny"
  bash:
    "rm -rf *": "deny"
    "sudo *": "deny"
context:
  lazy: true
---
```

### Critical Instructions Section

```markdown
<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate ALL {work_type} to subagents.
    DO NOT {execute_work} yourself. DO NOT {read_files} yourself.
    DO NOT {conduct_analysis} yourself.
    
    Your role is COORDINATION and ORCHESTRATION, not execution.
    
    **Correct approach**:
    ```
    task(
      subagent_type="subagents/{category}/{subagent-name}",
      description="{Brief task description}",
      prompt="{Detailed instructions with:
              - {Specific requirements}
              - {File paths}
              - Expected output format (brief summary + {artifacts})}"
    )
    ```
    
    **Incorrect approach** (NEVER DO THIS):
    - {Executing work yourself}
    - {Reading files yourself}
    - {Conducting analysis yourself}
    
    ALWAYS delegate to specialist subagents.
  </instruction>
  
  <instruction id="delegation_workflow">
    For each {task_type}:
    
    1. **Determine {task_subtype}**:
       - {Subtype 1}? → Use {subagent-1} subagent
       - {Subtype 2}? → Use {subagent-2} subagent
       - {Subtype 3}? → Use {subagent-3} subagent
    
    2. **Invoke subagent via task tool**:
       ```
       task(
         subagent_type="subagents/{category}/{subagent}",
         description="Brief task description",
         prompt="Detailed instructions with:
                 - {Requirements}
                 - {File paths}
                 - Expected output format (brief summary + {artifacts})"
       )
       ```
    
    3. **Receive brief summary** from subagent (1-2 paragraphs)
    
    4. **{Aggregate/Process} results**
    
    Never skip step 2. Always use the task tool for {work_type}.
  </instruction>
  
  <instruction id="parallel_execution">
    When {executing_multiple_tasks}:
    
    1. Identify independent {tasks}
    2. Launch all subagents simultaneously using task tool (max 5 concurrent)
    3. Monitor completion status
    4. Collect brief summaries as they complete
    5. {Aggregate/Synthesize} results
    
    Example for 3 {tasks}:
    ```
    # Launch all three simultaneously
    task(subagent_type="subagents/{category}/{subagent-1}", ...)
    task(subagent_type="subagents/{category}/{subagent-2}", ...)
    task(subagent_type="subagents/{category}/{subagent-3}", ...)
    
    # Receive 3 brief summaries
    # {Aggregate/Synthesize} results
    ```
  </instruction>
</critical_instructions>
```

### Tool Usage Section

```markdown
<tool_usage>
  <task_tool>
    **Primary tool for this agent**. Use to delegate ALL {work_type}.
    
    **Syntax**:
    ```
    task(
      subagent_type="subagents/{category}/{subagent-name}",
      description="Brief description (1 sentence)",
      prompt="Detailed instructions including:
              - {Requirements}
              - {File paths}
              - {Standards path}
              - Expected output format (brief summary + {artifacts})"
    )
    ```
    
    **Available subagents**:
    - `subagents/{category}/{subagent-1}` - {Description}
    - `subagents/{category}/{subagent-2}` - {Description}
    - `subagents/{category}/{subagent-3}` - {Description}
    
    **When to use**:
    - ALWAYS for {work_type_1}
    - ALWAYS for {work_type_2}
    - ALWAYS for {work_type_3}
    - ANY {work_type}
    
    **Never**:
    - {Execute work yourself}
    - {Read files yourself}
    - Skip delegation for "simple" {tasks}
  </task_tool>
  
  <read_tool>
    Use to read:
    - {Allowed reads}
    
    DO NOT use to read:
    - {Prohibited reads (delegate instead)}
  </read_tool>
  
  <write_tool>
    Use ONLY for:
    - {Allowed writes}
    
    DO NOT use for:
    - {Prohibited writes (delegate instead)}
  </write_tool>
  
  <edit_tool>
    Use ONLY for:
    - {Allowed edits}
    
    DO NOT use for:
    - {Prohibited edits (delegate instead)}
  </edit_tool>
  
  <bash_tool>
    Use for:
    - {Allowed bash operations}
    
    DO NOT use for:
    - {Prohibited bash operations (delegate instead)}
  </bash_tool>
</tool_usage>
```

### Delegation Examples Section

```markdown
## Delegation Examples

<delegation_examples>
  <example_1>
    <scenario>{Scenario description}</scenario>
    <{task_type}>{Task type}</task_type>
    <invocation>
      ```
      task(
        subagent_type="subagents/{category}/{subagent}",
        description="{Brief description}",
        prompt="{Detailed instructions with:
                - Requirements
                - File paths
                - Expected output}"
      )
      ```
    </invocation>
    <expected_output>
      "{Brief summary from subagent with key results and artifact paths}"
    </expected_output>
  </example_1>
  
  <example_2>
    <scenario>{Another scenario}</scenario>
    <{task_type}>{Another task type}</task_type>
    <invocation>
      ```
      task(...)
      ```
    </invocation>
    <expected_output>
      "{Brief summary}"
    </expected_output>
  </example_2>
  
  <example_3>
    <scenario>{Parallel execution scenario}</scenario>
    <{task_types}>Multiple {task types}</task_types>
    <invocation>
      ```
      # Task 1 (parallel)
      task(subagent_type="subagents/{category}/{subagent-1}", ...)
      
      # Task 2 (parallel)
      task(subagent_type="subagents/{category}/{subagent-2}", ...)
      
      # Task 3 (parallel)
      task(subagent_type="subagents/{category}/{subagent-3}", ...)
      
      # All execute simultaneously
      # Receive 3 brief summaries
      # Aggregate results
      ```
    </invocation>
    <expected_output>
      Three brief summaries from subagents:
      
      1. {Subagent 1}: "{Summary 1}"
      
      2. {Subagent 2}: "{Summary 2}"
      
      3. {Subagent 3}: "{Summary 3}"
      
      Overall: {Aggregated result}
    </expected_output>
  </example_3>
</delegation_examples>
```

---

## Specialist Agent Template

### Frontmatter

```yaml
---
description: "{Agent description}"
mode: primary
temperature: 0.2-0.3
tools:
  read: true
  write: true
  edit: true
  bash: false  # Usually false for specialists
  task: false  # REQUIRED: false for specialists
  glob: true
  grep: true
permissions:
  write:
    "{allowed_paths}": "allow"
    "**/*": "deny"
context:
  lazy: true
---
```

### Agent Classification Section

```markdown
<agent_classification>
  ## Specialist Agent (No Delegation)
  
  The {agent_name} agent is a **SPECIALIST** agent that does NOT delegate to subagents.
  
  ### Why No Delegation?
  
  The {agent_name}'s core competency IS {work_type}. Delegating {work_type} would be counterproductive because:
  
  1. **Specialized Expertise**: The {agent_name} is specifically designed and optimized for {work_type}
  2. **Holistic Understanding**: {Work_type} requires understanding {context}, which can't be easily subdivided
  3. **Direct Execution**: The {agent_name} directly {executes_work} - this is its primary function
  4. **No Benefit from Delegation**: Breaking {work_type} into sub-tasks would add complexity without improving quality or efficiency
  
  ### What the {Agent Name} Does Directly
  
  ✅ **Direct Execution** (no delegation):
  - {Task 1}
  - {Task 2}
  - {Task 3}
  - {Task 4}
  
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
  
  The {agent_name} is a specialist because {work_type} IS its specialty.
</agent_classification>
```

---

## Best Practices

### For Coordinator Agents

1. **Always Use Task Tool**: Never execute work yourself - always delegate
2. **Brief Summaries Only**: Never read full reports/code/output - only receive summaries
3. **Parallel Execution**: Launch independent subagents simultaneously (max 5)
4. **Clear Prompts**: Provide detailed instructions to subagents with expected output format
5. **Context Efficiency**: Maintain small context through delegation (95% reduction)

### For Specialist Agents

1. **Direct Execution**: Execute work directly without delegation
2. **Specialized Expertise**: Use your specialized knowledge for your specific task
3. **Document Why**: Clearly explain why delegation would not be beneficial
4. **Optimize for Task**: Focus on optimizing for your specific function

### For All Agents

1. **Clear Role Definition**: Document whether agent is coordinator or specialist
2. **Explicit Instructions**: Use critical_instructions section for mandatory behaviors
3. **Tool Documentation**: Document all tools with allowed/prohibited uses
4. **Concrete Examples**: Provide 3+ delegation examples with complete task() calls
5. **Expected Output**: Always specify expected output format in prompts

---

## Context Window Efficiency

### Coordinator Agents

**Goal**: 95%+ context reduction through brief summaries

**Pattern**:
- Subagent writes full report/code/output to file
- Subagent returns brief summary (1-2 paragraphs) + file path
- Coordinator never reads full file - only uses summary
- Result: Coordinator sees ~500 tokens instead of ~10,000 tokens

**Example**:
```
Researcher → Codebase Analyzer:
  Full report: 2,000 tokens (written to file)
  Brief summary: 100 tokens (returned to researcher)
  Context reduction: 95%
```

### Parallel Execution

**Goal**: 40-60% time savings through parallelism

**Pattern**:
- Identify independent tasks (no dependencies)
- Launch all subagents simultaneously (max 5)
- Monitor completion status
- Collect brief summaries as they complete

**Example**:
```
Sequential: 3 tasks × 2 minutes = 6 minutes
Parallel: max(2, 2, 2) = 2 minutes
Time savings: 67%
```

---

## Common Pitfalls

### For Coordinator Agents

❌ **Reading files yourself**: Always delegate to subagents  
❌ **Executing work yourself**: Always use task tool  
❌ **Reading full reports**: Only use brief summaries  
❌ **Sequential execution**: Use parallel execution when possible  
❌ **Vague prompts**: Provide detailed instructions to subagents

### For Specialist Agents

❌ **Unnecessary delegation**: Don't delegate when you're the specialist  
❌ **Unclear role**: Document why you don't delegate  
❌ **Missing expertise**: Ensure you have the specialized knowledge needed

---

## Validation Checklist

### Coordinator Agent Checklist

- [ ] `task: true` in frontmatter
- [ ] Critical instructions section with mandatory delegation
- [ ] Tool usage section documenting all tools
- [ ] 3+ delegation examples with complete task() calls
- [ ] All work delegated via task tool (no direct execution)
- [ ] Brief summaries only (no full file reads)
- [ ] Parallel execution pattern documented

### Specialist Agent Checklist

- [ ] `task: false` in frontmatter
- [ ] Agent classification section explaining why no delegation
- [ ] Clear documentation of specialized expertise
- [ ] Direct execution pattern documented
- [ ] Contrast with coordinator agents explained

---

## Examples from System

### Coordinator: Researcher

**Delegates to**: research subagents (codebase-analyzer, docs-fetcher, best-practices-researcher, dependency-analyzer, refactor-finder)

**Pattern**: Mandatory delegation for all research work

**Context Reduction**: 95% (sees ~500 tokens instead of ~10,000)

**Parallel Execution**: Launches 1-5 research subagents simultaneously

### Coordinator: Implementer

**Delegates to**: implementation subagents (code-generator, code-modifier, test-runner, doc-generator)

**Pattern**: Mandatory delegation for all implementation work

**Wave-Based**: Organizes phases into waves for parallel execution

**Time Savings**: 40-60% through parallel wave execution

### Conditional: Reviser

**Delegates to**: research subagents (conditionally)

**Pattern**: Delegates only when new research is needed

**Flexibility**: Reads existing artifacts directly when sufficient

### Specialist: Planner

**No Delegation**: Creates plans directly

**Reason**: Plan creation IS the planner's specialty

**Expertise**: Specialized in transforming research into phased plans

---

## Migration Guide

### Converting Specialist to Coordinator

1. Change `task: false` to `task: true` in frontmatter
2. Add critical instructions section with mandatory delegation
3. Add tool usage section documenting task tool
4. Update workflow to use task() calls instead of direct execution
5. Add delegation examples (3+)
6. Update command documentation with delegation behavior

### Converting Coordinator to Specialist

1. Change `task: true` to `task: false` in frontmatter
2. Add agent classification section explaining why no delegation
3. Remove critical instructions section (if present)
4. Update workflow to show direct execution
5. Document specialized expertise
6. Update command documentation with specialist behavior

---

**Last Updated**: 2025-12-15  
**Version**: 1.0
