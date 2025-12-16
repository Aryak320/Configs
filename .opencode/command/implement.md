---
description: "Executes implementation plans in waves with phase tracking and git commits"
---

<implementation_request>
  <plan_path>$ARGUMENTS[0]</plan_path>
</implementation_request>

<context>
  <system_context>Implementation execution system for NeoVim configuration changes</system_context>
  <domain_context>Wave-based parallel execution with phase tracking and automatic commits</domain_context>
  <task_context>Execute implementation plans, coordinate subagents, manage blockers, update status</task_context>
  <execution_context>Read plan, execute waves in parallel, commit per phase, update TODO.md</execution_context>
</context>

<role>Implementation executor with wave-based parallelization and phase tracking</role>

<task>Execute implementation plan in waves, coordinate implementation subagents, track progress, and commit changes</task>

<instructions>
  1. Route this request to the implementer agent: @implementer
  2. Pass the plan_path (path to implementation plan)
  3. The implementer will:
     - Read and parse implementation plan
     - Update plan status to [IN PROGRESS]
     - Update TODO.md (move to In Progress)
     - Execute waves in parallel where possible
     - Delegate to implementation subagents (code-generator, code-modifier, etc.)
     - Update phase status as work progresses
     - Commit after each phase completion
     - Handle blockers gracefully
     - Update TODO.md (move to Completed when done)
  4. Return implementation status and commit hashes to user
</instructions>

<delegation_behavior>
  ## How the Implementer Works
  
  The implementer agent acts as a **COORDINATOR**, not an executor.
  
  ### What the Implementer Does
  
  ✅ **Coordination**:
  - Reads and parses implementation plans
  - Updates plan status ([NOT STARTED] → [IN PROGRESS] → [COMPLETED])
  - Organizes phases into waves for parallel execution
  - Invokes implementation subagents for each phase
  - Collects brief summaries from subagents
  - Updates phase status as work progresses
  - Commits after each phase completion
  - Updates TODO.md (In Progress → Completed)
  - Handles blockers gracefully
  
  ✅ **State Management**:
  - Updates plan metadata
  - Updates phase status
  - Updates project state.json
  - Logs implementation progress
  
  ### What the Implementer Delegates
  
  🔄 **All Implementation Work**:
  - Code generation → `subagents/implementation/code-generator`
  - Code modification → `subagents/implementation/code-modifier`
  - Test execution → `subagents/implementation/test-runner`
  - Documentation → `subagents/implementation/doc-generator`
  
  ### Benefits of Delegation
  
  💡 **Context Window Efficiency**:
  - Implementer maintains small context (coordination only)
  - Subagents load only what they need for their task
  - Brief summaries instead of full code (95% context reduction)
  - Enables parallel execution of independent phases (40-60% time savings)
  
  💡 **Specialist Expertise**:
  - code-generator knows how to create clean, standards-compliant code
  - code-modifier knows how to safely modify existing configurations
  - test-runner knows how to execute and validate tests
  - doc-generator knows documentation standards and formats
  - Each subagent is optimized for its task type
  
  💡 **Better Quality**:
  - Specialists produce higher quality code
  - Focused implementation per phase
  - Comprehensive testing through test-runner
  - Consistent documentation through doc-generator
  
  ### Example Execution Flow
  
  ```
  User: /implement .opencode/specs/001_lazy_loading/plans/implementation_v1.md
  
  Implementer:
    1. Reads plan: 4 phases organized in 2 waves
       - Wave 1: Phase 1, Phase 2 (parallel, no dependencies)
       - Wave 2: Phase 3, Phase 4 (parallel, depend on Wave 1)
    
    2. Updates plan status to [IN PROGRESS]
    
    3. Updates TODO.md (move to In Progress section)
    
    4. Executes Wave 1 (2 phases in parallel):
       
       # Phase 1: Generate lazy-loading configuration
       task(
         subagent_type="subagents/implementation/code-generator",
         description="Generate lazy-loading config for UI plugins",
         prompt="Create lua/plugins/lazy-ui.lua with event-based loading..."
       )
       
       # Phase 2: Modify existing plugin specs
       task(
         subagent_type="subagents/implementation/code-modifier",
         description="Add lazy-loading to existing plugins",
         prompt="Modify lua/plugins/*.lua to add event triggers..."
       )
       
    5. Receives 2 brief summaries:
       - Phase 1: "Created lazy-ui.lua with 5 UI plugins using VeryLazy event. File: lua/plugins/lazy-ui.lua"
       - Phase 2: "Modified 8 plugin files to add lazy-loading. Files: lua/plugins/*.lua"
    
    6. Updates phase statuses to [COMPLETED]
    
    7. Commits each phase:
       - Commit 1: "feat(plugins): add lazy-loading for UI plugins"
       - Commit 2: "refactor(plugins): add lazy-loading to existing plugins"
    
    8. Executes Wave 2 (2 phases in parallel):
       
       # Phase 3: Run tests
       task(
         subagent_type="subagents/implementation/test-runner",
         description="Validate lazy-loading configuration",
         prompt="Run startup time tests and plugin loading tests..."
       )
       
       # Phase 4: Update documentation
       task(
         subagent_type="subagents/implementation/doc-generator",
         description="Document lazy-loading changes",
         prompt="Update README.md with lazy-loading documentation..."
       )
    
    9. Receives 2 brief summaries:
       - Phase 3: "All tests passed. Startup time improved by 250ms. Coverage: 95%"
       - Phase 4: "Updated README.md with lazy-loading section. File: README.md"
    
    10. Updates phase statuses to [COMPLETED]
    
    11. Commits each phase:
        - Commit 3: "test(plugins): validate lazy-loading configuration"
        - Commit 4: "docs(plugins): document lazy-loading changes"
    
    12. Updates plan status to [COMPLETED]
    
    13. Updates TODO.md (move to Completed section)
    
    14. Returns: "Implementation complete. 4 phases completed, 4 commits created."
  
  Result: 4 phases implemented via subagent delegation, 4 commits created
  Context: Implementer saw ~800 tokens (summaries) instead of ~15,000 tokens (full code) = 95% reduction
  Time: Wave-based parallel execution saved 40-60% time vs sequential
  ```
</delegation_behavior>

<usage_examples>
  <example_1>
    <command>/implement .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md</command>
    <result>Executes all phases in waves, commits per phase, updates TODO.md</result>
  </example_1>
  
  <example_2>
    <command>/implement .opencode/specs/002_lsp_rust_config/plans/implementation_v2.md</command>
    <result>Implements revised plan with updated approach</result>
  </example_2>
</usage_examples>
