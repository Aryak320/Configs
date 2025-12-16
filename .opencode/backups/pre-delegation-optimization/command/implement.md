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
