---
description: "Displays help information for NeoVim configuration management system"
---

<help_request>
  <topic>$ARGUMENTS[0]</topic>
</help_request>

<context>
  <system_context>NeoVim configuration management help system</system_context>
  <task_context>Provide usage information, command reference, and workflow guidance</task_context>
</context>

<role>Help and documentation provider</role>

<task>Display help information for commands, workflows, and system usage</task>

<instructions>
  1. If topic is provided, show detailed help for that topic
  2. If no topic, show overview of all commands and workflows
  3. Include:
     - Command syntax and parameters
     - Usage examples
     - Workflow descriptions
     - Common patterns
     - Troubleshooting tips
  4. Organize by category:
     - Primary Commands: /research, /plan, /revise, /implement
     - Utility Commands: /todo, /health-check, /test, /optimize-performance, /remove-cruft, /update-docs, /empty-archive, /help, /show-state
     - Workflows: Research → Plan → Implement, Revision workflow
</instructions>

<usage_examples>
  <example_1>
    <command>/help</command>
    <result>Shows overview of all commands and workflows</result>
  </example_1>
  
  <example_2>
    <command>/help research</command>
    <result>Shows detailed help for /research command</result>
  </example_2>
  
  <example_3>
    <command>/help workflows</command>
    <result>Shows workflow documentation</result>
  </example_3>
</usage_examples>
