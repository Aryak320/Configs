# Global Agent Delegation Optimization Plan v2.0

**Status**: Ready for Implementation  
**Priority**: High  
**Estimated Effort**: 12-16 hours  
**Impact**: System-wide delegation enforcement and context window efficiency  
**Scope**: All .opencode/ agents and commands

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Research Findings Integration](#research-findings-integration)
3. [Comprehensive Scope Analysis](#comprehensive-scope-analysis)
4. [Issues Identified Across All Agents](#issues-identified-across-all-agents)
5. [Proposed Solution](#proposed-solution)
6. [Implementation Plan](#implementation-plan)
7. [Testing Strategy](#testing-strategy)
8. [Success Metrics](#success-metrics)
9. [Migration Guide](#migration-guide)
10. [References](#references)

---

## Executive Summary

### Expanded Scope

This plan **expands** the original implementer-focused optimization to cover **all agents and commands** in the .opencode/ system based on comprehensive research findings.

### Research Integration

**Research Report**: `.opencode/specs/opencode_command_usage_research.md`

**Key Research Findings**:
1. ✅ Architecture is fundamentally sound (3-tier delegation pattern)
2. ✅ Context isolation works (95-96% reduction via brief summaries)
3. ✅ Parallel execution enabled (research, implementation waves)
4. ⚠️ **Delegation enforcement inconsistent across agents**
5. ⚠️ **Missing explicit task tool examples system-wide**
6. ⚠️ **Critical instructions absent in primary agents**
7. ⚠️ **Command documentation lacks delegation clarity**

### Affected Components

**Primary Agents** (7 total):
- ✅ orchestrator.md (router, minimal changes needed)
- ⚠️ researcher.md (needs task tool examples)
- ⚠️ planner.md (task: false, no delegation - correct)
- ⚠️ reviser.md (needs task tool examples for conditional research)
- ⚠️ implementer.md (needs critical instructions + examples)
- ⚠️ tester.md (needs task tool examples)
- ⚠️ documenter.md (needs task tool examples)

**Subagents** (17 total):
- ✅ All subagents correctly configured (task: false, focused permissions)
- ℹ️ No changes needed (already specialists)

**Commands** (13 total):
- ⚠️ research.md (needs delegation behavior section)
- ⚠️ plan.md (needs delegation behavior section)
- ⚠️ revise.md (needs delegation behavior section)
- ⚠️ implement.md (needs delegation behavior section)
- ⚠️ test.md (needs delegation behavior section)
- ⚠️ update-docs.md (needs delegation behavior section)
- ✅ todo.md (no agent, direct execution - correct)
- ✅ health-check.md (direct subagent call - correct)
- ✅ optimize-performance.md (direct subagent call - correct)
- ✅ remove-cruft.md (direct subagent call - correct)
- ✅ empty-archive.md (no agent, direct execution - correct)
- ✅ help.md (no agent, direct execution - correct)
- ✅ show-state.md (no agent, direct execution - correct)

### Expected Benefits

**System-Wide**:
- **Guaranteed delegation** to specialist subagents across all workflows
- **Consistent context window efficiency** (95-96% reduction maintained)
- **Improved code quality** through specialist expertise
- **Better error handling** with clear delegation boundaries
- **Easier debugging** with explicit delegation patterns
- **Faster parallel execution** with clear coordination patterns

**Per-Agent Benefits**:
- **Researcher**: Maintains small context across 1-5 parallel subagents
- **Implementer**: Coordinates waves without reading generated code
- **Reviser**: Conditionally delegates research without context bloat
- **Tester**: Delegates test execution to specialized subagents
- **Documenter**: Delegates documentation generation to subagents

---

## Research Findings Integration

### Key Insights from Research Report

#### 1. Architecture Validation

**Finding**: The 3-tier delegation pattern is correctly implemented:
```
Commands → Primary Agents → Subagents
```

**Evidence**:
- Commands use `@agent` syntax to route to primary agents
- Primary agents have `task: true` in frontmatter
- Subagents have `task: false` (no further delegation)
- Brief summary return pattern documented

**Implication**: Foundation is solid, need to enforce usage patterns

#### 2. Context Isolation Success

**Finding**: Context reduction of 95-96% is achievable through delegation

**Evidence**:
- Researcher: 50,000 tokens (5 reports) → 2,500 tokens (5 summaries) = 95%
- Implementer: 15,000 tokens (3 files) → 600 tokens (3 summaries) = 96%

**Implication**: Pattern works when followed, need to ensure consistent application

#### 3. Parallel Execution Patterns

**Finding**: Two parallel execution patterns exist:
1. **Research**: 1-5 concurrent subagents (all launched simultaneously)
2. **Implementation**: Wave-based (phases within waves parallel, waves sequential)

**Evidence**:
- Researcher launches max 5 subagents concurrently
- Implementer executes phases in waves (Wave 1 complete → Wave 2 start)

**Implication**: Both patterns need explicit task tool invocation examples

#### 4. Delegation Gaps Identified

**Finding**: Delegation described conceptually but not enforced

**Evidence**:
- Workflow says "invoke" but doesn't show `task()` syntax
- No critical instructions forcing delegation
- Subagent paths use generic names (not full paths)
- Commands don't explain delegation benefits

**Implication**: Need systematic updates across all agents and commands

### Best Practices from .claude/ System

The research identified these patterns from the .claude/ system to adopt:

1. **Metadata-only passing**: Structured metadata instead of prose summaries
2. **Hard barrier pattern**: Prevent primary agents from reading artifacts
3. **Coordinator return signals**: Standardized return format
4. **Workflow state machine**: Robust state transitions

**Integration Strategy**: Adopt incrementally, starting with critical instructions and task tool examples

---

## Comprehensive Scope Analysis

### Agent Inventory

#### Primary Agents Requiring Updates (6 agents)

| Agent | Current State | Required Changes | Priority |
|-------|--------------|------------------|----------|
| **researcher.md** | Has `task: true`, describes delegation | Add critical instructions, task() examples | High |
| **implementer.md** | Has `task: true`, describes delegation | Add critical instructions, task() examples, tool usage docs | Critical |
| **reviser.md** | Has `task: true`, conditional delegation | Add critical instructions, task() examples | High |
| **tester.md** | Has `task: true`, describes delegation | Add critical instructions, task() examples | Medium |
| **documenter.md** | Has `task: true`, describes delegation | Add critical instructions, task() examples | Medium |
| **planner.md** | Has `task: false` (correct - no delegation) | Add note explaining why no delegation | Low |

#### Orchestrator (1 agent)

| Agent | Current State | Required Changes | Priority |
|-------|--------------|------------------|----------|
| **orchestrator.md** | Routes to primary agents | Add delegation architecture overview | Low |

#### Subagents (17 agents - No Changes Needed)

**Research Subagents** (5):
- ✅ codebase-analyzer.md
- ✅ docs-fetcher.md
- ✅ best-practices-researcher.md
- ✅ dependency-analyzer.md
- ✅ refactor-finder.md

**Implementation Subagents** (2):
- ✅ code-generator.md
- ✅ code-modifier.md

**Analysis Subagents** (3):
- ✅ cruft-finder.md
- ✅ plugin-analyzer.md
- ✅ performance-profiler.md

**Configuration Subagents** (3):
- ✅ health-checker.md
- ✅ keybinding-optimizer.md
- ✅ lsp-configurator.md

**Primary Agents (also act as specialists)** (4):
- ✅ tester.md (can be invoked as subagent)
- ✅ documenter.md (can be invoked as subagent)
- ℹ️ planner.md (specialist, no delegation)
- ℹ️ reviser.md (coordinator + specialist)

### Command Inventory

#### Commands Requiring Updates (6 commands)

| Command | Primary Agent | Required Changes | Priority |
|---------|--------------|------------------|----------|
| **research.md** | researcher | Add delegation behavior section | High |
| **implement.md** | implementer | Add delegation behavior section | Critical |
| **revise.md** | reviser | Add delegation behavior section | High |
| **plan.md** | planner | Add note on no delegation (planner is specialist) | Low |
| **test.md** | tester | Add delegation behavior section | Medium |
| **update-docs.md** | documenter | Add delegation behavior section | Medium |

#### Commands Not Requiring Updates (7 commands)

| Command | Behavior | Reason |
|---------|----------|--------|
| **todo.md** | Direct execution | No agent invocation |
| **health-check.md** | Direct subagent call | Correct pattern |
| **optimize-performance.md** | Direct subagent call | Correct pattern |
| **remove-cruft.md** | Direct subagent call | Correct pattern |
| **empty-archive.md** | Direct execution | No agent invocation |
| **help.md** | Direct execution | No agent invocation |
| **show-state.md** | Direct execution | No agent invocation |

---

## Issues Identified Across All Agents

### Issue 1: Missing Critical Instructions (System-Wide)

**Affected Agents**: researcher, implementer, reviser, tester, documenter (5 agents)

**Problem**: No prominent section forcing delegation over self-execution

**Current State**: Instructions scattered throughout workflow sections

**Impact**: LLM might interpret "invoke" as "do it yourself" instead of using task tool

**Solution**: Add standardized critical instructions section to all primary agents

**Template**:
```markdown
<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate ALL {work_type} to subagents.
    DO NOT {self_execution_anti_pattern}.
    
    Your role is COORDINATION and ORCHESTRATION, not execution.
    
    **Correct approach**:
    task(
      subagent_type="{subagent_path}",
      description="{brief_description}",
      prompt="{detailed_instructions}"
    )
    
    **Incorrect approach** (NEVER DO THIS):
    - {anti_pattern_1}
    - {anti_pattern_2}
    - {anti_pattern_3}
    
    ALWAYS delegate to specialists.
  </instruction>
</critical_instructions>
```

### Issue 2: No Explicit Task Tool Invocation Examples (System-Wide)

**Affected Agents**: researcher, implementer, reviser, tester, documenter (5 agents)

**Problem**: Workflow describes delegation conceptually but doesn't show HOW

**Current State**:
```markdown
4. Invoke appropriate implementation subagent(s)  # ⚠️ VAGUE
```

**Should Be**:
```markdown
4. Use the task tool to invoke the appropriate subagent:
   
   task(
     subagent_type="subagents/implementation/code-generator",
     description="Generate new Lua module",
     prompt="Create {file_path} with {specifications}. 
             Follow STANDARDS.md. Return brief summary with created files."
   )
```

**Impact**: Without concrete examples, LLM might not use task tool correctly

**Solution**: Add concrete task() syntax examples in all workflow stages

### Issue 3: Ambiguous Subagent References (System-Wide)

**Affected Agents**: researcher, implementer, reviser, tester, documenter (5 agents)

**Problem**: Uses generic names without full paths

**Current State**:
```markdown
<code_generator>
  - Invoke: code-generator subagent  # ⚠️ NO PATH
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

**Impact**: Prevents confusion about which subagent to invoke

**Solution**: Use full paths in all subagent references

### Issue 4: No Tool Usage Documentation (System-Wide)

**Affected Agents**: researcher, implementer, reviser, tester, documenter (5 agents)

**Problem**: No section explaining how to use the task tool

**Impact**: LLM might use wrong tools (write/edit instead of task)

**Solution**: Add tool usage section to all primary agents

**Template**:
```markdown
<tool_usage>
  <task_tool>
    **Primary tool for this agent**. Use to delegate ALL {work_type}.
    
    **Syntax**:
    task(
      subagent_type="{category}/{subagent}",
      description="Brief description",
      prompt="Detailed instructions"
    )
    
    **Available subagents**:
    - {subagent_1} - {purpose_1}
    - {subagent_2} - {purpose_2}
    
    **When to use**: ALWAYS for {work_type}
    **Never**: Do {work_type} yourself
  </task_tool>
  
  <read_tool>Use to read {allowed_reads}</read_tool>
  <write_tool>Use ONLY for {allowed_writes}. NOT for {prohibited_writes}.</write_tool>
  <edit_tool>Use ONLY for {allowed_edits}. NOT for {prohibited_edits}.</edit_tool>
</tool_usage>
```

### Issue 5: Command Documentation Lacks Delegation Clarity (System-Wide)

**Affected Commands**: research, implement, revise, test, update-docs (5 commands)

**Problem**: Commands mention delegation but don't explain the pattern

**Current State**:
```markdown
- Delegate to implementation subagents (code-generator, code-modifier, etc.)
```

**Should Add**:
```markdown
<delegation_behavior>
  The {agent_name} agent acts as a COORDINATOR, not an executor.
  
  **What the {agent_name} does**:
  - {coordination_task_1}
  - {coordination_task_2}
  
  **What the {agent_name} delegates**:
  - {work_type_1} → {subagent_1}
  - {work_type_2} → {subagent_2}
  
  This delegation pattern:
  - Preserves {agent_name}'s context window
  - Ensures specialist expertise
  - Improves output quality
  - Enables parallel execution
</delegation_behavior>
```

**Impact**: Users understand delegation benefits and workflow

**Solution**: Add delegation behavior sections to all workflow commands

### Issue 6: Planner Agent Confusion (Specific)

**Affected Agent**: planner.md

**Problem**: Has `task: false` but no explanation why

**Current State**: Frontmatter shows `task: false` without context

**Impact**: Might seem like an oversight or error

**Solution**: Add note explaining planner is a specialist (doesn't delegate)

**Template**:
```markdown
<agent_role>
  **Note**: This agent has `task: false` because it is a SPECIALIST, not a coordinator.
  
  The planner agent:
  - Reads research artifacts directly (OVERVIEW.md, reports)
  - Applies planning expertise to create implementation plans
  - Does NOT delegate to subagents (it IS the planning specialist)
  
  This is correct behavior. Not all primary agents delegate.
</agent_role>
```

---

## Proposed Solution

### Solution Architecture

**Three-Tier Approach**:

1. **Tier 1: Agent Updates** (Primary agents)
   - Add critical instructions sections
   - Add tool usage documentation
   - Add explicit task() examples in workflows
   - Use full subagent paths
   - Add delegation examples section

2. **Tier 2: Command Updates** (Workflow commands)
   - Add delegation behavior sections
   - Explain coordinator vs executor roles
   - Document delegation benefits
   - Show example execution flows

3. **Tier 3: Documentation Updates** (System docs)
   - Update ARCHITECTURE.md with delegation patterns
   - Update README.md with delegation overview
   - Create delegation best practices guide
   - Add migration guide for users

### Standardized Sections

#### For Primary Agents (Coordinators)

**Section 1: Critical Instructions** (after Core Responsibilities)
```markdown
<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    {Agent-specific delegation mandate}
  </instruction>
  
  <instruction id="delegation_workflow">
    {Agent-specific delegation workflow}
  </instruction>
  
  <instruction id="parallel_execution">
    {Agent-specific parallel execution pattern (if applicable)}
  </instruction>
</critical_instructions>
```

**Section 2: Tool Usage** (after Critical Instructions)
```markdown
<tool_usage>
  <task_tool>
    {Agent-specific task tool documentation}
  </task_tool>
  
  <read_tool>{Allowed reads}</read_tool>
  <write_tool>{Allowed writes, prohibited writes}</write_tool>
  <edit_tool>{Allowed edits, prohibited edits}</edit_tool>
  <bash_tool>{Allowed bash operations}</bash_tool>
</tool_usage>
```

**Section 3: Workflow Updates** (in existing workflow stages)
- Add explicit task() invocations
- Show concrete syntax with examples
- Include validation steps
- Emphasize mandatory delegation

**Section 4: Delegation Examples** (after workflow)
```markdown
<delegation_examples>
  <example_1>
    <scenario>{Scenario description}</scenario>
    <task_type>{Task type}</task_type>
    <invocation>{Concrete task() call}</invocation>
    <expected_output>{Expected subagent return}</expected_output>
  </example_1>
  
  {Additional examples}
</delegation_examples>
```

#### For Workflow Commands

**Section: Delegation Behavior** (after instructions)
```markdown
<delegation_behavior>
  ## How the {Agent Name} Works
  
  The {agent_name} agent acts as a **COORDINATOR**, not an executor.
  
  ### What the {Agent Name} Does
  
  ✅ **Coordination**:
  - {Coordination task 1}
  - {Coordination task 2}
  
  ### What the {Agent Name} Delegates
  
  🔄 **All {Work Type}**:
  - {Work type 1} → {Subagent 1}
  - {Work type 2} → {Subagent 2}
  
  ### Benefits of Delegation
  
  💡 **Context Window Efficiency**: {Benefit 1}
  💡 **Specialist Expertise**: {Benefit 2}
  💡 **Better Quality**: {Benefit 3}
  
  ### Example Execution Flow
  
  {Concrete example with task() calls}
</delegation_behavior>
```

---

## Implementation Plan

### Phase 1: Researcher Agent Updates (2 hours)

**Priority**: High (parallel research is core workflow)

#### Step 1.1: Add Critical Instructions (30 min)

**File**: `/home/benjamin/.config/.opencode/agent/researcher.md`

**Location**: After line 38 (after "## Core Responsibilities"), before `<research_workflow>`

**Insert**:
```markdown
---

<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate ALL research work to subagents.
    DO NOT read codebase files yourself. DO NOT fetch documentation yourself.
    DO NOT conduct research yourself.
    
    Your role is COORDINATION and ORCHESTRATION, not execution.
    
    **Correct approach**:
    ```
    task(
      subagent_type="subagents/research/codebase-analyzer",
      description="Analyze NeoVim codebase for lazy-loading patterns",
      prompt="Scan /home/benjamin/.config/nvim/ for plugin configurations.
              Identify lazy-loading patterns and opportunities.
              Write detailed findings to {report_path}.
              Return brief summary (1-2 paragraphs) with key findings."
    )
    ```
    
    **Incorrect approach** (NEVER DO THIS):
    - Reading NeoVim config files yourself
    - Fetching plugin documentation yourself
    - Conducting codebase analysis yourself
    - Writing research reports yourself
    
    ALWAYS delegate to specialist subagents.
  </instruction>
  
  <instruction id="delegation_workflow">
    For each research subtopic:
    
    1. **Determine subtopic type**:
       - Codebase analysis? → Use codebase-analyzer subagent
       - Documentation needed? → Use docs-fetcher subagent
       - Best practices research? → Use best-practices-researcher subagent
       - Dependency analysis? → Use dependency-analyzer subagent
       - Refactoring opportunities? → Use refactor-finder subagent
    
    2. **Create report file** for subtopic in reports/ directory
    
    3. **Invoke subagent via task tool**:
       ```
       task(
         subagent_type="subagents/research/{subagent}",
         description="Brief task description",
         prompt="Detailed instructions with:
                 - Research question
                 - Report file path
                 - Expected output format (brief summary + report path)"
       )
       ```
    
    4. **Receive brief summary** from subagent (1-2 paragraphs)
    
    5. **Never read the full report** - only use the summary
    
    Never skip step 3. Always use the task tool for research work.
  </instruction>
  
  <instruction id="parallel_execution">
    When conducting research with multiple subtopics:
    
    1. Create report files for all subtopics
    2. Launch all subagents simultaneously using task tool (max 5 concurrent)
    3. Monitor completion status
    4. Collect brief summaries as they complete
    5. Synthesize summaries into OVERVIEW.md (never read full reports)
    
    Example for 3 subtopics:
    ```
    # Launch all three simultaneously
    task(subagent_type="subagents/research/codebase-analyzer", ...)
    task(subagent_type="subagents/research/docs-fetcher", ...)
    task(subagent_type="subagents/research/best-practices-researcher", ...)
    
    # Receive 3 brief summaries
    # Synthesize into OVERVIEW.md
    ```
  </instruction>
</critical_instructions>

---

<tool_usage>
  <task_tool>
    **Primary tool for this agent**. Use to delegate ALL research work.
    
    **Syntax**:
    ```
    task(
      subagent_type="subagents/research/{subagent-name}",
      description="Brief description (1 sentence)",
      prompt="Detailed instructions including:
              - Research question
              - Report file path to write
              - NeoVim config path (/home/benjamin/.config/nvim/)
              - Expected output format (brief summary + report path + confidence level)"
    )
    ```
    
    **Available subagents**:
    - `subagents/research/codebase-analyzer` - Scan NeoVim config for patterns
    - `subagents/research/docs-fetcher` - Fetch plugin/API documentation
    - `subagents/research/best-practices-researcher` - Find community patterns and benchmarks
    - `subagents/research/dependency-analyzer` - Analyze plugin dependencies
    - `subagents/research/refactor-finder` - Identify improvement opportunities
    
    **When to use**:
    - ALWAYS for codebase analysis
    - ALWAYS for documentation fetching
    - ALWAYS for best practices research
    - ALWAYS for dependency analysis
    - ALWAYS for refactoring analysis
    - ANY research work
    
    **Never**:
    - Do research yourself
    - Read NeoVim config files yourself
    - Fetch documentation yourself
    - Skip delegation for "simple" research
    - Read full reports from subagents (only summaries)
  </task_tool>
  
  <read_tool>
    Use to read:
    - Research prompts from user
    - Project state files (state.json)
    - Global state (global.json)
    
    DO NOT use to read:
    - NeoVim config files (delegate to codebase-analyzer)
    - Full research reports (only receive summaries)
    - Plugin documentation (delegate to docs-fetcher)
  </read_tool>
  
  <write_tool>
    Use ONLY for:
    - OVERVIEW.md (research synthesis)
    - State files (state.json, global.json)
    - Creating empty report files for subagents
    
    DO NOT use for:
    - Writing research reports (delegate to subagents)
    - Analyzing codebase (delegate to codebase-analyzer)
  </write_tool>
  
  <edit_tool>
    Use ONLY for:
    - Updating OVERVIEW.md
    - Updating state files
    
    DO NOT use for:
    - Modifying research reports (subagents own their reports)
  </edit_tool>
  
  <bash_tool>
    Use for:
    - Git commits (after research completion)
    - Git status checks
    - Directory operations (creating project structure)
    
    DO NOT use for:
    - Running analysis scripts (delegate to subagents)
    - Fetching documentation (delegate to docs-fetcher)
  </bash_tool>
</tool_usage>

---
```

#### Step 1.2: Update ParallelResearch Stage (30 min)

**File**: `/home/benjamin/.config/.opencode/agent/researcher.md`

**Location**: Lines 87-114 (Stage 3: ParallelResearch)

**Replace** `<process>` section with:
```markdown
    <process>
      1. **INVOKE SUBAGENTS VIA TASK TOOL** (1-5 concurrent, max 5):
         
         For each subtopic, use task tool with appropriate subagent:
         
         **Codebase Analysis**:
         ```
         task(
           subagent_type="subagents/research/codebase-analyzer",
           description="Analyze NeoVim codebase for {topic}",
           prompt="Research Question: {research_question}
                   
                   Scan /home/benjamin/.config/nvim/ for:
                   {specific_patterns_to_find}
                   
                   Write detailed findings to: {report_path}
                   
                   Expected output:
                   - Brief summary (1-2 paragraphs)
                   - Key findings
                   - Statistics
                   - Confidence level (high/medium/low)
                   - Report file path"
         )
         ```
         
         **Documentation Fetching**:
         ```
         task(
           subagent_type="subagents/research/docs-fetcher",
           description="Fetch documentation for {plugin/API}",
           prompt="Research Question: {research_question}
                   
                   Fetch documentation for:
                   {plugins_or_apis_to_fetch}
                   
                   Cache in: .opencode/cache/docs/
                   Write summary to: {report_path}
                   
                   Expected output:
                   - Brief summary (1-2 paragraphs)
                   - Documentation sources
                   - Key information extracted
                   - Cached file paths
                   - Report file path"
         )
         ```
         
         **Best Practices Research**:
         ```
         task(
           subagent_type="subagents/research/best-practices-researcher",
           description="Research best practices for {topic}",
           prompt="Research Question: {research_question}
                   
                   Research community patterns for:
                   {specific_areas_to_research}
                   
                   Write findings to: {report_path}
                   
                   Expected output:
                   - Brief summary (1-2 paragraphs)
                   - Best practices identified
                   - Benchmarks and metrics
                   - Trade-offs
                   - Report file path"
         )
         ```
         
         **Dependency Analysis**:
         ```
         task(
           subagent_type="subagents/research/dependency-analyzer",
           description="Analyze dependencies for {plugins}",
           prompt="Research Question: {research_question}
                   
                   Analyze dependencies for:
                   {plugins_to_analyze}
                   
                   Write findings to: {report_path}
                   
                   Expected output:
                   - Brief summary (1-2 paragraphs)
                   - Dependency graph
                   - Version compatibility
                   - Conflicts identified
                   - Report file path"
         )
         ```
         
         **Refactoring Opportunities**:
         ```
         task(
           subagent_type="subagents/research/refactor-finder",
           description="Find refactoring opportunities in {area}",
           prompt="Research Question: {research_question}
                   
                   Scan /home/benjamin/.config/nvim/ for:
                   {refactoring_targets}
                   
                   Write findings to: {report_path}
                   
                   Expected output:
                   - Brief summary (1-2 paragraphs)
                   - Refactoring opportunities
                   - Unused code identified
                   - Optimization suggestions
                   - Report file path"
         )
         ```
      
      2. Subagents write findings to their report files
      3. Subagents return brief summary (1-2 paragraphs) + report path
      4. **Collect all summaries** without reading full reports
      5. **Never use read tool on report files** - only use summaries
    </process>
```

#### Step 1.3: Add Delegation Examples (30 min)

**File**: `/home/benjamin/.config/.opencode/agent/researcher.md`

**Location**: After `<performance>` section (after line 417), before `<constraints>`

**Insert**:
```markdown
---

## Delegation Examples

<delegation_examples>
  <example_1>
    <scenario>Research lazy.nvim plugin loading optimization</scenario>
    <subtopics>3 subtopics (codebase, docs, best practices)</subtopics>
    <invocation>
      ```
      # Subtopic 1: Codebase Analysis
      task(
        subagent_type="subagents/research/codebase-analyzer",
        description="Analyze current lazy.nvim configuration patterns",
        prompt="Research Question: What lazy-loading patterns are currently used in the NeoVim config?
                
                Scan /home/benjamin/.config/nvim/ for:
                - Plugin specifications (lua/plugins/*.lua)
                - Lazy-loading configurations (event, cmd, ft triggers)
                - Plugins without lazy-loading
                - Startup time impact
                
                Write detailed findings to: .opencode/specs/001_lazy_loading/reports/codebase_analysis.md
                
                Expected output:
                - Brief summary (1-2 paragraphs)
                - Plugin count (total, lazy-loaded, eager-loaded)
                - Lazy-loading patterns identified
                - Optimization opportunities
                - Confidence level
                - Report file path"
      )
      
      # Subtopic 2: Documentation Research
      task(
        subagent_type="subagents/research/docs-fetcher",
        description="Fetch lazy.nvim documentation and best practices",
        prompt="Research Question: What are lazy.nvim's recommended lazy-loading strategies?
                
                Fetch documentation for:
                - lazy.nvim plugin (GitHub, docs site)
                - Lazy-loading API reference
                - Performance optimization guides
                
                Cache in: .opencode/cache/docs/lazy-nvim/
                Write summary to: .opencode/specs/001_lazy_loading/reports/docs_research.md
                
                Expected output:
                - Brief summary (1-2 paragraphs)
                - Key lazy-loading strategies
                - Event types available
                - Performance recommendations
                - Cached documentation paths
                - Report file path"
      )
      
      # Subtopic 3: Best Practices Research
      task(
        subagent_type="subagents/research/best-practices-researcher",
        description="Research community lazy-loading best practices",
        prompt="Research Question: What lazy-loading patterns do high-performance NeoVim configs use?
                
                Research community patterns for:
                - Lazy-loading strategies (event-based, cmd-based, ft-based)
                - Startup time benchmarks
                - Common optimization patterns
                - Trade-offs (lazy-loading vs functionality)
                
                Write findings to: .opencode/specs/001_lazy_loading/reports/best_practices.md
                
                Expected output:
                - Brief summary (1-2 paragraphs)
                - Best practices identified
                - Benchmark data (startup times)
                - Recommended patterns
                - Trade-offs to consider
                - Report file path"
      )
      ```
    </invocation>
    <expected_output>
      Three brief summaries from subagents:
      
      1. Codebase Analyzer: "Analyzed 47 Lua files. Found 23 plugins with lazy-loading, 8 without. Current setup uses event-based loading for UI plugins. Identified 3 optimization opportunities. Confidence: High. Report: .opencode/specs/001_lazy_loading/reports/codebase_analysis.md"
      
      2. Docs Fetcher: "Fetched lazy.nvim documentation from GitHub and docs site. Key strategies: event-based (VeryLazy, BufEnter), cmd-based, ft-based. Performance guide recommends deferring heavy plugins. Cached 5 documentation files. Report: .opencode/specs/001_lazy_loading/reports/docs_research.md"
      
      3. Best Practices Researcher: "Researched 10 high-performance NeoVim configs. Common pattern: defer UI plugins to VeryLazy event, use cmd-based for utilities. Benchmark data shows 200-400ms startup improvement with proper lazy-loading. Report: .opencode/specs/001_lazy_loading/reports/best_practices.md"
      
      Researcher synthesizes these 3 summaries into OVERVIEW.md (never reads full reports).
    </expected_output>
  </example_1>
  
  <example_2>
    <scenario>Research LSP configuration for Rust development</scenario>
    <subtopics>2 subtopics (codebase, dependencies)</subtopics>
    <invocation>
      ```
      # Subtopic 1: Current LSP Setup
      task(
        subagent_type="subagents/research/codebase-analyzer",
        description="Analyze current LSP configuration",
        prompt="Research Question: How is LSP currently configured in the NeoVim setup?
                
                Scan /home/benjamin/.config/nvim/ for:
                - LSP configurations (lua/lsp/*.lua)
                - Server setups (lspconfig, mason)
                - Rust-specific configurations
                - Custom handlers and capabilities
                
                Write detailed findings to: .opencode/specs/002_rust_lsp/reports/current_lsp_setup.md
                
                Expected output:
                - Brief summary (1-2 paragraphs)
                - LSP servers configured
                - Rust support status
                - Configuration patterns
                - Report file path"
      )
      
      # Subtopic 2: Dependency Analysis
      task(
        subagent_type="subagents/research/dependency-analyzer",
        description="Analyze rust-analyzer dependencies",
        prompt="Research Question: What dependencies are needed for rust-analyzer LSP?
                
                Analyze dependencies for:
                - rust-analyzer LSP server
                - Required NeoVim plugins (nvim-lspconfig, mason)
                - Rust toolchain requirements
                
                Write findings to: .opencode/specs/002_rust_lsp/reports/dependencies.md
                
                Expected output:
                - Brief summary (1-2 paragraphs)
                - Dependency list
                - Version requirements
                - Installation steps
                - Report file path"
      )
      ```
    </invocation>
    <expected_output>
      Two brief summaries from subagents, synthesized into OVERVIEW.md.
    </expected_output>
  </example_2>
</delegation_examples>

---
```

#### Step 1.4: Update /research Command (30 min)

**File**: `/home/benjamin/.config/.opencode/command/research.md`

**Location**: After `<instructions>` section (after line 29), before `<usage_examples>`

**Insert**:
```markdown

<delegation_behavior>
  ## How the Researcher Works
  
  The researcher agent acts as a **COORDINATOR**, not an executor.
  
  ### What the Researcher Does
  
  ✅ **Coordination**:
  - Generates semantic project names from research prompts
  - Breaks research into 1-5 focused subtopics
  - Creates project structure and report files
  - Invokes research subagents in parallel (max 5 concurrent)
  - Collects brief summaries from subagents
  - Synthesizes summaries into OVERVIEW.md
  - Commits research artifacts to git
  
  ✅ **State Management**:
  - Updates project state.json
  - Updates global state
  - Logs research progress
  
  ### What the Researcher Delegates
  
  🔄 **All Research Work**:
  - Codebase analysis → `subagents/research/codebase-analyzer`
  - Documentation fetching → `subagents/research/docs-fetcher`
  - Best practices research → `subagents/research/best-practices-researcher`
  - Dependency analysis → `subagents/research/dependency-analyzer`
  - Refactoring opportunities → `subagents/research/refactor-finder`
  
  ### Benefits of Delegation
  
  💡 **Context Window Efficiency**:
  - Researcher maintains small context (coordination only)
  - Subagents load only what they need for their research
  - Brief summaries instead of full reports (95% context reduction)
  - Enables parallel execution of multiple research subtopics
  
  💡 **Specialist Expertise**:
  - codebase-analyzer knows NeoVim config patterns
  - docs-fetcher knows how to fetch and cache documentation
  - best-practices-researcher knows community resources
  - Each subagent is optimized for its research type
  
  💡 **Better Quality**:
  - Specialists produce higher quality research
  - Focused analysis per subtopic
  - Comprehensive coverage through parallel research
  
  ### Example Execution Flow
  
  ```
  User: /research "Optimize lazy.nvim plugin loading for faster startup"
  
  Researcher:
    1. Creates project "001_lazy_loading_optimization"
    2. Breaks into 3 subtopics:
       - Codebase analysis (current lazy-loading patterns)
       - Documentation research (lazy.nvim best practices)
       - Best practices (community optimization patterns)
    3. Creates 3 report files
    4. Launches 3 subagents in parallel:
       
       task(subagent_type="subagents/research/codebase-analyzer", ...)
       task(subagent_type="subagents/research/docs-fetcher", ...)
       task(subagent_type="subagents/research/best-practices-researcher", ...)
       
    5. Receives 3 brief summaries (never reads full reports):
       - Codebase: "Found 23 plugins with lazy-loading, 8 without..."
       - Docs: "Lazy.nvim recommends event-based loading..."
       - Best practices: "High-performance configs defer UI plugins..."
       
    6. Synthesizes summaries into OVERVIEW.md with links to reports
    7. Commits to git
    8. Returns: .opencode/specs/001_lazy_loading_optimization/reports/OVERVIEW.md
  
  Result: 3 detailed reports created, OVERVIEW.md synthesized, all via subagent delegation
  Context: Researcher saw ~500 tokens (summaries) instead of ~10,000 tokens (full reports) = 95% reduction
  ```
</delegation_behavior>
```

### Phase 2: Implementer Agent Updates (3 hours)

**Priority**: Critical (most complex delegation pattern)

#### Step 2.1: Add Critical Instructions (45 min)

**File**: `/home/benjamin/.config/.opencode/agent/implementer.md`

**Location**: After line 42 (after "## Core Responsibilities"), before `<implementation_workflow>`

**Insert**: Use the complete critical instructions and tool usage sections from the original plan (lines 469-629 in the original plan document)

#### Step 2.2: Update ExecutePhase Stage (1 hour)

**File**: `/home/benjamin/.config/.opencode/agent/implementer.md`

**Location**: Lines 131-173 (Stage 5: ExecutePhase)

**Replace**: Use the complete updated ExecutePhase stage from the original plan (lines 636-774)

#### Step 2.3: Update Subagent Coordination (45 min)

**File**: `/home/benjamin/.config/.opencode/agent/implementer.md`

**Location**: Lines 334-385

**Replace**: Use the complete updated subagent coordination section from the original plan (lines 781-891)

#### Step 2.4: Add Delegation Examples (30 min)

**File**: `/home/benjamin/.config/.opencode/agent/implementer.md`

**Location**: After subagent_coordination section (after line 385)

**Insert**: Use the complete delegation examples section from the original plan (lines 988-1097)

#### Step 2.5: Update /implement Command (30 min)

**File**: `/home/benjamin/.config/.opencode/command/implement.md`

**Location**: After `<instructions>` section (after line 34)

**Insert**: Use the complete delegation behavior section from the original plan (lines 1109-1186)

### Phase 3: Reviser Agent Updates (1.5 hours)

**Priority**: High (conditional delegation pattern)

#### Step 3.1: Add Critical Instructions (30 min)

**File**: `/home/benjamin/.config/.opencode/agent/reviser.md`

**Location**: After "## Core Responsibilities", before workflow

**Insert**:
```markdown
---

<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate research work to subagents when additional research is needed.
    DO NOT read codebase files yourself. DO NOT fetch documentation yourself.
    
    Your role is COORDINATION for plan revision, with CONDITIONAL delegation for new research.
    
    **When to delegate**:
    - Revision requires new information not in existing research
    - User requests additional research areas
    - Plan needs validation against current codebase state
    
    **Correct approach** (when research needed):
    ```
    task(
      subagent_type="subagents/research/codebase-analyzer",
      description="Analyze codebase for {new_requirement}",
      prompt="Research Question: {question}
              Write findings to: {report_path}
              Return brief summary with key findings."
    )
    ```
    
    **Incorrect approach** (NEVER DO THIS):
    - Reading NeoVim config files yourself for new research
    - Fetching documentation yourself
    - Conducting analysis yourself
    
    **When NOT to delegate**:
    - Revision only requires reading existing plan
    - Changes are based on existing research
    - No new information needed
    
    In these cases, read the plan and research directly (you are the revision specialist).
  </instruction>
  
  <instruction id="conditional_delegation_workflow">
    For plan revisions:
    
    1. **Read existing plan** and research reports
    
    2. **Determine if new research is needed**:
       - Does revision require new information?
       - Is existing research sufficient?
    
    3. **If new research needed**:
       a. Identify research subtopics
       b. Create report files
       c. Invoke research subagents via task tool
       d. Receive brief summaries
       e. Incorporate into revised plan
    
    4. **If existing research sufficient**:
       a. Read existing plan and reports
       b. Apply revision changes
       c. Create new plan version
    
    5. **Create new plan version** (v2, v3, etc.)
    
    6. **Preserve old plan version** (don't overwrite)
  </instruction>
</critical_instructions>

---

<tool_usage>
  <task_tool>
    **Conditional tool for this agent**. Use when additional research is needed.
    
    **Syntax**:
    ```
    task(
      subagent_type="subagents/research/{subagent-name}",
      description="Brief description",
      prompt="Research question and instructions"
    )
    ```
    
    **Available subagents** (same as researcher):
    - `subagents/research/codebase-analyzer`
    - `subagents/research/docs-fetcher`
    - `subagents/research/best-practices-researcher`
    - `subagents/research/dependency-analyzer`
    - `subagents/research/refactor-finder`
    
    **When to use**:
    - Revision requires new information
    - User requests additional research
    - Validation against current codebase needed
    
    **When NOT to use**:
    - Existing research is sufficient
    - Revision is based on existing information
  </task_tool>
  
  <read_tool>
    Use to read:
    - Existing implementation plans
    - Research reports (OVERVIEW.md and detailed reports)
    - User revision instructions
    - State files
    
    This is correct - reviser can read existing artifacts.
  </read_tool>
  
  <write_tool>
    Use for:
    - New plan versions (implementation_v2.md, v3.md, etc.)
    - New research reports (if additional research conducted)
    - State files
    
    DO NOT overwrite existing plan versions.
  </write_tool>
  
  <edit_tool>
    Use for:
    - Updating state files
    - Updating TODO.md
    
    DO NOT edit existing plan versions (create new versions instead).
  </edit_tool>
</tool_usage>

---
```

#### Step 3.2: Update Workflow with Conditional Delegation (45 min)

**File**: `/home/benjamin/.config/.opencode/agent/reviser.md`

**Location**: In workflow section, update research stage

**Add** explicit task() examples for conditional research invocation

#### Step 3.3: Update /revise Command (15 min)

**File**: `/home/benjamin/.config/.opencode/command/revise.md`

**Location**: After `<instructions>` section

**Insert**: Delegation behavior section explaining conditional delegation pattern

### Phase 4: Tester Agent Updates (1 hour)

**Priority**: Medium

#### Step 4.1: Add Critical Instructions (20 min)

**File**: `/home/benjamin/.config/.opencode/agent/tester.md`

**Insert**: Critical instructions for delegating test execution to subagents

#### Step 4.2: Update Workflow (20 min)

**File**: `/home/benjamin/.config/.opencode/agent/tester.md`

**Update**: Add task() examples for test delegation

#### Step 4.3: Update /test Command (20 min)

**File**: `/home/benjamin/.config/.opencode/command/test.md`

**Insert**: Delegation behavior section

### Phase 5: Documenter Agent Updates (1 hour)

**Priority**: Medium

#### Step 5.1: Add Critical Instructions (20 min)

**File**: `/home/benjamin/.config/.opencode/agent/documenter.md`

**Insert**: Critical instructions for delegating documentation work

#### Step 5.2: Update Workflow (20 min)

**File**: `/home/benjamin/.config/.opencode/agent/documenter.md`

**Update**: Add task() examples for documentation delegation

#### Step 5.3: Update /update-docs Command (20 min)

**File**: `/home/benjamin/.config/.opencode/command/update-docs.md`

**Insert**: Delegation behavior section

### Phase 6: Planner Agent Clarification (30 min)

**Priority**: Low (no delegation, just clarification)

#### Step 6.1: Add Agent Role Note (15 min)

**File**: `/home/benjamin/.config/.opencode/agent/planner.md`

**Location**: After "## Core Responsibilities"

**Insert**:
```markdown
---

<agent_role>
  **Note**: This agent has `task: false` because it is a SPECIALIST, not a coordinator.
  
  The planner agent:
  - Reads research artifacts directly (OVERVIEW.md, detailed reports)
  - Applies planning expertise to create implementation plans
  - Does NOT delegate to subagents (it IS the planning specialist)
  - Directly reads and analyzes research to design optimal implementation phases
  
  This is correct behavior. Not all primary agents delegate.
  
  **Why no delegation?**
  - Planning requires holistic understanding of research
  - Planner must read full reports to design comprehensive plans
  - Planning is the specialist work (no sub-specialists needed)
  - Planner's context is research artifacts (already created by researcher)
</agent_role>

---
```

#### Step 6.2: Update /plan Command (15 min)

**File**: `/home/benjamin/.config/.opencode/command/plan.md`

**Location**: After `<instructions>` section

**Insert**:
```markdown

<agent_behavior>
  ## How the Planner Works
  
  The planner agent is a **SPECIALIST**, not a coordinator.
  
  ### What the Planner Does
  
  ✅ **Planning Expertise**:
  - Reads research OVERVIEW.md and detailed reports
  - Loads STANDARDS.md for compliance
  - Designs 3-7 implementation phases
  - Defines phase dependencies
  - Organizes phases into waves for parallel execution
  - Creates implementation plan with success criteria
  - Updates TODO.md
  - Commits plan to git
  
  ### What the Planner Does NOT Delegate
  
  ❌ **No Delegation**:
  - Planner reads research artifacts directly
  - Planner applies planning expertise itself
  - No subagents for planning (planner IS the specialist)
  
  ### Why No Delegation?
  
  💡 **Holistic Understanding Required**:
  - Planning requires comprehensive view of research
  - Must read full reports to design optimal phases
  - Planning is specialist work (no further decomposition)
  
  💡 **Context is Research Artifacts**:
  - Research already created by researcher agent
  - Planner's input is research output (already delegated)
  - Planner adds planning expertise to research findings
  
  ### Example Execution Flow
  
  ```
  User: /plan .opencode/specs/001_lazy_loading/reports/OVERVIEW.md "Create phased plan"
  
  Planner:
    1. Reads OVERVIEW.md (research synthesis)
    2. Reads linked reports (codebase analysis, docs, best practices)
    3. Loads STANDARDS.md
    4. Designs 4 phases:
       - Phase 1: Setup lazy-loading structure
       - Phase 2: Migrate UI plugins to lazy-loading
       - Phase 3: Migrate utility plugins
       - Phase 4: Test and validate
    5. Organizes into 2 waves:
       - Wave 1: Phases 1-2 (Phase 2 depends on Phase 1)
       - Wave 2: Phases 3-4 (parallel)
    6. Creates implementation_v1.md
    7. Updates TODO.md (Not Started section)
    8. Commits plan to git
    9. Returns: .opencode/specs/001_lazy_loading/plans/implementation_v1.md
  
  Result: Comprehensive implementation plan created via planning expertise (no delegation)
  ```
</agent_behavior>
```

### Phase 7: Orchestrator Updates (30 min)

**Priority**: Low (minimal changes)

#### Step 7.1: Add Delegation Architecture Overview (30 min)

**File**: `/home/benjamin/.config/.opencode/agent/orchestrator.md`

**Location**: After "## Core Responsibilities", before "## Routing Logic"

**Insert**:
```markdown
---

## Delegation Architecture

<delegation_architecture>
  This orchestrator routes requests to primary agents, which follow a 3-tier delegation pattern:
  
  **Tier 1: Commands** (User-facing slash commands)
  - Route to primary agents via @agent syntax
  - Provide user parameters and context
  - Receive final results from primary agents
  
  **Tier 2: Primary Agents** (Coordinators)
  - Researcher, Implementer, Reviser, Tester, Documenter
  - Delegate work to specialist subagents via task tool
  - Receive brief summaries from subagents (never read full artifacts)
  - Synthesize results and return to user
  - **Context reduction**: 95-96% through metadata passing
  
  **Tier 3: Subagents** (Specialists)
  - Research subagents (codebase-analyzer, docs-fetcher, etc.)
  - Implementation subagents (code-generator, code-modifier)
  - Analysis subagents (cruft-finder, plugin-analyzer, performance-profiler)
  - Configuration subagents (health-checker, keybinding-optimizer, lsp-configurator)
  - Create detailed artifacts (reports, code, analysis)
  - Return brief summaries (1-2 paragraphs) + artifact paths
  
  **Special Cases**:
  - **Planner**: Specialist agent (reads research directly, no delegation)
  - **Reviser**: Conditional delegation (delegates only when new research needed)
  
  **Benefits**:
  - **Context efficiency**: Primary agents maintain small context
  - **Specialist quality**: Subagents optimized for specific tasks
  - **Parallel execution**: Multiple subagents run concurrently
  - **Clear boundaries**: Each agent has focused responsibility
</delegation_architecture>

---
```

### Phase 8: Documentation Updates (2 hours)

**Priority**: Medium

#### Step 8.1: Update ARCHITECTURE.md (45 min)

**File**: `/home/benjamin/.config/.opencode/ARCHITECTURE.md`

**Add sections**:
1. Delegation Patterns (detailed explanation)
2. Context Isolation Mechanism (how 95% reduction works)
3. Task Tool Usage (syntax and examples)
4. Agent Roles (coordinator vs specialist)

#### Step 8.2: Update README.md (30 min)

**File**: `/home/benjamin/.config/.opencode/README.md`

**Update sections**:
1. Architecture overview (mention delegation)
2. Key Features (add delegation benefits)
3. Commands (note which delegate to agents)

#### Step 8.3: Create Delegation Best Practices Guide (45 min)

**File**: `/home/benjamin/.config/.opencode/DELEGATION_BEST_PRACTICES.md`

**Content**:
```markdown
# Delegation Best Practices

## Overview

This guide documents best practices for agent delegation in the .opencode/ system.

## Primary Agent Patterns

### Coordinator Pattern (Researcher, Implementer, Reviser, Tester, Documenter)

**Characteristics**:
- `task: true` in frontmatter
- Delegates ALL work to subagents
- Receives brief summaries only
- Never reads full artifacts
- Maintains small context

**Template**:
{Complete template with critical instructions, tool usage, workflow examples}

### Specialist Pattern (Planner)

**Characteristics**:
- `task: false` in frontmatter
- Reads artifacts directly
- Applies specialist expertise
- No delegation needed

**When to use**:
- Work cannot be decomposed further
- Requires holistic understanding
- Agent IS the specialist

### Conditional Delegation Pattern (Reviser)

**Characteristics**:
- `task: true` in frontmatter
- Delegates only when new research needed
- Reads existing artifacts directly
- Hybrid coordinator/specialist

**When to use**:
- Work sometimes requires delegation
- Depends on user input
- Conditional research needs

## Subagent Patterns

{Subagent best practices}

## Task Tool Usage

{Detailed task tool syntax and examples}

## Common Pitfalls

{Anti-patterns to avoid}

## Testing Delegation

{How to verify delegation is working}
```

### Phase 9: Testing (3 hours)

**Priority**: High

#### Test Suite 1: Researcher Delegation (45 min)

**Test Cases**:
1. Single subtopic research (verify task tool used)
2. Multi-subtopic research (verify parallel execution)
3. Brief summary collection (verify no full report reads)

**Validation**:
- Check session logs for task tool invocations
- Verify subagent calls
- Confirm context window size (should be small)

#### Test Suite 2: Implementer Delegation (1 hour)

**Test Cases**:
1. Single phase implementation (code generation)
2. Single phase implementation (code modification)
3. Multi-phase wave execution (parallel)
4. Error handling (blocker scenario)

**Validation**:
- Verify task tool used for all code work
- Confirm no direct write/edit of code files by implementer
- Check parallel execution in waves
- Validate error handling

#### Test Suite 3: Reviser Delegation (30 min)

**Test Cases**:
1. Revision without new research (no delegation)
2. Revision with new research (delegation)

**Validation**:
- Verify conditional delegation logic
- Confirm task tool used only when needed

#### Test Suite 4: Integration Tests (45 min)

**Test Cases**:
1. Full workflow: /research → /plan → /implement
2. Revision workflow: /revise → /implement
3. Utility commands: /health-check, /optimize-performance

**Validation**:
- End-to-end delegation working
- Context efficiency maintained
- Parallel execution functioning

### Phase 10: Migration and Rollout (1 hour)

**Priority**: High

#### Step 10.1: Create Migration Guide (30 min)

**File**: `/home/benjamin/.config/.opencode/MIGRATION_GUIDE.md`

**Content**:
- Overview of changes
- Agent-by-agent updates
- Command updates
- User impact (none - backward compatible)
- Rollback procedure

#### Step 10.2: Backup Current State (15 min)

**Commands**:
```bash
# Create backups directory
mkdir -p /home/benjamin/.config/.opencode/backups/pre-delegation-optimization

# Backup all agents
cp -r /home/benjamin/.config/.opencode/agent \
      /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/

# Backup all commands
cp -r /home/benjamin/.config/.opencode/command \
      /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/

# Backup documentation
cp /home/benjamin/.config/.opencode/ARCHITECTURE.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/
cp /home/benjamin/.config/.opencode/README.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/
```

#### Step 10.3: Rollout Plan (15 min)

**Phased Rollout**:
1. **Phase 1**: Update researcher + /research command (test thoroughly)
2. **Phase 2**: Update implementer + /implement command (test thoroughly)
3. **Phase 3**: Update reviser, tester, documenter + commands
4. **Phase 4**: Update orchestrator, planner, documentation
5. **Phase 5**: Final integration testing

**Rollback Triggers**:
- Delegation not working (agents doing work themselves)
- Context window exceeding thresholds
- Errors in task tool invocations
- User workflow broken

---

## Testing Strategy

### Test Levels

1. **Unit Tests**: Test each agent independently
2. **Integration Tests**: Test agent coordination
3. **System Tests**: Test via commands
4. **Performance Tests**: Measure delegation efficiency

### Test Cases

#### TC-1: Researcher Parallel Delegation

**Objective**: Verify researcher delegates to multiple subagents in parallel

**Input**: `/research "Optimize lazy.nvim plugin loading"`

**Expected**:
- Researcher creates 3-5 subtopics
- Researcher invokes 3-5 subagents via task tool (parallel)
- Each subagent writes detailed report
- Each subagent returns brief summary
- Researcher creates OVERVIEW.md from summaries (never reads reports)
- Context window stays small (<5,000 tokens)

**Pass Criteria**:
- Task tool used for all subagent invocations
- Parallel execution confirmed (all launched simultaneously)
- Brief summaries received (not full reports)
- OVERVIEW.md created with links to reports
- Context window <5,000 tokens

#### TC-2: Implementer Wave-Based Delegation

**Objective**: Verify implementer delegates in waves with parallel phases

**Input**: `/implement {plan_with_2_waves_5_phases}`

**Expected**:
- Implementer reads plan
- Wave 1: Launches phases 1-3 in parallel via task tool
- Receives 3 brief summaries
- Commits 3 times
- Wave 2: Launches phases 4-5 in parallel via task tool
- Receives 2 brief summaries
- Commits 2 times
- Context window stays small

**Pass Criteria**:
- Task tool used for all phase implementations
- Wave-based execution (Wave 1 complete before Wave 2)
- Parallel execution within waves
- No direct code writing by implementer
- 5 commits created (one per phase)
- Context window <5,000 tokens

#### TC-3: Reviser Conditional Delegation

**Objective**: Verify reviser delegates only when new research needed

**Input 1**: `/revise {plan} "Change phase order"` (no new research)

**Expected 1**:
- Reviser reads plan
- Reviser applies changes
- No task tool invocation (no new research needed)
- Creates new plan version

**Input 2**: `/revise {plan} "Add Rust LSP support"` (new research needed)

**Expected 2**:
- Reviser reads plan
- Reviser determines new research needed
- Reviser invokes research subagents via task tool
- Receives brief summaries
- Creates new plan version with new research

**Pass Criteria**:
- Conditional delegation logic works
- Task tool used only when needed
- No unnecessary delegation

#### TC-4: Context Window Efficiency

**Objective**: Measure context window reduction through delegation

**Method**:
1. Run research with 5 subtopics
2. Measure researcher context window size
3. Calculate reduction vs reading full reports

**Expected**:
- Full reports: ~50,000 tokens (5 × 10,000)
- Brief summaries: ~2,500 tokens (5 × 500)
- Reduction: 95%

**Pass Criteria**: Context reduction ≥95%

#### TC-5: Parallel Execution Performance

**Objective**: Measure speedup from parallel execution

**Method**:
1. Run research with 5 subtopics
2. Measure total time
3. Compare to sequential execution estimate

**Expected**:
- Sequential: 5 × 2 min = 10 minutes
- Parallel: max(2 min) = 2 minutes
- Speedup: 5x

**Pass Criteria**: Speedup ≥4x (accounting for overhead)

### Validation Scripts

#### Script 1: Check Task Tool Usage

```bash
#!/bin/bash
# check-task-tool-usage.sh

# Check if agent used task tool (not write/edit for code)
grep -r "task(" .opencode/logs/session_*.log | wc -l
grep -r "write.*\.lua" .opencode/logs/session_*.log | wc -l  # Should be 0 for implementer

# Task tool count should be > 0
# Direct code writes should be 0
```

#### Script 2: Measure Context Window

```bash
#!/bin/bash
# measure-context-window.sh

# Count tokens in agent context (approximate)
wc -w .opencode/logs/agent_context_*.log

# Should be <5,000 words (~6,500 tokens) for coordinators
```

#### Script 3: Verify Parallel Execution

```bash
#!/bin/bash
# verify-parallel-execution.sh

# Check timestamps of subagent invocations
grep "task(subagent_type=" .opencode/logs/session_*.log | \
  awk '{print $1, $2}' | \
  sort

# Timestamps should be within seconds of each other (parallel)
```

---

## Success Metrics

### Primary Metrics

1. **Delegation Rate**
   - **Target**: 100% of work delegated by coordinators
   - **Measurement**: Count task tool invocations vs direct file operations
   - **Success**: All code gen/mod/research via subagents

2. **Context Window Efficiency**
   - **Target**: Coordinators maintain small context (<5,000 tokens)
   - **Measurement**: Token count in coordinator context
   - **Success**: 95%+ reduction vs reading full artifacts

3. **Parallel Execution**
   - **Target**: Waves/subtopics execute in parallel
   - **Measurement**: Time for wave vs sum of phases
   - **Success**: Speedup ≥4x for 5 parallel tasks

4. **Error Handling**
   - **Target**: Graceful blocker management
   - **Measurement**: Blocked phases handled correctly
   - **Success**: No crashes, errors documented

### Secondary Metrics

1. **Code Quality**
   - **Target**: No regression
   - **Measurement**: Standards compliance
   - **Success**: All generated code follows STANDARDS.md

2. **User Experience**
   - **Target**: No breaking changes
   - **Measurement**: User workflow unchanged
   - **Success**: Commands work identically

3. **Documentation Quality**
   - **Target**: Clear delegation patterns documented
   - **Measurement**: Documentation completeness
   - **Success**: All patterns documented with examples

---

## Migration Guide

### For Users

**No Action Required**

This update is **backward compatible**. All commands work the same:

```bash
# These commands work exactly as before
/research "topic"
/plan overview.md
/implement plan.md
/revise plan.md "changes"
```

**What Changed (Internal)**:
- Agents now have explicit delegation instructions
- Task tool usage is enforced
- Context window efficiency improved

**What Didn't Change**:
- Command syntax
- Command behavior
- Output format
- Workflow

### For Developers

**If you're creating new agents**:

1. Use the templates in `DELEGATION_BEST_PRACTICES.md`
2. Add critical instructions section
3. Add tool usage documentation
4. Add explicit task() examples in workflows
5. Use full subagent paths

**If you're modifying existing agents**:

1. Check if agent is coordinator or specialist
2. If coordinator: Ensure task tool usage is explicit
3. If specialist: Add note explaining why no delegation
4. Update workflows with task() examples

### Rollback Procedure

If issues arise:

```bash
# Restore from backups
cp -r /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent \
      /home/benjamin/.config/.opencode/

cp -r /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command \
      /home/benjamin/.config/.opencode/

cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/ARCHITECTURE.md \
   /home/benjamin/.config/.opencode/

cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/README.md \
   /home/benjamin/.config/.opencode/
```

---

## Timeline

### Week 1: Core Agents (8 hours)

- **Day 1 (2 hours)**: Phase 1 - Researcher agent + /research command
- **Day 2 (3 hours)**: Phase 2 - Implementer agent + /implement command
- **Day 3 (1.5 hours)**: Phase 3 - Reviser agent + /revise command
- **Day 4 (1 hour)**: Phase 4 - Tester agent + /test command
- **Day 5 (0.5 hours)**: Phase 5 - Documenter agent + /update-docs command

### Week 2: Supporting Updates (4 hours)

- **Day 1 (0.5 hours)**: Phase 6 - Planner clarification + /plan command
- **Day 2 (0.5 hours)**: Phase 7 - Orchestrator updates
- **Day 3 (2 hours)**: Phase 8 - Documentation updates
- **Day 4 (1 hour)**: Phase 10 - Migration and rollout

### Week 3: Testing and Validation (4 hours)

- **Day 1 (0.75 hours)**: Test Suite 1 - Researcher delegation
- **Day 2 (1 hour)**: Test Suite 2 - Implementer delegation
- **Day 3 (0.5 hours)**: Test Suite 3 - Reviser delegation
- **Day 4 (0.75 hours)**: Test Suite 4 - Integration tests
- **Day 5 (1 hour)**: Final validation and documentation

**Total**: 16 hours

---

## References

### Research Documents

1. **Research Report**: `.opencode/specs/opencode_command_usage_research.md`
2. **Original Plan**: `.opencode/specs/global-implementer-delegation-optimization-plan.md`

### Internal Documentation

1. **Architecture**: `.opencode/ARCHITECTURE.md`
2. **README**: `.opencode/README.md`
3. **Workflows**: `.opencode/workflows/`

### Agent Files

**Primary Agents**:
- `.opencode/agent/orchestrator.md`
- `.opencode/agent/researcher.md`
- `.opencode/agent/planner.md`
- `.opencode/agent/reviser.md`
- `.opencode/agent/implementer.md`
- `.opencode/agent/tester.md`
- `.opencode/agent/documenter.md`

**Subagents**:
- `.opencode/agent/subagents/research/` (5 subagents)
- `.opencode/agent/subagents/implementation/` (2 subagents)
- `.opencode/agent/subagents/analysis/` (3 subagents)
- `.opencode/agent/subagents/configuration/` (3 subagents)

### Command Files

- `.opencode/command/research.md`
- `.opencode/command/plan.md`
- `.opencode/command/revise.md`
- `.opencode/command/implement.md`
- `.opencode/command/test.md`
- `.opencode/command/update-docs.md`

---

## Appendix A: File Checklist

### Files to Modify

**Agents** (7 files):
- [ ] `.opencode/agent/researcher.md` (critical instructions, tool usage, workflow updates, examples)
- [ ] `.opencode/agent/implementer.md` (critical instructions, tool usage, workflow updates, examples)
- [ ] `.opencode/agent/reviser.md` (critical instructions, tool usage, conditional delegation)
- [ ] `.opencode/agent/tester.md` (critical instructions, tool usage, workflow updates)
- [ ] `.opencode/agent/documenter.md` (critical instructions, tool usage, workflow updates)
- [ ] `.opencode/agent/planner.md` (agent role note explaining no delegation)
- [ ] `.opencode/agent/orchestrator.md` (delegation architecture overview)

**Commands** (6 files):
- [ ] `.opencode/command/research.md` (delegation behavior section)
- [ ] `.opencode/command/implement.md` (delegation behavior section)
- [ ] `.opencode/command/revise.md` (delegation behavior section)
- [ ] `.opencode/command/test.md` (delegation behavior section)
- [ ] `.opencode/command/update-docs.md` (delegation behavior section)
- [ ] `.opencode/command/plan.md` (agent behavior section explaining no delegation)

**Documentation** (3 files):
- [ ] `.opencode/ARCHITECTURE.md` (delegation patterns section)
- [ ] `.opencode/README.md` (delegation overview)
- [ ] `.opencode/DELEGATION_BEST_PRACTICES.md` (new file)

### Files to Create

**Backups**:
- [ ] `.opencode/backups/pre-delegation-optimization/agent/` (backup directory)
- [ ] `.opencode/backups/pre-delegation-optimization/command/` (backup directory)

**Documentation**:
- [ ] `.opencode/DELEGATION_BEST_PRACTICES.md` (best practices guide)
- [ ] `.opencode/MIGRATION_GUIDE.md` (migration guide)

**Testing**:
- [ ] `.opencode/tests/delegation/test_researcher_delegation.sh`
- [ ] `.opencode/tests/delegation/test_implementer_delegation.sh`
- [ ] `.opencode/tests/delegation/test_reviser_delegation.sh`
- [ ] `.opencode/tests/delegation/test_context_efficiency.sh`

**Validation Scripts**:
- [ ] `.opencode/scripts/check-task-tool-usage.sh`
- [ ] `.opencode/scripts/measure-context-window.sh`
- [ ] `.opencode/scripts/verify-parallel-execution.sh`

---

## Appendix B: Agent Update Templates

### Template 1: Coordinator Agent (Researcher, Implementer, Tester, Documenter)

```markdown
---
description: "{Agent description}"
mode: primary
temperature: 0.2
tools:
  read: true
  write: true
  edit: true
  bash: true
  task: true      # ✅ REQUIRED for coordinators
  glob: true
  grep: true
permissions:
  {Agent-specific permissions}
context:
  lazy: true
---

# {Agent Name}

**Role**: {Agent role}

**Purpose**: {Agent purpose}

---

## Core Responsibilities

{Core responsibilities list}

---

<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate ALL {work_type} to subagents.
    DO NOT {anti_pattern_1}. DO NOT {anti_pattern_2}.
    
    Your role is COORDINATION and ORCHESTRATION, not execution.
    
    **Correct approach**:
    ```
    task(
      subagent_type="{subagent_path}",
      description="{brief_description}",
      prompt="{detailed_instructions}"
    )
    ```
    
    **Incorrect approach** (NEVER DO THIS):
    - {Anti-pattern 1}
    - {Anti-pattern 2}
    - {Anti-pattern 3}
    
    ALWAYS delegate to specialists.
  </instruction>
  
  {Additional instructions}
</critical_instructions>

---

<tool_usage>
  <task_tool>
    **Primary tool for this agent**. Use to delegate ALL {work_type}.
    
    **Syntax**: {Task tool syntax}
    **Available subagents**: {Subagent list}
    **When to use**: {Usage guidelines}
    **Never**: {Anti-patterns}
  </task_tool>
  
  <read_tool>{Allowed reads}</read_tool>
  <write_tool>{Allowed writes, prohibited writes}</write_tool>
  <edit_tool>{Allowed edits, prohibited edits}</edit_tool>
  <bash_tool>{Allowed bash operations}</bash_tool>
</tool_usage>

---

{Workflow with explicit task() examples}

---

<delegation_examples>
  {Concrete examples with task() calls}
</delegation_examples>

---

{Remaining sections}
```

### Template 2: Specialist Agent (Planner)

```markdown
---
description: "{Agent description}"
mode: primary
temperature: 0.2
tools:
  read: true
  write: true
  edit: true
  bash: false
  task: false     # ✅ CORRECT for specialists
  glob: true
  grep: true
permissions:
  {Agent-specific permissions}
context:
  lazy: true
---

# {Agent Name}

**Role**: {Agent role}

**Purpose**: {Agent purpose}

---

## Core Responsibilities

{Core responsibilities list}

---

<agent_role>
  **Note**: This agent has `task: false` because it is a SPECIALIST, not a coordinator.
  
  The {agent_name} agent:
  - {Specialist behavior 1}
  - {Specialist behavior 2}
  - Does NOT delegate to subagents (it IS the specialist)
  
  This is correct behavior. Not all primary agents delegate.
  
  **Why no delegation?**
  - {Reason 1}
  - {Reason 2}
  - {Reason 3}
</agent_role>

---

{Workflow without delegation}

---

{Remaining sections}
```

### Template 3: Conditional Delegation Agent (Reviser)

```markdown
---
description: "{Agent description}"
mode: primary
temperature: 0.2
tools:
  read: true
  write: true
  edit: true
  bash: true
  task: true      # ✅ REQUIRED for conditional delegation
  glob: true
  grep: true
permissions:
  {Agent-specific permissions}
context:
  lazy: true
---

# {Agent Name}

**Role**: {Agent role}

**Purpose**: {Agent purpose}

---

## Core Responsibilities

{Core responsibilities list}

---

<critical_instructions priority="highest">
  <instruction id="mandatory_delegation">
    You MUST use the `task` tool to delegate {work_type} when {condition}.
    DO NOT {anti_pattern} when delegation is needed.
    
    Your role is COORDINATION with CONDITIONAL delegation.
    
    **When to delegate**: {Delegation conditions}
    **When NOT to delegate**: {No delegation conditions}
    
    **Correct approach** (when delegation needed):
    ```
    task(
      subagent_type="{subagent_path}",
      description="{brief_description}",
      prompt="{detailed_instructions}"
    )
    ```
  </instruction>
  
  <instruction id="conditional_delegation_workflow">
    {Conditional delegation workflow}
  </instruction>
</critical_instructions>

---

<tool_usage>
  <task_tool>
    **Conditional tool for this agent**. Use when {condition}.
    
    **When to use**: {Delegation conditions}
    **When NOT to use**: {No delegation conditions}
  </task_tool>
  
  {Other tools}
</tool_usage>

---

{Workflow with conditional task() examples}

---

{Remaining sections}
```

---

**Document Version**: 2.0  
**Last Updated**: 2025-12-15  
**Author**: AI Assistant  
**Status**: Ready for Implementation  
**Supersedes**: global-implementer-delegation-optimization-plan.md (v1.0)
