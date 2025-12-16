# Global Implementer Agent Delegation Optimization Plan

**Status**: Proposed  
**Priority**: High  
**Estimated Effort**: 3-4 hours  
**Impact**: Improved delegation enforcement and context window efficiency  
**Scope**: Global NeoVim configuration system

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Current State Analysis](#current-state-analysis)
3. [Comparison with ProofChecker Implementation](#comparison-with-proofchecker-implementation)
4. [Issues Identified](#issues-identified)
5. [Proposed Solution](#proposed-solution)
6. [Implementation Plan](#implementation-plan)
7. [Testing Strategy](#testing-strategy)
8. [Success Metrics](#success-metrics)
9. [References](#references)

---

## Executive Summary

### Current State

The global Implementer agent at `/home/benjamin/.config/.opencode/agent/implementer.md` is **better structured** than the ProofChecker version but still has **delegation enforcement issues** that could lead to the agent doing work itself instead of properly delegating to subagents.

### Key Findings

✅ **What's Working Well**:
1. **Explicit tool permissions** - `task: true` is present in frontmatter
2. **Detailed workflow** - Comprehensive stage-by-stage process
3. **Subagent coordination section** - Clear documentation of subagent types
4. **Wave-based parallelization** - Advanced coordination pattern
5. **Phase status management** - Robust state tracking

⚠️ **What Needs Improvement**:
1. **No explicit task tool invocation examples** - Workflow describes delegation conceptually but doesn't show HOW to use the `task` tool
2. **Ambiguous delegation instructions** - Says "invoke" and "delegate" but doesn't mandate using the `task` tool
3. **Missing critical instructions** - No prominent section forcing delegation over self-execution
4. **Subagent paths not validated** - Uses generic names like "code-generator" without full paths

### Recommended Actions

1. **Add explicit task tool invocation examples** in workflow stages
2. **Create critical instructions section** emphasizing mandatory delegation
3. **Validate and document subagent paths** (e.g., `subagents/implementation/code-generator`)
4. **Add tool usage documentation** showing concrete `task()` syntax
5. **Update /implement command** to clarify delegation behavior

### Expected Benefits

- **Guaranteed delegation** to specialist subagents
- **Reduced context window usage** for Implementer agent
- **Improved consistency** in implementation execution
- **Better error handling** through specialist subagents
- **Clearer debugging** when issues occur

---

## Current State Analysis

### File Structure

```
/home/benjamin/.config/.opencode/
├── agent/
│   ├── implementer.md                    # Primary implementation manager
│   └── subagents/
│       └── implementation/
│           ├── code-generator.md         # Creates new code
│           └── code-modifier.md          # Modifies existing code
└── command/
    └── implement.md                      # /implement command
```

### Implementer Agent Configuration

**File**: `/home/benjamin/.config/.opencode/agent/implementer.md`

**Frontmatter** (Lines 1-22):
```yaml
---
description: "Implementation executor with wave-based parallelization and phase tracking"
mode: primary
temperature: 0.2
tools:
  read: true
  write: true
  edit: true
  bash: true
  task: true      # ✅ GOOD: Explicitly enabled
  glob: true
  grep: true
permissions:
  write:
    "/home/benjamin/.config/nvim/**": "allow"
    ".opencode/specs/**": "allow"
  bash:
    "rm -rf *": "deny"
    "sudo *": "deny"
context:
  lazy: true
---
```

**✅ Strengths**:
- `task: true` explicitly enabled
- Comprehensive tool permissions
- Lazy context loading
- Proper permission restrictions

### Workflow Analysis

**Stage 5: ExecutePhase** (Lines 131-173):

```markdown
<stage id="5" name="ExecutePhase">
  <action>Execute single phase via implementation subagents</action>
  <process>
    1. Update phase status: [NOT STARTED] → [IN PROGRESS]
    2. Write updated plan file
    3. Determine phase type (code gen, code mod, testing, docs)
    4. Invoke appropriate implementation subagent(s)  # ⚠️ VAGUE
    5. Pass phase details (tasks, files, success criteria)
    6. Receive brief summary + artifact paths
    7. Validate phase completion
    8. Update phase status: [IN PROGRESS] → [COMPLETED]/[BLOCKED]
    9. Write updated plan file
    10. Commit if completed
  </process>
  <subagent_delegation>
    <code_generation>
      - Invoke: code-generator subagent  # ⚠️ NO TASK TOOL SYNTAX
      - Pass: files to create, specifications, standards
      - Receive: created files, brief summary
    </code_generation>
    <code_modification>
      - Invoke: code-modifier subagent  # ⚠️ NO TASK TOOL SYNTAX
      - Pass: files to modify, changes needed, standards
      - Receive: modified files, brief summary
    </code_modification>
    ...
  </subagent_delegation>
</stage>
```

**⚠️ Issues**:
1. Says "Invoke" but doesn't show `task()` syntax
2. No explicit instruction to USE the task tool
3. LLM could interpret "invoke" as "do it yourself"
4. No examples of actual tool calls

### Subagent Coordination Section

**Lines 334-385**:

```markdown
<subagent_coordination>
  <parallel_execution>
    <max_concurrent>5 subagents</max_concurrent>
    <strategy>
      - Launch all phases in wave simultaneously
      - Monitor completion status
      - Collect results as they complete
      - No blocking on individual phase completion
    </strategy>
  </parallel_execution>
  
  <subagent_types>
    <code_generator>
      <purpose>Create new Lua modules, plugin configs</purpose>
      <input>File specs, standards, templates</input>
      <output>Created files, brief summary</output>
    </code_generator>
    <code_modifier>
      <purpose>Refactor existing configs, update code</purpose>
      <input>Files to modify, changes needed, standards</input>
      <output>Modified files, brief summary</output>
    </code_modifier>
    ...
  </subagent_types>
</subagent_coordination>
```

**⚠️ Issues**:
1. Describes subagents conceptually
2. Doesn't show HOW to invoke them
3. No `task()` tool examples
4. No subagent paths specified

### Subagent Files

**code-generator.md** (Lines 1-19):
```yaml
---
description: "Creates new Lua modules, plugin configurations, and NeoVim code"
mode: subagent
temperature: 0.2
tools:
  read: true
  write: true
  edit: false
  bash: false
  task: false     # ✅ GOOD: Subagent doesn't delegate further
  glob: true
  grep: true
permissions:
  write:
    "/home/benjamin/.config/nvim/**": "allow"
    "**/*": "deny"
context:
  lazy: true
---
```

**✅ Strengths**:
- Proper subagent mode
- Focused tool permissions
- Lazy context loading
- Clear output contract

**code-modifier.md** - Similar structure, equally well-designed

---

## Comparison with ProofChecker Implementation

### Similarities

Both implementations:
1. Have `task: true` in frontmatter (global) or need it (ProofChecker)
2. Describe delegation conceptually
3. Have well-designed subagents
4. Lack explicit `task()` tool invocation examples
5. Don't mandate delegation in critical instructions

### Differences

| Aspect | Global Implementer | ProofChecker Implementer |
|--------|-------------------|--------------------------|
| **Tool Permission** | ✅ `task: true` explicit | ❌ Not explicit |
| **Workflow Detail** | ✅ Very detailed (10 stages) | ✅ Detailed (4 stages) |
| **Subagent Docs** | ✅ Dedicated section | ✅ Routing section |
| **Parallelization** | ✅ Wave-based parallel | ❌ Sequential only |
| **State Management** | ✅ Comprehensive | ⚠️ Basic |
| **Task Tool Examples** | ❌ Missing | ❌ Missing |
| **Critical Instructions** | ❌ Missing | ❌ Missing |
| **Subagent Paths** | ⚠️ Generic names | ⚠️ `@` symbol pattern |

### Key Insight

The global Implementer is **more advanced** in architecture but has the **same fundamental issue**: it doesn't explicitly show HOW to use the `task` tool to invoke subagents.

---

## Issues Identified

### Issue 1: No Explicit Task Tool Invocation Examples

**Problem**: Workflow says "invoke" but doesn't show `task()` syntax

**Location**: Stage 5 (ExecutePhase), lines 131-173

**Current**:
```markdown
4. Invoke appropriate implementation subagent(s)
```

**Should Be**:
```markdown
4. Use the task tool to invoke the appropriate subagent:
   
   For code generation:
   task(
     subagent_type="subagents/implementation/code-generator",
     description="Generate new Lua module",
     prompt="Create {file_path} with {specifications}. 
             Follow STANDARDS.md. Return brief summary with created files."
   )
   
   For code modification:
   task(
     subagent_type="subagents/implementation/code-modifier",
     description="Modify existing code",
     prompt="Modify {file_path} to {changes_needed}. 
             Follow STANDARDS.md. Return brief summary with modified files."
   )
```

### Issue 2: Missing Critical Instructions Section

**Problem**: No prominent section forcing delegation over self-execution

**Current**: Instructions are scattered throughout workflow

**Should Add** (after line 44, before workflow_execution):
```markdown
<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate ALL implementation work to subagents.
    DO NOT write code yourself. DO NOT modify files yourself.
    
    Your role is COORDINATION and ORCHESTRATION, not execution.
    
    **Correct approach**:
    ```
    task(
      subagent_type="subagents/implementation/code-generator",
      description="Generate plugin spec",
      prompt="Create lua/plugins/telescope.lua with lazy-loading configuration..."
    )
    ```
    
    **Incorrect approach** (NEVER DO THIS):
    - Writing code yourself
    - Modifying files yourself
    - Generating configurations yourself
    
    ALWAYS delegate to specialists.
  </instruction>
  
  <instruction id="delegation_workflow">
    For each phase:
    1. Determine phase type (code gen, code mod, testing, docs)
    2. Select appropriate subagent
    3. Use task tool to invoke subagent
    4. Receive brief summary from subagent
    5. Update phase status
    6. Commit changes
    
    Never skip step 3. Always use the task tool.
  </instruction>
</critical_instructions>
```

### Issue 3: Ambiguous Subagent References

**Problem**: Uses generic names without full paths

**Current**:
```markdown
<code_generator>
  - Invoke: code-generator subagent
</code_generator>
```

**Should Be**:
```markdown
<code_generator>
  - Subagent: subagents/implementation/code-generator
  - Invocation: task(subagent_type="subagents/implementation/code-generator", ...)
  - Purpose: Create new Lua modules, plugin configs
</code_generator>
```

### Issue 4: No Tool Usage Documentation

**Problem**: No section explaining how to use the task tool

**Should Add** (after critical_instructions):
```markdown
<tool_usage>
  <task_tool>
    **Primary tool for this agent**. Use to delegate ALL implementation work.
    
    **Syntax**:
    ```
    task(
      subagent_type="subagents/implementation/{subagent-name}",
      description="Brief description of what subagent should do",
      prompt="Detailed instructions with all context, requirements, and expected output format"
    )
    ```
    
    **Available subagents**:
    - `subagents/implementation/code-generator` - Create new files
    - `subagents/implementation/code-modifier` - Modify existing files
    - `subagents/configuration/health-checker` - Run health checks
    - `subagents/analysis/plugin-analyzer` - Analyze plugins
    
    **When to use**:
    - ALWAYS for code generation
    - ALWAYS for code modification
    - ALWAYS for testing
    - ALWAYS for documentation
    
    **Never**:
    - Do implementation work yourself
    - Skip delegation for "simple" tasks
    - Assume you can do it faster
  </task_tool>
  
  <read_tool>
    Use to read implementation plans, state files, and existing code.
  </read_tool>
  
  <write_tool>
    Use ONLY to write state files and logs. NOT for code generation.
    Code generation MUST be delegated to code-generator subagent.
  </write_tool>
  
  <edit_tool>
    Use ONLY to update plan files with phase status. NOT for code modification.
    Code modification MUST be delegated to code-modifier subagent.
  </edit_tool>
  
  <bash_tool>
    Use for git commits and system commands. NOT for code generation.
  </bash_tool>
</tool_usage>
```

### Issue 5: /implement Command Lacks Delegation Clarity

**Problem**: Command doesn't mention delegation behavior

**File**: `/home/benjamin/.config/.opencode/command/implement.md`

**Current** (lines 20-34):
```markdown
<instructions>
  1. Route this request to the implementer agent: @implementer
  2. Pass the plan_path (path to implementation plan)
  3. The implementer will:
     - Read and parse implementation plan
     - Update plan status to [IN PROGRESS]
     - Update TODO.md (move to In Progress)
     - Execute waves in parallel where possible
     - Delegate to implementation subagents (code-generator, code-modifier, etc.)
     ...
</instructions>
```

**Should Add**:
```markdown
<delegation_behavior>
  The implementer agent acts as a COORDINATOR, not an executor.
  
  **What the implementer does**:
  - Reads and parses the plan
  - Updates phase status
  - Manages git commits
  - Tracks progress
  
  **What the implementer delegates**:
  - Code generation → code-generator subagent
  - Code modification → code-modifier subagent
  - Testing → tester subagent
  - Documentation → documenter subagent
  
  This delegation pattern:
  - Preserves implementer's context window
  - Ensures specialist expertise
  - Improves code quality
  - Enables parallel execution
</delegation_behavior>
```

---

## Proposed Solution

### Three-Pronged Approach

#### 1. Add Critical Instructions Section

Insert after line 44 (before `<implementation_workflow>`):

```markdown
<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate ALL implementation work to subagents.
    DO NOT write code yourself. DO NOT modify files yourself.
    
    Your role is COORDINATION and ORCHESTRATION, not execution.
    
    **Correct approach**:
    ```
    task(
      subagent_type="subagents/implementation/code-generator",
      description="Generate plugin spec",
      prompt="Create lua/plugins/telescope.lua with lazy-loading configuration.
              Follow /home/benjamin/.config/STANDARDS.md.
              Return brief summary with created file paths."
    )
    ```
    
    **Incorrect approach** (NEVER DO THIS):
    - Writing code yourself using write tool
    - Modifying files yourself using edit tool
    - Generating configurations yourself
    - Doing subagent's work
    
    ALWAYS delegate to specialists. Your job is to coordinate, not execute.
  </instruction>
  
  <instruction id="delegation_workflow">
    For each phase in the implementation plan:
    
    1. **Determine phase type**:
       - Code generation? → Use code-generator subagent
       - Code modification? → Use code-modifier subagent
       - Testing? → Use tester subagent
       - Documentation? → Use documenter subagent
    
    2. **Invoke subagent via task tool**:
       ```
       task(
         subagent_type="subagents/{category}/{subagent}",
         description="Brief task description",
         prompt="Detailed instructions with context and requirements"
       )
       ```
    
    3. **Receive brief summary** from subagent
    
    4. **Update phase status** in plan file
    
    5. **Commit changes** to git
    
    Never skip step 2. Always use the task tool for implementation work.
  </instruction>
  
  <instruction id="parallel_execution">
    When executing waves with multiple phases:
    
    1. Launch all phases in wave simultaneously using task tool
    2. Each phase gets its own subagent invocation
    3. Monitor completion status
    4. Collect results as they complete
    5. Proceed to next wave when all phases complete
    
    Example for Wave 1 with 3 phases:
    ```
    # Phase 1: Generate plugin spec
    task(subagent_type="subagents/implementation/code-generator", ...)
    
    # Phase 2: Modify LSP config (parallel)
    task(subagent_type="subagents/implementation/code-modifier", ...)
    
    # Phase 3: Update keybindings (parallel)
    task(subagent_type="subagents/implementation/code-modifier", ...)
    
    # Wait for all three to complete before Wave 2
    ```
  </instruction>
</critical_instructions>

<tool_usage>
  <task_tool>
    **Primary tool for this agent**. Use to delegate ALL implementation work.
    
    **Syntax**:
    ```
    task(
      subagent_type="subagents/{category}/{subagent-name}",
      description="Brief description (1 sentence)",
      prompt="Detailed instructions including:
              - What to create/modify
              - Where to place files
              - Standards to follow (/home/benjamin/.config/STANDARDS.md)
              - Expected output format (brief summary + file paths)"
    )
    ```
    
    **Available subagents**:
    - `subagents/implementation/code-generator` - Create new Lua modules, plugin specs
    - `subagents/implementation/code-modifier` - Modify existing configurations
    - `documenter` - Update documentation (if exists)
    - `tester` - Run tests and validation (if exists)
    
    **When to use**:
    - ALWAYS for code generation (new files)
    - ALWAYS for code modification (existing files)
    - ALWAYS for testing
    - ALWAYS for documentation
    - ANY implementation work
    
    **Never**:
    - Do implementation work yourself
    - Skip delegation for "simple" tasks
    - Use write/edit tools for code (only for state files)
    - Assume you can do it faster than subagent
  </task_tool>
  
  <read_tool>
    Use to read:
    - Implementation plans
    - State files (state.json, TODO.md)
    - Existing code (for analysis only, not modification)
    - Standards (/home/benjamin/.config/STANDARDS.md)
  </read_tool>
  
  <write_tool>
    Use ONLY for:
    - State files (state.json, global.json)
    - Log files (.opencode/logs/*)
    - Plan file updates (phase status)
    
    DO NOT use for:
    - Code generation (delegate to code-generator)
    - Configuration files (delegate to code-generator/code-modifier)
  </write_tool>
  
  <edit_tool>
    Use ONLY for:
    - Updating plan files with phase status
    - Updating TODO.md
    
    DO NOT use for:
    - Code modification (delegate to code-modifier)
    - Configuration changes (delegate to code-modifier)
  </edit_tool>
  
  <bash_tool>
    Use for:
    - Git commits (after phase completion)
    - Git status checks
    - Directory operations
    
    DO NOT use for:
    - Running code generation scripts (delegate to code-generator)
    - Running tests (delegate to tester if exists)
  </bash_tool>
</tool_usage>
```

#### 2. Update Workflow Stages with Explicit Task Tool Calls

**Update Stage 5 (ExecutePhase)** - Replace lines 131-173:

```markdown
<stage id="5" name="ExecutePhase">
  <action>Execute single phase via implementation subagents using task tool</action>
  <process>
    1. Update phase status: [NOT STARTED] → [IN PROGRESS]
    2. Write updated plan file
    3. Determine phase type (code gen, code mod, testing, docs)
    4. **INVOKE SUBAGENT VIA TASK TOOL**:
       
       **For code generation**:
       ```
       task(
         subagent_type="subagents/implementation/code-generator",
         description="Generate {file_description}",
         prompt="Create {file_path} with the following specifications:
                 
                 Requirements:
                 {task_requirements}
                 
                 Standards: Follow /home/benjamin/.config/STANDARDS.md
                 
                 Expected output:
                 - Brief summary (1-2 paragraphs)
                 - Created file paths
                 - Integration instructions
                 - Manual steps if any"
       )
       ```
       
       **For code modification**:
       ```
       task(
         subagent_type="subagents/implementation/code-modifier",
         description="Modify {file_description}",
         prompt="Modify {file_path} to implement:
                 
                 Changes needed:
                 {modification_requirements}
                 
                 Standards: Follow /home/benjamin/.config/STANDARDS.md
                 
                 Expected output:
                 - Brief summary (1-2 paragraphs)
                 - Modified file paths
                 - Impact description
                 - Follow-up steps if any"
       )
       ```
       
       **For testing** (if tester subagent exists):
       ```
       task(
         subagent_type="tester",
         description="Test {feature}",
         prompt="Test the following implementation:
                 
                 Test requirements:
                 {test_criteria}
                 
                 Expected output:
                 - Test results
                 - Pass/fail status
                 - Issues found"
       )
       ```
       
       **For documentation** (if documenter subagent exists):
       ```
       task(
         subagent_type="documenter",
         description="Update documentation",
         prompt="Update documentation for:
                 
                 Changes made:
                 {implementation_summary}
                 
                 Expected output:
                 - Updated documentation files
                 - Brief summary"
       )
       ```
    
    5. Receive brief summary + artifact paths from subagent
    6. Validate phase completion (check that files exist)
    7. Update phase status: [IN PROGRESS] → [COMPLETED]/[BLOCKED]
    8. Write updated plan file
    9. Commit if completed (see Stage 6)
  </process>
  
  <subagent_delegation>
    <code_generation>
      - **Subagent**: subagents/implementation/code-generator
      - **When**: Creating new files (plugins, LSP configs, keybindings, etc.)
      - **Input**: File specs, requirements, standards path
      - **Output**: Created files, brief summary, integration instructions
      - **Invocation**: Use task tool with subagent_type="subagents/implementation/code-generator"
    </code_generation>
    
    <code_modification>
      - **Subagent**: subagents/implementation/code-modifier
      - **When**: Modifying existing files (refactoring, updates, optimizations)
      - **Input**: Files to modify, changes needed, standards path
      - **Output**: Modified files, brief summary, impact description
      - **Invocation**: Use task tool with subagent_type="subagents/implementation/code-modifier"
    </code_modification>
    
    <testing>
      - **Subagent**: tester (if exists)
      - **When**: Running tests, validation, health checks
      - **Input**: Test requirements, success criteria
      - **Output**: Test results, pass/fail status
      - **Invocation**: Use task tool with subagent_type="tester"
    </testing>
    
    <documentation>
      - **Subagent**: documenter (if exists)
      - **When**: Updating docs, generating examples
      - **Input**: Changes made, documentation standards
      - **Output**: Updated docs, brief summary
      - **Invocation**: Use task tool with subagent_type="documenter"
    </documentation>
  </subagent_delegation>
  
  <validation>
    After subagent returns:
    1. Verify files were created/modified (use read tool to check)
    2. Validate brief summary was provided
    3. Check for any errors in subagent output
    4. If validation fails, mark phase as [BLOCKED]
    5. If validation succeeds, mark phase as [COMPLETED]
  </validation>
  
  <output>
    - Phase completion status
    - Brief summary from subagent
    - Artifact paths (files created/modified)
    - Commit hash (if completed)
  </output>
</stage>
```

#### 3. Update Subagent Coordination Section

**Update lines 334-385**:

```markdown
<subagent_coordination>
  <parallel_execution>
    <max_concurrent>5 subagents</max_concurrent>
    <strategy>
      - Launch all phases in wave simultaneously using task tool
      - Each phase gets its own task() invocation
      - Monitor completion status
      - Collect results as they complete
      - No blocking on individual phase completion
    </strategy>
    <example>
      Wave 1 with 3 phases (all parallel):
      ```
      # Launch all three simultaneously
      task(subagent_type="subagents/implementation/code-generator", description="Phase 1", prompt="...")
      task(subagent_type="subagents/implementation/code-modifier", description="Phase 2", prompt="...")
      task(subagent_type="subagents/implementation/code-generator", description="Phase 3", prompt="...")
      
      # Wait for all to complete before Wave 2
      ```
    </example>
  </parallel_execution>
  
  <subagent_types>
    <code_generator>
      - **Path**: subagents/implementation/code-generator
      - **Purpose**: Create new Lua modules, plugin configs, LSP setups
      - **Input**: File specs, standards, templates
      - **Output**: Created files, brief summary (1-2 paragraphs)
      - **Invocation**:
        ```
        task(
          subagent_type="subagents/implementation/code-generator",
          description="Generate {file_type}",
          prompt="Create {file_path} with {specifications}..."
        )
        ```
    </code_generator>
    
    <code_modifier>
      - **Path**: subagents/implementation/code-modifier
      - **Purpose**: Refactor existing configs, update code, apply optimizations
      - **Input**: Files to modify, changes needed, standards
      - **Output**: Modified files, brief summary (1-2 paragraphs)
      - **Invocation**:
        ```
        task(
          subagent_type="subagents/implementation/code-modifier",
          description="Modify {file_type}",
          prompt="Modify {file_path} to {changes}..."
        )
        ```
    </code_modifier>
    
    <tester>
      - **Path**: tester (if exists)
      - **Purpose**: Run tests, validate implementations, health checks
      - **Input**: Test requirements, success criteria
      - **Output**: Test results, pass/fail status
      - **Invocation**:
        ```
        task(
          subagent_type="tester",
          description="Test {feature}",
          prompt="Test {implementation} against {criteria}..."
        )
        ```
    </tester>
    
    <documenter>
      - **Path**: documenter (if exists)
      - **Purpose**: Update docs, generate examples, maintain README
      - **Input**: Docs to update, changes made, standards
      - **Output**: Updated docs, brief summary
      - **Invocation**:
        ```
        task(
          subagent_type="documenter",
          description="Update documentation",
          prompt="Update docs for {changes}..."
        )
        ```
    </documenter>
  </subagent_types>
  
  <error_handling>
    <subagent_failure>
      - Log error to .opencode/logs/errors.log
      - Mark phase as [BLOCKED]
      - Document error in plan file
      - Continue with other phases in wave
      - Report error to user
    </subagent_failure>
    
    <retry_logic>
      - Retry failed subagent with exponential backoff (1s, 2s, 4s)
      - Max 3 retries per subagent invocation
      - If all retries fail, mark as [BLOCKED]
      - Log all retry attempts
    </retry_logic>
    
    <validation_failure>
      - If subagent returns but files not created/modified
      - Mark phase as [BLOCKED]
      - Document validation failure
      - Include subagent output in error report
    </validation_failure>
  </error_handling>
</subagent_coordination>
```

---

## Implementation Plan

### Phase 1: Backup and Preparation (15 minutes)

**Tasks**:
1. Create backup of current implementer.md
2. Create backup of current implement.md command
3. Verify subagent files are properly configured
4. Document current behavior for comparison

**Commands**:
```bash
# Create backups
cp /home/benjamin/.config/.opencode/agent/implementer.md \
   /home/benjamin/.config/.opencode/agent/implementer.md.backup

cp /home/benjamin/.config/.opencode/command/implement.md \
   /home/benjamin/.config/.opencode/command/implement.md.backup

# Verify subagents
ls -la /home/benjamin/.config/.opencode/agent/subagents/implementation/
```

**Deliverables**:
- Backup files created
- Subagent verification complete
- Baseline behavior documented

### Phase 2: Update Implementer Agent (2 hours)

#### Step 2.1: Add Critical Instructions (30 minutes)

**File**: `/home/benjamin/.config/.opencode/agent/implementer.md`

**Location**: After line 44 (after "## Core Responsibilities"), before `<implementation_workflow>`

**Insert**: Complete critical_instructions and tool_usage sections from Proposed Solution above

**Validation**:
- XML structure is valid
- Instructions are clear and prominent
- Task tool syntax is correct

#### Step 2.2: Update ExecutePhase Stage (45 minutes)

**File**: `/home/benjamin/.config/.opencode/agent/implementer.md`

**Location**: Lines 131-173 (Stage 5)

**Replace**: Entire stage with updated version from Proposed Solution

**Key changes**:
- Add explicit task() invocations for each subagent type
- Show concrete syntax with examples
- Include validation steps
- Emphasize mandatory delegation

**Validation**:
- All subagent types covered
- Task tool syntax is correct
- Examples are concrete and actionable

#### Step 2.3: Update Subagent Coordination (30 minutes)

**File**: `/home/benjamin/.config/.opencode/agent/implementer.md`

**Location**: Lines 334-385

**Replace**: Entire section with updated version from Proposed Solution

**Key changes**:
- Add subagent paths
- Add invocation examples
- Show parallel execution pattern
- Include error handling details

**Validation**:
- Paths are correct
- Examples show task() syntax
- Error handling is comprehensive

#### Step 2.4: Add Examples Section (15 minutes)

**File**: `/home/benjamin/.config/.opencode/agent/implementer.md`

**Location**: After subagent_coordination section (after line 385)

**Insert**:
```markdown
---

## Delegation Examples

<delegation_examples>
  <example_1>
    <scenario>Phase requires creating new plugin spec</scenario>
    <task_type>Code generation</task_type>
    <invocation>
      ```
      task(
        subagent_type="subagents/implementation/code-generator",
        description="Generate telescope.nvim plugin spec",
        prompt="Create lua/plugins/telescope.lua with the following configuration:
                
                Plugin: nvim-telescope/telescope.nvim
                Loading: Event-based (VeryLazy)
                Dependencies: plenary.nvim, telescope-fzf-native.nvim
                Keybindings: <leader>ff (find files), <leader>fg (live grep)
                
                Follow /home/benjamin/.config/STANDARDS.md for:
                - Naming conventions
                - Module structure
                - Documentation requirements
                
                Return:
                - Brief summary (1-2 paragraphs)
                - Created file path
                - Integration instructions"
      )
      ```
    </invocation>
    <expected_output>
      Brief summary from code-generator subagent with:
      - File created: lua/plugins/telescope.lua
      - Functionality: Lazy-loaded telescope with keybindings
      - Integration: Automatic (lazy.nvim auto-loads)
    </expected_output>
  </example_1>
  
  <example_2>
    <scenario>Phase requires modifying existing LSP config</scenario>
    <task_type>Code modification</task_type>
    <invocation>
      ```
      task(
        subagent_type="subagents/implementation/code-modifier",
        description="Add rust-analyzer to LSP config",
        prompt="Modify lua/lsp/init.lua to add rust-analyzer configuration:
                
                Changes needed:
                - Add rust-analyzer to server list
                - Configure rust-analyzer settings (check-on-save, cargo features)
                - Add rust filetype detection
                
                Preserve:
                - Existing server configurations
                - Current on_attach function
                - Existing capabilities setup
                
                Follow /home/benjamin/.config/STANDARDS.md
                
                Return:
                - Brief summary (1-2 paragraphs)
                - Modified file path
                - Impact description"
      )
      ```
    </invocation>
    <expected_output>
      Brief summary from code-modifier subagent with:
      - File modified: lua/lsp/init.lua
      - Changes: Added rust-analyzer with cargo check-on-save
      - Impact: Rust files now have LSP support
    </expected_output>
  </example_2>
  
  <example_3>
    <scenario>Wave with 3 parallel phases</scenario>
    <task_type>Parallel execution</task_type>
    <invocation>
      ```
      # Wave 1: Setup plugin structure (3 phases in parallel)
      
      # Phase 1: Generate plugin spec
      task(
        subagent_type="subagents/implementation/code-generator",
        description="Generate plugin spec",
        prompt="Create lua/plugins/nvim-cmp.lua..."
      )
      
      # Phase 2: Generate LSP config (parallel)
      task(
        subagent_type="subagents/implementation/code-generator",
        description="Generate LSP config",
        prompt="Create lua/lsp/lua_ls.lua..."
      )
      
      # Phase 3: Generate keybindings (parallel)
      task(
        subagent_type="subagents/implementation/code-generator",
        description="Generate keybindings",
        prompt="Create lua/config/keymaps/lsp.lua..."
      )
      
      # Wait for all three to complete before Wave 2
      ```
    </invocation>
    <expected_output>
      Three brief summaries from code-generator, one for each phase.
      All phases complete before proceeding to Wave 2.
    </expected_output>
  </example_3>
</delegation_examples>
```

### Phase 3: Update /implement Command (30 minutes)

**File**: `/home/benjamin/.config/.opencode/command/implement.md`

**Location**: After `<instructions>` section (after line 34)

**Insert**:
```markdown

<delegation_behavior>
  ## How the Implementer Works
  
  The implementer agent acts as a **COORDINATOR**, not an executor.
  
  ### What the Implementer Does
  
  ✅ **Coordination**:
  - Reads and parses implementation plans
  - Updates phase status ([NOT STARTED] → [IN PROGRESS] → [COMPLETED])
  - Manages git commits (one per phase)
  - Tracks progress in TODO.md
  - Handles blockers gracefully
  
  ✅ **State Management**:
  - Updates plan files with phase status
  - Maintains state.json and global.json
  - Logs implementation progress
  
  ### What the Implementer Delegates
  
  🔄 **All Implementation Work**:
  - Code generation → `subagents/implementation/code-generator`
  - Code modification → `subagents/implementation/code-modifier`
  - Testing → `tester` subagent (if exists)
  - Documentation → `documenter` subagent (if exists)
  
  ### Benefits of Delegation
  
  💡 **Context Window Efficiency**:
  - Implementer maintains small context (coordination only)
  - Subagents load only what they need
  - Enables parallel execution of phases
  
  💡 **Specialist Expertise**:
  - code-generator knows code patterns and standards
  - code-modifier knows refactoring best practices
  - Each subagent is optimized for its task
  
  💡 **Better Quality**:
  - Specialists produce higher quality output
  - Consistent application of standards
  - Focused error handling per task type
  
  ### Example Execution Flow
  
  ```
  User: /implement .opencode/specs/001_project/plans/implementation_v1.md
  
  Implementer:
    1. Reads plan (5 phases, 2 waves)
    2. Updates plan status to [IN PROGRESS]
    3. Updates TODO.md (move to In Progress)
    
    Wave 1 (Phases 1-3, parallel):
      Phase 1: task(subagent_type="subagents/implementation/code-generator", ...)
      Phase 2: task(subagent_type="subagents/implementation/code-generator", ...)
      Phase 3: task(subagent_type="subagents/implementation/code-modifier", ...)
      
      → Receives 3 brief summaries
      → Updates phase status to [COMPLETED]
      → Commits changes (3 commits)
    
    Wave 2 (Phases 4-5, parallel):
      Phase 4: task(subagent_type="subagents/implementation/code-modifier", ...)
      Phase 5: task(subagent_type="documenter", ...)
      
      → Receives 2 brief summaries
      → Updates phase status to [COMPLETED]
      → Commits changes (2 commits)
    
    4. Updates TODO.md (move to Completed)
    5. Reports implementation summary to user
  
  Result: 5 phases completed, 5 commits created, all via subagent delegation
  ```
</delegation_behavior>
```

### Phase 4: Testing (1 hour)

#### Test 1: Simple Single-Phase Implementation (20 minutes)

**Create test plan**:
```markdown
# Test Plan: Single Phase Code Generation

## Plan File
.opencode/specs/test_delegation/plans/test_v1.md

## Content
**Phase 1: Generate Test Plugin**
- Task: Create lua/plugins/test-plugin.lua
- Type: Code generation
- Expected: Subagent invocation via task tool

## Success Criteria
- Implementer invokes code-generator via task tool
- No direct code writing by implementer
- Brief summary received from subagent
- File created successfully
- Commit created
```

**Execute**:
```bash
/implement .opencode/specs/test_delegation/plans/test_v1.md
```

**Verify**:
1. Check session logs for `task` tool invocation
2. Verify subagent was called
3. Confirm file was created
4. Validate commit message

#### Test 2: Multi-Phase Wave Execution (20 minutes)

**Create test plan**:
```markdown
# Test Plan: Wave-Based Parallel Execution

## Plan File
.opencode/specs/test_delegation/plans/test_v2.md

## Content
**Wave 1**:
- Phase 1: Generate plugin spec (code-generator)
- Phase 2: Generate LSP config (code-generator)
- Phase 3: Modify init.lua (code-modifier)

## Success Criteria
- All 3 phases invoked in parallel via task tool
- 3 separate subagent invocations
- All phases complete before proceeding
- 3 commits created
```

**Execute**:
```bash
/implement .opencode/specs/test_delegation/plans/test_v2.md
```

**Verify**:
1. Check for parallel task invocations
2. Verify all 3 subagents called
3. Confirm wave completed before next
4. Validate 3 commits

#### Test 3: Error Handling (20 minutes)

**Create test plan**:
```markdown
# Test Plan: Blocker Handling

## Plan File
.opencode/specs/test_delegation/plans/test_v3.md

## Content
**Phase 1**: Generate file that already exists (should block)

## Success Criteria
- Implementer invokes code-generator
- Subagent returns error (file exists)
- Phase marked as [BLOCKED]
- Error documented in plan
- Implementer continues (doesn't crash)
```

**Execute**:
```bash
/implement .opencode/specs/test_delegation/plans/test_v3.md
```

**Verify**:
1. Subagent invoked
2. Error handled gracefully
3. Phase marked [BLOCKED]
4. Error logged

### Phase 5: Documentation (30 minutes)

**Update files**:

1. **`.opencode/ARCHITECTURE.md`**:
   - Add section on implementer delegation pattern
   - Explain subagent coordination
   - Document wave-based execution

2. **`.opencode/README.md`**:
   - Update implementer description
   - Note delegation behavior
   - Link to architecture docs

3. **`.opencode/specs/README.md`**:
   - Add note about implementation execution
   - Explain delegation benefits

**Create migration guide**:

File: `.opencode/specs/IMPLEMENTER_DELEGATION_MIGRATION.md`

```markdown
# Implementer Delegation Migration Guide

## Overview

The implementer agent has been updated to enforce delegation to subagents
for all implementation work.

## Changes Made

### 1. Critical Instructions Added
- Mandatory delegation to subagents
- Explicit task tool usage examples
- Clear role definition (coordinator, not executor)

### 2. Workflow Updated
- ExecutePhase stage now shows task() invocations
- Concrete examples for each subagent type
- Validation steps after subagent returns

### 3. Subagent Coordination Enhanced
- Full subagent paths documented
- Invocation examples for each type
- Parallel execution pattern clarified

### 4. /implement Command Updated
- Delegation behavior explained
- Benefits documented
- Example execution flow added

## User Impact

### No Breaking Changes
- `/implement` command works the same
- Input format unchanged
- Output format unchanged

### Performance Improvements
- Better context window efficiency
- Faster parallel execution
- Higher quality output from specialists

## Testing

See test plans in `.opencode/specs/test_delegation/`

## Rollback

If issues arise:
```bash
cp /home/benjamin/.config/.opencode/agent/implementer.md.backup \
   /home/benjamin/.config/.opencode/agent/implementer.md

cp /home/benjamin/.config/.opencode/command/implement.md.backup \
   /home/benjamin/.config/.opencode/command/implement.md
```
```

---

## Testing Strategy

### Test Levels

1. **Unit Tests**: Test each subagent independently
2. **Integration Tests**: Test implementer with subagents
3. **System Tests**: Test via `/implement` command
4. **Performance Tests**: Measure delegation efficiency

### Test Cases

#### TC-1: Code Generation Delegation
**Objective**: Verify implementer delegates to code-generator

**Input**: Plan with code generation phase

**Expected**:
- Implementer invokes code-generator via task tool
- Subagent creates file
- Brief summary returned
- Phase marked [COMPLETED]

**Pass Criteria**: Task tool used, file created, no direct writing by implementer

#### TC-2: Code Modification Delegation
**Objective**: Verify implementer delegates to code-modifier

**Input**: Plan with code modification phase

**Expected**:
- Implementer invokes code-modifier via task tool
- Subagent modifies file
- Brief summary returned
- Phase marked [COMPLETED]

**Pass Criteria**: Task tool used, file modified, no direct editing by implementer

#### TC-3: Parallel Wave Execution
**Objective**: Verify parallel phase execution

**Input**: Plan with wave containing 3 phases

**Expected**:
- 3 task tool invocations (parallel)
- All 3 subagents execute
- All complete before next wave
- 3 commits created

**Pass Criteria**: Parallel execution confirmed, all phases complete

#### TC-4: Error Handling
**Objective**: Verify blocker handling

**Input**: Plan with phase that will fail

**Expected**:
- Subagent invoked
- Error returned
- Phase marked [BLOCKED]
- Error documented
- Implementer continues

**Pass Criteria**: Graceful error handling, no crash

---

## Success Metrics

### Primary Metrics

1. **Delegation Rate**
   - **Target**: 100% of implementation work delegated
   - **Measurement**: Count task tool invocations vs direct file operations
   - **Success**: All code gen/mod via subagents

2. **Context Window Efficiency**
   - **Target**: Implementer context stays small
   - **Measurement**: Token count in implementer context
   - **Success**: <5,000 tokens for coordination

3. **Parallel Execution**
   - **Target**: Waves execute in parallel
   - **Measurement**: Time for wave vs sum of phases
   - **Success**: Wave time < sum of sequential phases

4. **Error Handling**
   - **Target**: Graceful blocker management
   - **Measurement**: Blocked phases handled correctly
   - **Success**: No crashes, errors documented

### Secondary Metrics

1. **Code Quality**
   - **Target**: No regression
   - **Measurement**: Standards compliance
   - **Success**: All generated code follows STANDARDS.md

2. **Commit Quality**
   - **Target**: One commit per phase
   - **Measurement**: Commit count vs phase count
   - **Success**: 1:1 ratio

3. **User Experience**
   - **Target**: No breaking changes
   - **Measurement**: User workflow unchanged
   - **Success**: `/implement` works identically

---

## References

### OpenCode Documentation

1. **Agents**: https://opencode.ai/docs/agents/
2. **Tools**: https://opencode.ai/docs/tools/
3. **Subagents**: OpenAgents/docs/guides/creating-subagents.md

### Internal Documentation

1. **Architecture**: `.opencode/ARCHITECTURE.md`
2. **README**: `.opencode/README.md`
3. **Workflows**: `.opencode/workflows/implementation-workflow.md`

### Related Specifications

1. **ProofChecker Plan**: `/home/benjamin/Documents/Philosophy/Projects/ProofChecker/.opencode/specs/implementer-subagent-optimization-plan.md`
2. **Agent Reorganization**: `.opencode/specs/agent_reorganization_plan.md`

---

## Appendix A: File Checklist

### Files to Modify

- [ ] `.opencode/agent/implementer.md` (main changes)
- [ ] `.opencode/command/implement.md` (add delegation behavior)

### Files to Create

- [ ] `.opencode/agent/implementer.md.backup` (backup)
- [ ] `.opencode/command/implement.md.backup` (backup)
- [ ] `.opencode/specs/test_delegation/plans/test_v1.md` (test plan 1)
- [ ] `.opencode/specs/test_delegation/plans/test_v2.md` (test plan 2)
- [ ] `.opencode/specs/test_delegation/plans/test_v3.md` (test plan 3)
- [ ] `.opencode/specs/IMPLEMENTER_DELEGATION_MIGRATION.md` (migration guide)

### Files to Update

- [ ] `.opencode/ARCHITECTURE.md` (add delegation section)
- [ ] `.opencode/README.md` (update implementer description)
- [ ] `.opencode/specs/README.md` (add implementation notes)

---

## Appendix B: Timeline

### Week 1: Implementation

- **Day 1 (1 hour)**: Phase 1 - Backup and preparation
- **Day 2 (2 hours)**: Phase 2 - Update implementer agent
- **Day 3 (30 min)**: Phase 3 - Update /implement command
- **Day 4 (1 hour)**: Phase 4 - Testing
- **Day 5 (30 min)**: Phase 5 - Documentation

**Total**: 5 hours

---

## Appendix C: Comparison Summary

### Global vs ProofChecker

| Aspect | Global Implementer | ProofChecker Implementer |
|--------|-------------------|--------------------------|
| **Current State** | Better (has task: true) | Needs task: true |
| **Workflow Detail** | More detailed (10 stages) | Good (4 stages) |
| **Parallelization** | Advanced (wave-based) | Sequential only |
| **Issue Severity** | Medium (has foundation) | High (missing foundation) |
| **Fix Complexity** | Lower (add examples) | Higher (add foundation + examples) |
| **Estimated Effort** | 3-4 hours | 4-6 hours |

### Key Takeaway

The global implementer is **closer to optimal** but still needs **explicit task tool enforcement** to guarantee delegation.

---

**Document Version**: 1.0  
**Last Updated**: 2025-12-15  
**Author**: AI Assistant  
**Status**: Awaiting Review
