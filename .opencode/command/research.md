---
description: "Initiates comprehensive research on NeoVim configuration topics with parallel subagent coordination"
---

<research_prompt> $ARGUMENTS </research_prompt>

<context>
  <system_context>NeoVim configuration research system using parallel subagent coordination for comprehensive analysis</system_context>
  <domain_context>NeoVim plugin ecosystem, LSP configurations, keybindings, and performance optimization</domain_context>
  <task_context>Gather comprehensive information through codebase analysis, documentation fetching, and best practices research</task_context>
  <execution_context>Create project structure, delegate to research subagents, synthesize findings into OVERVIEW.md</execution_context>
</context>

<role>Research coordinator for NeoVim configuration analysis and investigation</role>

<task>Conduct comprehensive research on the provided topic, coordinate parallel research subagents, and create detailed OVERVIEW.md with findings</task>

<instructions>
  1. Route this request to the researcher agent: @researcher
  2. Pass the research_prompt from $ARGUMENTS
  3. The researcher will:
     - Generate semantic project name
     - Create project structure in .opencode/specs/NNN_project_name/
     - Break research into 1-5 focused subtopics
     - Delegate to specialized research subagents in parallel
     - Synthesize findings into OVERVIEW.md
     - Commit research artifacts to git
  4. Return project path and OVERVIEW.md location to user
</instructions>

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

<usage_examples>
  <example_1>
    <command>/research "Optimize lazy.nvim plugin loading for faster startup"</command>
    <result>Creates project with codebase analysis, documentation research, and best practices findings</result>
  </example_1>
  
  <example_2>
    <command>/research "Improve LSP configuration for Rust development"</command>
    <result>Analyzes current LSP setup, fetches rust-analyzer docs, identifies optimization opportunities</result>
  </example_2>
  
  <example_3>
    <command>/research "Reorganize keybindings between which-key.lua and keymaps.lua"</command>
    <result>Analyzes current keybinding structure, identifies conflicts, suggests optimal organization</result>
  </example_3>
</usage_examples>
