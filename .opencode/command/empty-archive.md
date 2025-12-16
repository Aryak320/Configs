---
description: "Clears completed projects from archive directory"
---

<context>
  <system_context>Project archive management for NeoVim configuration system</system_context>
  <task_context>Clear .opencode/specs/archive/ directory of completed projects</task_context>
</context>

<role>Archive cleanup utility</role>

<task>Empty the archive directory of completed projects</task>

<instructions>
  1. Check .opencode/specs/archive/ directory
  2. List archived projects with completion dates
  3. Confirm with user before deletion
  4. Delete archived projects
  5. Report number of projects removed and space freed
</instructions>

<usage_examples>
  <example>
    <command>/empty-archive</command>
    <result>Lists archived projects, confirms, then deletes them</result>
  </example>
</usage_examples>

<safety>
  - Always confirm before deletion
  - Only deletes from archive/ directory
  - Never touches active projects (001-999)
  - Provides list of what will be deleted
</safety>
