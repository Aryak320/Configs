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

<delegation_behavior>
  ## How the Reviser Works
  
  The reviser agent acts as a **CONDITIONAL COORDINATOR** - it delegates only when new research is needed.
  
  ### What the Reviser Does
  
  ✅ **Always**:
  - Reads existing implementation plans
  - Reads existing research reports
  - Analyzes revision requirements
  - Creates new plan versions (v2, v3, etc.)
  - Preserves old plan versions
  - Updates plan metadata
  - Commits revised plans to git
  
  ✅ **Conditionally** (only when new research needed):
  - Invokes research subagents for new information
  - Collects brief summaries from research
  - Incorporates new research into revised plan
  
  ### What the Reviser Delegates
  
  🔄 **New Research Only** (conditional):
  - Codebase analysis → `subagents/research/codebase-analyzer`
  - Documentation fetching → `subagents/research/docs-fetcher`
  - Best practices research → `subagents/research/best-practices-researcher`
  - Dependency analysis → `subagents/research/dependency-analyzer`
  - Refactoring opportunities → `subagents/research/refactor-finder`
  
  ### When Delegation Happens
  
  **Delegates** (uses task tool):
  - Revision requires new information not in existing research
  - User requests additional research areas
  - Plan needs validation against current codebase state
  - New features require understanding current implementation
  
  **Doesn't Delegate** (reads directly):
  - Revision only requires reading existing plan
  - Changes are based on existing research
  - Reordering phases or updating metadata
  - Fixing typos or clarifying instructions
  
  ### Benefits of Conditional Delegation
  
  💡 **Efficiency**:
  - Only conducts research when truly needed
  - Reuses existing research reports when possible
  - Fast revisions for simple changes
  
  💡 **Flexibility**:
  - Can handle both simple and complex revisions
  - Adapts to revision requirements
  - Preserves plan history for rollback
  
  ### Example Execution Flows
  
  **Example 1: Simple Revision (No Delegation)**
  ```
  User: /revise .opencode/specs/001_lazy_loading/plans/implementation_v1.md "Move testing phase before documentation"
  
  Reviser:
    1. Reads implementation_v1.md
    2. Determines: No new research needed (just reordering)
    3. Reorders phases in plan
    4. Creates implementation_v2.md
    5. Preserves implementation_v1.md
    6. Commits: "refactor(plan): reorder phases for better workflow"
    7. Returns: implementation_v2.md
  
  Result: Fast revision, no research needed
  ```
  
  **Example 2: Complex Revision (With Delegation)**
  ```
  User: /revise .opencode/specs/001_lazy_loading/plans/implementation_v1.md "Add performance benchmarking phase"
  
  Reviser:
    1. Reads implementation_v1.md
    2. Determines: New research needed (benchmarking tools unknown)
    3. Invokes research subagent:
       
       task(
         subagent_type="subagents/research/best-practices-researcher",
         description="Research NeoVim performance benchmarking",
         prompt="Research benchmarking tools and best practices..."
       )
    
    4. Receives brief summary:
       "Found 3 benchmarking tools: startuptime, vim-profiler, hyperfine.
        Best practice: measure startup time and plugin load time.
        Report: benchmarking_research.md"
    
    5. Creates implementation_v2.md with new Phase 5 (Benchmarking)
    6. Links to new research report
    7. Preserves implementation_v1.md
    8. Commits: "feat(plan): add performance benchmarking phase"
    9. Returns: implementation_v2.md
  
  Result: Comprehensive revision with new research
  Context: Reviser saw ~200 tokens (summary) instead of ~2,000 tokens (full report) = 90% reduction
  ```
</delegation_behavior>

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
