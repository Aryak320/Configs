# Phase 1: Researcher Agent Updates

**Effort**: 2 hours  
**Priority**: High  
**Status**: Not Started  
**Dependencies**: Phase 10 (Backups) must be complete

---

## Overview

Update the researcher agent to enforce delegation patterns with explicit task tool examples and critical instructions.

**Files Modified**:
- `.opencode/agent/researcher.md`
- `.opencode/command/research.md`

**Changes**:
1. Add critical instructions section (mandatory delegation)
2. Add tool usage documentation
3. Update ParallelResearch stage with explicit task() examples
4. Add delegation examples section
5. Update /research command with delegation behavior

---

## Prerequisites

- [ ] Phase 10 (Backups) completed
- [ ] Backups exist at `.opencode/backups/pre-delegation-optimization/`

---

## Step 1: Add Critical Instructions (30 min)

### File
`.opencode/agent/researcher.md`

### Location
After line 38 (after "## Core Responsibilities"), before `<research_workflow>`

### Action
Insert the following section:

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

### Validation
- [ ] XML structure is valid
- [ ] Instructions are clear and prominent
- [ ] Task tool syntax is correct
- [ ] All 5 research subagents listed

---

## Step 2: Update ParallelResearch Stage (30 min)

### File
`.opencode/agent/researcher.md`

### Location
Lines 87-114 (Stage 3: ParallelResearch)

### Action
Replace the `<process>` section with explicit task() invocations for each subagent type.

**Find**:
```markdown
    <process>
      1. Invoke 1-5 research subagents concurrently (max 5)
      2. Pass report file path and research question to each
      3. Subagents write findings to their report files
      4. Subagents return brief summary (1-2 paragraphs) + report path
      5. Collect all summaries without reading full reports
    </process>
```

**Replace with**: (See full plan lines 741-856 for complete replacement text with all 5 subagent examples)

### Key Changes
- Add explicit task() syntax for each subagent type
- Show concrete examples with prompt structure
- Emphasize "never read full reports"

### Validation
- [ ] All 5 subagent types have task() examples
- [ ] Prompt structure is consistent
- [ ] Expected output format specified

---

## Step 3: Add Delegation Examples (30 min)

### File
`.opencode/agent/researcher.md`

### Location
After `<performance>` section (around line 417), before `<constraints>`

### Action
Insert delegation examples section showing concrete usage scenarios.

**Insert**: (See full plan lines 866-1050 for complete examples)

### Examples to Include
1. **Example 1**: Research lazy.nvim optimization (3 subtopics)
2. **Example 2**: Research LSP configuration for Rust (2 subtopics)

### Validation
- [ ] Examples show complete task() invocations
- [ ] Examples show parallel execution pattern
- [ ] Expected output format documented

---

## Step 4: Update /research Command (30 min)

### File
`.opencode/command/research.md`

### Location
After `<instructions>` section (after line 29), before `<usage_examples>`

### Action
Insert delegation behavior section explaining how researcher works.

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

### Validation
- [ ] Delegation behavior clearly explained
- [ ] Benefits documented
- [ ] Example execution flow provided

---

## Testing

### Manual Test
1. Read updated researcher.md
2. Verify critical instructions are prominent
3. Check task() examples are concrete
4. Confirm delegation examples are clear

### Functional Test (Optional)
Run a test research command and verify delegation patterns are followed.

---

## Commit

### Message
```
feat(agents): add delegation enforcement to researcher agent

- Add critical instructions section with mandatory delegation
- Add tool usage documentation for all tools
- Update ParallelResearch stage with explicit task() examples
- Add delegation examples showing concrete usage
- Update /research command with delegation behavior explanation

Phase 1 of 10: Researcher agent delegation optimization
Affects: researcher.md, research.md
```

### Files to Commit
- `.opencode/agent/researcher.md`
- `.opencode/command/research.md`

---

## Rollback

If issues arise:

```bash
# Restore researcher agent
cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/researcher.md \
   /home/benjamin/.config/.opencode/agent/

# Restore research command
cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/research.md \
   /home/benjamin/.config/.opencode/command/
```

---

## Checklist

- [ ] Step 1: Critical instructions added
- [ ] Step 2: ParallelResearch stage updated
- [ ] Step 3: Delegation examples added
- [ ] Step 4: /research command updated
- [ ] All validations passed
- [ ] Changes tested
- [ ] Git commit created
- [ ] Phase marked complete in OVERVIEW.md

---

## Next Phase

After completing this phase, proceed to:
- **Phase 2**: Implementer Agent Updates (3 hours)

---

**Status**: Not Started  
**Last Updated**: 2025-12-15
