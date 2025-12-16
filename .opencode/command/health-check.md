---
description: "Runs NeoVim :checkhealth and provides actionable fixes for issues"
---

<context>
  <system_context>NeoVim health check system with automated diagnostics</system_context>
  <domain_context>Plugin health, LSP status, external dependencies, and configuration validation</domain_context>
  <task_context>Execute :checkhealth, parse results, categorize issues, provide fixes</task_context>
</context>

<role>Health check coordinator with automated diagnostics</role>

<task>Run NeoVim health checks, interpret results, and provide actionable fixes</task>

<instructions>
  1. Route this request to the health-checker subagent: @subagents/health-checker
  2. The health-checker will:
     - Run nvim --headless +"checkhealth" +"quit"
     - Parse and categorize results (critical, warning, ok)
     - Identify issues with plugins, LSP, external tools
     - Provide specific fix recommendations
     - Check for missing dependencies
     - Return health report with actionable fixes
  3. Display results organized by severity
  4. Highlight critical issues requiring immediate attention
</instructions>

<usage_examples>
  <example>
    <command>/health-check</command>
    <result>Runs full health check and displays categorized results with fixes</result>
  </example>
</usage_examples>
