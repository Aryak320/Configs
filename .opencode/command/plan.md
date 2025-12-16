---
description: "Creates phased implementation plans from research findings with wave-based parallelization"
---

<plan_request>
  <overview_path>$ARGUMENTS[0]</overview_path>
  <planning_instructions>$ARGUMENTS[1]</planning_instructions>
</plan_request>

<context>
  <system_context>Implementation planning system for NeoVim configuration changes</system_context>
  <domain_context>Phased implementation with dependency tracking and wave-based parallelization</domain_context>
  <task_context>Transform research findings into detailed, actionable implementation plans</task_context>
  <execution_context>Read research OVERVIEW.md, create phased plan, update TODO.md, commit to git</execution_context>
</context>

<role>Implementation plan creator for NeoVim configuration changes</role>

<task>Create detailed, phased implementation plan from research findings with clear success criteria and dependency tracking</task>

<instructions>
  1. Route this request to the planner agent: @planner
  2. Pass the overview_path (path to research OVERVIEW.md)
  3. Pass optional planning_instructions for specific requirements
  4. The planner will:
     - Read OVERVIEW.md and linked reports
     - Load /home/benjamin/.config/STANDARDS.md
     - Design 3-7 implementation phases
     - Define dependencies and create implementation waves
     - Generate plan metadata
     - Update TODO.md (Not Started section)
     - Commit plan to git
  5. Return plan file path to user
</instructions>

<agent_behavior>
  ## How the Planner Works
  
  The planner agent is a **SPECIALIST** agent that executes directly (no delegation).
  
  ### Why No Delegation?
  
  Unlike coordinator agents (researcher, implementer, reviser, tester, documenter), the planner does NOT delegate to subagents because:
  
  1. **Specialized Expertise**: Plan creation IS the planner's core competency
  2. **Holistic Understanding**: Creating a good plan requires understanding the entire research context
  3. **Direct Execution**: The planner directly reads research and creates plans - this is its primary function
  4. **No Benefit from Delegation**: Breaking plan creation into sub-tasks would add complexity without improving quality
  
  ### What the Planner Does
  
  ✅ **Direct Execution**:
  - Reads research OVERVIEW.md and all linked reports
  - Analyzes research findings comprehensively
  - Loads documentation standards from STANDARDS.md
  - Creates phased implementation plans (3-7 phases)
  - Defines phase dependencies and implementation waves
  - Generates plan metadata (status, type, dependencies, reports)
  - Updates TODO.md (Not Started section)
  - Commits plan to git
  - Returns plan file path
  
  ### Contrast with Coordinator Agents
  
  **Coordinator Agents** (delegate everything):
  - Researcher → delegates to research subagents
  - Implementer → delegates to implementation subagents
  - Reviser → conditionally delegates to research subagents
  - Tester → delegates to test subagents
  - Documenter → delegates to documentation subagents
  
  **Specialist Agents** (execute directly):
  - Planner → creates plans directly (no delegation)
  
  ### Example Execution Flow
  
  ```
  User: /plan .opencode/specs/001_lazy_loading/reports/OVERVIEW.md "Create phased implementation plan"
  
  Planner:
    1. Reads OVERVIEW.md
    2. Reads all linked research reports:
       - codebase_analysis.md (current lazy-loading patterns)
       - docs_research.md (lazy.nvim best practices)
       - best_practices.md (community optimization patterns)
    
    3. Loads STANDARDS.md for plan format requirements
    
    4. Analyzes research findings:
       - 23 plugins with lazy-loading, 8 without
       - Event-based loading recommended for UI plugins
       - Startup time improvement potential: 200-400ms
    
    5. Creates implementation plan with 4 phases:
       Phase 1: Generate lazy-loading config for UI plugins
       Phase 2: Modify existing plugin specs for lazy-loading
       Phase 3: Run startup time tests and validate
       Phase 4: Update documentation
    
    6. Organizes into 2 waves:
       Wave 1: Phases 1, 2 (parallel, no dependencies)
       Wave 2: Phases 3, 4 (parallel, depend on Wave 1)
    
    7. Generates plan metadata:
       - Status: [NOT STARTED]
       - Type: optimization
       - Estimated hours: 4-6 hours
       - Research reports: links to 3 reports
    
    8. Writes implementation_v1.md
    
    9. Updates TODO.md (adds to Not Started section)
    
    10. Commits: "feat(plan): create lazy-loading optimization plan"
    
    11. Returns: .opencode/specs/001_lazy_loading/plans/implementation_v1.md
  
  Result: Comprehensive implementation plan created directly by specialist
  No delegation needed - plan creation IS the planner's specialty
  ```
</agent_behavior>

<usage_examples>
  <example_1>
    <command>/plan .opencode/specs/001_lazy_loading_optimization/reports/OVERVIEW.md "Create phased implementation plan"</command>
    <result>Creates implementation_v1.md with phases, waves, and dependencies</result>
  </example_1>
  
  <example_2>
    <command>/plan .opencode/specs/002_lsp_rust_config/reports/OVERVIEW.md "Focus on incremental rollout"</command>
    <result>Creates plan with small, testable phases for gradual implementation</result>
  </example_2>
</usage_examples>
