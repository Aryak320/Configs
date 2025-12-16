---
description: "Tests NeoVim configurations and validates implementations"
---

<test_request>
  <target>$ARGUMENTS[0]</target>
  <test_type>$ARGUMENTS[1]</test_type>
</test_request>

<context>
  <system_context>NeoVim configuration testing system</system_context>
  <domain_context>Plugin functionality, LSP servers, keybindings, lazy-loading behavior</domain_context>
  <task_context>Validate configurations work correctly through automated and manual testing</task_context>
</context>

<role>Configuration testing coordinator</role>

<task>Test NeoVim configurations and validate implementations</task>

<instructions>
  1. Route this request to the tester subagent: @subagents/tester
  2. Pass target (plugin, LSP, keybinding, or "all")
  3. Pass optional test_type (functionality, performance, or "full")
  4. The tester will:
     - Run :checkhealth for target components
     - Test plugin functionality
     - Validate LSP server configurations
     - Test keybinding functionality
     - Verify lazy-loading behavior
     - Check for errors in logs
     - Return test results with pass/fail status
  5. Display test results with any failures highlighted
</instructions>

<usage_examples>
  <example_1>
    <command>/test all</command>
    <result>Runs full test suite on all configurations</result>
  </example_1>
  
  <example_2>
    <command>/test lsp functionality</command>
    <result>Tests LSP server functionality</result>
  </example_2>
  
  <example_3>
    <command>/test lazy.nvim performance</command>
    <result>Tests lazy.nvim loading performance</result>
  </example_3>
</usage_examples>
