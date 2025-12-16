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
  1. Route this request to the tester agent: @tester
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

<delegation_behavior>
  ## How the Tester Works
  
  The tester agent acts as a **TEST COORDINATOR**, not an executor.
  
  ### What the Tester Does
  
  ✅ **Coordination**:
  - Analyzes test requirements
  - Determines test types needed (health, functionality, LSP, keybindings, performance)
  - Invokes test subagents for each test type
  - Collects brief summaries from test subagents
  - Aggregates results into overall test report
  - Returns pass/fail status with details
  
  ✅ **Test Orchestration**:
  - Organizes tests by type
  - Runs independent tests in parallel
  - Monitors test completion
  - Aggregates test results
  
  ### What the Tester Delegates
  
  🔄 **All Test Execution**:
  - Health checks → `subagents/testing/health-checker`
  - Plugin testing → `subagents/testing/plugin-tester`
  - LSP validation → `subagents/testing/lsp-validator`
  - Keybinding tests → `subagents/testing/keybinding-tester`
  - Performance tests → `subagents/testing/performance-tester`
  
  ### Benefits of Delegation
  
  💡 **Context Window Efficiency**:
  - Tester maintains small context (coordination only)
  - Test subagents load only what they need for their test type
  - Brief summaries instead of full test output (95% context reduction)
  - Enables parallel execution of independent tests (40-60% time savings)
  
  💡 **Specialist Expertise**:
  - health-checker knows how to run and interpret :checkhealth
  - plugin-tester knows how to test plugin functionality
  - lsp-validator knows how to validate LSP configurations
  - keybinding-tester knows how to test keybindings
  - performance-tester knows how to measure startup time and performance
  - Each subagent is optimized for its test type
  
  💡 **Better Quality**:
  - Specialists produce more thorough tests
  - Focused testing per test type
  - Comprehensive coverage through parallel testing
  
  ### Example Execution Flow
  
  ```
  User: /test all
  
  Tester:
    1. Determines test types needed:
       - Health checks
       - Plugin functionality
       - LSP validation
    
    2. Launches 3 test subagents in parallel:
       
       # Test 1: Health checks
       task(
         subagent_type="subagents/testing/health-checker",
         description="Run NeoVim health checks",
         prompt="Execute :checkhealth for all plugins and LSP servers..."
       )
       
       # Test 2: Plugin functionality
       task(
         subagent_type="subagents/testing/plugin-tester",
         description="Test core plugin functionality",
         prompt="Test telescope, nvim-tree, which-key plugins..."
       )
       
       # Test 3: LSP validation
       task(
         subagent_type="subagents/testing/lsp-validator",
         description="Validate LSP server configurations",
         prompt="Test lua_ls, rust-analyzer, pyright LSP servers..."
       )
    
    3. Receives 3 brief summaries:
       - Health: "PASS. All plugins OK. 0 errors, 2 warnings."
       - Plugins: "PASS. Telescope, nvim-tree, which-key functional."
       - LSP: "PASS. All 3 servers configured and responding."
    
    4. Aggregates results:
       Overall: PASS (3/3 test types passed)
       Details:
       - Health checks: ✓ PASS
       - Plugin tests: ✓ PASS
       - LSP validation: ✓ PASS
    
    5. Returns test report to user
  
  Result: Comprehensive testing via subagent delegation
  Context: Tester saw ~300 tokens (summaries) instead of ~5,000 tokens (full output) = 94% reduction
  Time: Parallel execution saved 40-60% time vs sequential
  ```
</delegation_behavior>

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
