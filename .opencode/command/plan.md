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
  1. Route this request to the planner subagent: @subagents/planner
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
