---
description: "Displays current system state including active projects and recent operations"
---

<state_request>
  <scope>$ARGUMENTS[0]</scope>
</state_request>

<context>
  <system_context>NeoVim configuration management state tracking</system_context>
  <task_context>Display global state, project state, and system metrics</task_context>
</context>

<role>State display utility</role>

<task>Show current system state and project status</task>

<instructions>
  1. Read .opencode/state/global.json
  2. If scope is "project" and project path provided, read project state.json
  3. Display:
     - Active projects count
     - Recent operations
     - System metrics (total projects, commits, etc.)
     - Current project status (if project scope)
     - Blockers (if any)
  4. Format output for easy reading
</instructions>

<usage_examples>
  <example_1>
    <command>/show-state</command>
    <result>Shows global state with active projects and recent operations</result>
  </example_1>
  
  <example_2>
    <command>/show-state project .opencode/specs/001_lazy_loading_optimization</command>
    <result>Shows detailed state for specific project</result>
  </example_2>
</usage_examples>
