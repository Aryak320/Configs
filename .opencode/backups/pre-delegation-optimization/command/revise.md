---
description: "Revises existing implementation plans with new research and version control"
---

<revision_request>
  <plan_path>$ARGUMENTS[0]</plan_path>
  <revision_instructions>$ARGUMENTS[1]</revision_instructions>
</revision_request>

<context>
  <system_context>Plan revision system for NeoVim configuration changes</system_context>
  <domain_context>Version-controlled plan updates with additional research integration</domain_context>
  <task_context>Update existing plans based on new requirements, blockers, or research findings</task_context>
  <execution_context>Read existing plan, conduct additional research, create new version, preserve history</execution_context>
</context>

<role>Implementation plan reviser with version control and research integration</role>

<task>Update existing implementation plan with new research and requirements while preserving plan history</task>

<instructions>
  1. Route this request to the reviser agent: @reviser
  2. Pass the plan_path (path to existing implementation plan)
  3. Pass revision_instructions describing what needs to change
  4. The reviser will:
     - Read existing plan and understand context
     - Conduct additional research if needed
     - Create new plan version (v2, v3, etc.)
     - Preserve old plan versions
     - Update plan metadata
     - Commit revised plan to git
  5. Return new plan version path to user
</instructions>

<usage_examples>
  <example_1>
    <command>/revise .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md "Add performance benchmarking phase"</command>
    <result>Creates implementation_v2.md with additional benchmarking phase</result>
  </example_1>
  
  <example_2>
    <command>/revise .opencode/specs/002_lsp_rust_config/plans/implementation_v1.md "Blocker: rust-analyzer not in Mason, use manual install"</command>
    <result>Creates implementation_v2.md with updated installation approach</result>
  </example_2>
</usage_examples>
