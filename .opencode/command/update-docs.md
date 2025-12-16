---
description: "Updates documentation for NeoVim configurations and modules"
---

<doc_request>
  <target>$ARGUMENTS[0]</target>
</doc_request>

<context>
  <system_context>NeoVim documentation generation and update system</system_context>
  <domain_context>Module documentation, usage examples, configuration guides, keybinding docs</domain_context>
  <task_context>Generate or update documentation for specified targets</task_context>
</context>

<role>Documentation generation coordinator</role>

<task>Create or update documentation for NeoVim configurations</task>

<instructions>
  1. Route this request to the documenter subagent: @subagents/documenter
  2. Pass target (module path, "all", or "keybindings")
  3. The documenter will:
     - Analyze code to document
     - Extract function signatures and parameters
     - Identify configuration options
     - Generate usage examples
     - Create or update markdown documentation
     - Follow documentation standards
     - Return brief summary with updated doc paths
  4. Display list of updated documentation files
</instructions>

<usage_examples>
  <example_1>
    <command>/update-docs all</command>
    <result>Updates all module documentation</result>
  </example_1>
  
  <example_2>
    <command>/update-docs lua/plugins/lsp</command>
    <result>Updates LSP plugin documentation</result>
  </example_2>
  
  <example_3>
    <command>/update-docs keybindings</command>
    <result>Updates keybinding documentation</result>
  </example_3>
</usage_examples>
