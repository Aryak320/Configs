---
description: "Displays current TODO.md status with projects organized by status"
---

<context>
  <system_context>Project status tracking for NeoVim configuration management</system_context>
  <task_context>Display TODO.md with projects organized by Not Started, In Progress, and Completed</task_context>
</context>

<role>TODO status display utility</role>

<task>Read and display .opencode/specs/TODO.md with current project status</task>

<instructions>
  1. Read .opencode/specs/TODO.md
  2. Display contents organized by sections:
     - Not Started: Projects with plans but not yet implemented
     - In Progress: Projects currently being implemented
     - Completed: Finished projects
  3. Show project names, plan versions, and status
  4. Provide quick navigation to project directories
</instructions>

<usage_examples>
  <example>
    <command>/todo</command>
    <result>Displays current TODO.md with all projects and their status</result>
  </example>
</usage_examples>
