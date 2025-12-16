---
description: "Identifies unused plugins, dead code, and orphaned configs for safe removal"
---

<context>
  <system_context>NeoVim configuration cleanup system</system_context>
  <domain_context>Unused plugin detection, dead code identification, orphaned config cleanup</domain_context>
  <task_context>Find cruft, assess safety of removal, recommend cleanup actions</task_context>
</context>

<role>Configuration cleanup coordinator</role>

<task>Identify unused and obsolete configuration for safe removal</task>

<instructions>
  1. Route this request to the cruft-finder subagent: @subagents/analysis/cruft-finder
  2. The cruft-finder will:
     - Find disabled plugins (enabled = false)
     - Detect unused configurations
     - Identify dead code
     - Locate orphaned files
     - Find duplicate configurations
     - Assess removal safety
     - Return cruft report with removal recommendations
  3. Display findings organized by type
  4. Highlight safe removals vs. items needing review
  5. Provide removal commands for safe items
</instructions>

<usage_examples>
  <example>
    <command>/remove-cruft</command>
    <result>Identifies unused plugins, dead code, and provides safe removal recommendations</result>
  </example>
</usage_examples>
