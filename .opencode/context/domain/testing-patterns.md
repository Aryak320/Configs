# NeoVim Testing Patterns

**Domain**: Health checks, functional testing, and validation strategies

---

## Health Checks

<health_checks>
  <checkhealth_command>
    ```vim
    " Run all health checks
    :checkhealth
    
    " Check specific plugin/feature
    :checkhealth telescope
    :checkhealth lsp
    :checkhealth lazy
    
    " Check language-specific tools
    :checkhealth provider
    ```
    
    **What It Checks**:
    - Plugin installation status
    - External dependencies (ripgrep, fd, etc.)
    - Language providers (Python, Node.js, Ruby)
    - LSP server availability
    - Configuration errors
  </checkhealth_command>
  
  <custom_health_checks>
    ```lua
    -- Create custom health check module
    -- lua/health/myconfig.lua
    local M = {}
    
    M.check = function()
      vim.health.start("My Configuration")
      
      -- Check for required executables
      if vim.fn.executable("rg") == 1 then
        vim.health.ok("ripgrep found")
      else
        vim.health.error("ripgrep not found", {
          "Install ripgrep: sudo apt install ripgrep"
        })
      end
      
      -- Check configuration files
      local config_file = vim.fn.stdpath("config") .. "/lua/config/settings.lua"
      if vim.fn.filereadable(config_file) == 1 then
        vim.health.ok("Configuration file exists")
      else
        vim.health.warn("Configuration file missing")
      end
      
      -- Check plugin status
      local ok, lazy = pcall(require, "lazy")
      if ok then
        vim.health.ok("lazy.nvim loaded")
      else
        vim.health.error("lazy.nvim not loaded")
      end
    end
    
    return M
    ```
    
    **Usage**: `:checkhealth myconfig`
  </custom_health_checks>
  
  <health_check_automation>
    ```bash
    #!/bin/bash
    # Run health checks in CI/automated testing
    
    nvim --headless -c "checkhealth" -c "quit" 2>&1 | tee health_report.txt
    
    # Check for errors
    if grep -q "ERROR" health_report.txt; then
      echo "Health check failed"
      exit 1
    fi
    ```
  </health_check_automation>
</health_checks>

---

## Functional Testing

<functional_testing>
  <plugin_verification>
    ```lua
    -- Test plugin loading
    local function test_plugin_loaded(plugin_name)
      local ok, plugin = pcall(require, plugin_name)
      if not ok then
        print(string.format("FAIL: %s not loaded", plugin_name))
        return false
      end
      print(string.format("PASS: %s loaded successfully", plugin_name))
      return true
    end
    
    -- Test suite
    local plugins = {
      "telescope",
      "nvim-treesitter",
      "lspconfig",
      "cmp",
    }
    
    for _, plugin in ipairs(plugins) do
      test_plugin_loaded(plugin)
    end
    ```
    
    **Verification Points**:
    - Plugin module loads without errors
    - Required dependencies available
    - Configuration applied correctly
    - Commands registered
  </plugin_verification>
  
  <lsp_validation>
    ```lua
    -- Test LSP server attachment
    local function test_lsp_attached(bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      
      if #clients == 0 then
        print("FAIL: No LSP clients attached")
        return false
      end
      
      for _, client in ipairs(clients) do
        print(string.format("PASS: LSP client '%s' attached", client.name))
      end
      return true
    end
    
    -- Test LSP capabilities
    local function test_lsp_capabilities(capability)
      local clients = vim.lsp.get_clients()
      for _, client in ipairs(clients) do
        if client.server_capabilities[capability] then
          print(string.format("PASS: %s supports %s", client.name, capability))
          return true
        end
      end
      print(string.format("FAIL: No client supports %s", capability))
      return false
    end
    
    -- Run tests
    test_lsp_attached()
    test_lsp_capabilities("documentFormattingProvider")
    test_lsp_capabilities("completionProvider")
    ```
  </lsp_validation>
  
  <keybinding_testing>
    ```lua
    -- Test keybinding registration
    local function test_keymap_exists(mode, lhs)
      local maps = vim.api.nvim_get_keymap(mode)
      for _, map in ipairs(maps) do
        if map.lhs == lhs then
          print(string.format("PASS: Keymap %s exists in %s mode", lhs, mode))
          return true
        end
      end
      print(string.format("FAIL: Keymap %s not found in %s mode", lhs, mode))
      return false
    end
    
    -- Test suite
    test_keymap_exists("n", "<leader>ff")  -- Telescope find files
    test_keymap_exists("n", "<leader>gg")  -- Neogit
    test_keymap_exists("n", "gd")          -- LSP go to definition
    ```
  </keybinding_testing>
  
  <command_testing>
    ```lua
    -- Test custom command registration
    local function test_command_exists(cmd_name)
      local commands = vim.api.nvim_get_commands({})
      if commands[cmd_name] then
        print(string.format("PASS: Command :%s exists", cmd_name))
        return true
      end
      print(string.format("FAIL: Command :%s not found", cmd_name))
      return false
    end
    
    -- Test suite
    test_command_exists("Telescope")
    test_command_exists("Lazy")
    test_command_exists("Mason")
    ```
  </command_testing>
</functional_testing>

---

## Performance Testing

<performance_testing>
  <startup_time_testing>
    ```bash
    #!/bin/bash
    # Automated startup time testing
    
    THRESHOLD=50  # milliseconds
    RUNS=5
    TOTAL=0
    
    for i in $(seq 1 $RUNS); do
      TIME=$(nvim --startuptime /dev/stdout +qall 2>&1 | \
             tail -1 | awk '{print $2}')
      TOTAL=$(echo "$TOTAL + $TIME" | bc)
      echo "Run $i: ${TIME}ms"
    done
    
    AVG=$(echo "scale=2; $TOTAL / $RUNS" | bc)
    echo "Average: ${AVG}ms"
    
    # Check against threshold
    if (( $(echo "$AVG > $THRESHOLD" | bc -l) )); then
      echo "FAIL: Startup time exceeds ${THRESHOLD}ms"
      exit 1
    else
      echo "PASS: Startup time within threshold"
      exit 0
    fi
    ```
  </startup_time_testing>
  
  <memory_usage_testing>
    ```lua
    -- Test memory usage
    local function test_memory_usage()
      local pid = vim.fn.getpid()
      local mem_kb = tonumber(vim.fn.system("ps -o rss= -p " .. pid))
      local mem_mb = mem_kb / 1024
      
      print(string.format("Memory usage: %.2f MB", mem_mb))
      
      local threshold = 200  -- MB
      if mem_mb > threshold then
        print(string.format("FAIL: Memory usage exceeds %d MB", threshold))
        return false
      else
        print("PASS: Memory usage within acceptable range")
        return true
      end
    end
    ```
  </memory_usage_testing>
  
  <plugin_load_time_testing>
    ```lua
    -- Measure plugin load time
    local function test_plugin_load_time(plugin_name)
      local start = vim.loop.hrtime()
      local ok, _ = pcall(require, plugin_name)
      local elapsed = (vim.loop.hrtime() - start) / 1e6  -- Convert to ms
      
      if not ok then
        print(string.format("FAIL: %s failed to load", plugin_name))
        return false
      end
      
      print(string.format("PASS: %s loaded in %.2fms", plugin_name, elapsed))
      
      local threshold = 100  -- ms
      if elapsed > threshold then
        print(string.format("WARN: Load time exceeds %dms", threshold))
      end
      
      return true
    end
    ```
  </plugin_load_time_testing>
</performance_testing>

---

## Automated Testing Approaches

<automated_testing>
  <headless_testing>
    ```bash
    #!/bin/bash
    # Run NeoVim in headless mode for testing
    
    nvim --headless -c "lua require('test_suite').run()" -c "quit"
    ```
    
    **Use Cases**:
    - CI/CD integration
    - Automated validation
    - Regression testing
    - Plugin compatibility checks
  </headless_testing>
  
  <test_suite_structure>
    ```lua
    -- lua/test_suite.lua
    local M = {}
    
    local tests = {}
    local results = { passed = 0, failed = 0 }
    
    function M.add_test(name, test_fn)
      table.insert(tests, { name = name, fn = test_fn })
    end
    
    function M.run()
      print("Running test suite...")
      
      for _, test in ipairs(tests) do
        local ok, err = pcall(test.fn)
        if ok then
          results.passed = results.passed + 1
          print(string.format("✓ %s", test.name))
        else
          results.failed = results.failed + 1
          print(string.format("✗ %s: %s", test.name, err))
        end
      end
      
      print(string.format("\nResults: %d passed, %d failed", 
                          results.passed, results.failed))
      
      if results.failed > 0 then
        vim.cmd("cquit 1")  -- Exit with error code
      end
    end
    
    return M
    ```
  </test_suite_structure>
  
  <integration_testing>
    ```lua
    -- Test plugin integration
    local test_suite = require("test_suite")
    
    test_suite.add_test("Telescope integration", function()
      local telescope = require("telescope")
      assert(telescope ~= nil, "Telescope not loaded")
      
      -- Test picker availability
      local builtin = require("telescope.builtin")
      assert(type(builtin.find_files) == "function", "find_files not available")
    end)
    
    test_suite.add_test("LSP integration", function()
      -- Open a test file
      vim.cmd("edit test.lua")
      
      -- Wait for LSP to attach
      vim.wait(5000, function()
        return #vim.lsp.get_clients() > 0
      end)
      
      assert(#vim.lsp.get_clients() > 0, "No LSP clients attached")
    end)
    
    test_suite.run()
    ```
  </integration_testing>
</automated_testing>

---

## Test Checklists

<test_checklists>
  <pre_commit_checklist>
    - [ ] Run :checkhealth for all plugins
    - [ ] Verify startup time <50ms
    - [ ] Test LSP attachment for main languages
    - [ ] Verify keybindings work
    - [ ] Check for Lua errors in :messages
    - [ ] Test plugin lazy-loading
    - [ ] Verify formatting and linting
    - [ ] Check treesitter highlighting
  </pre_commit_checklist>
  
  <plugin_addition_checklist>
    - [ ] Plugin loads without errors
    - [ ] Dependencies installed correctly
    - [ ] Configuration applied successfully
    - [ ] Keybindings registered
    - [ ] Commands available
    - [ ] Health check passes
    - [ ] No startup time regression
    - [ ] Documentation updated
  </plugin_addition_checklist>
  
  <lsp_setup_checklist>
    - [ ] Server installed via Mason
    - [ ] Server attaches to correct filetypes
    - [ ] Diagnostics appear correctly
    - [ ] Completion works
    - [ ] Go to definition works
    - [ ] Formatting works
    - [ ] Code actions available
    - [ ] No error messages in :LspLog
  </lsp_setup_checklist>
  
  <regression_testing_checklist>
    - [ ] Compare startup time before/after
    - [ ] Verify all plugins still load
    - [ ] Test critical keybindings
    - [ ] Check LSP functionality
    - [ ] Verify UI rendering
    - [ ] Test file operations
    - [ ] Check for new errors in :messages
    - [ ] Validate configuration changes
  </regression_testing_checklist>
</test_checklists>

---

## Common Testing Pitfalls

<pitfalls>
  <async_operations>
    **Problem**: Tests fail because async operations haven't completed
    
    **Solution**:
    ```lua
    -- Use vim.wait for async operations
    vim.wait(5000, function()
      return condition_met()
    end, 100)  -- Check every 100ms
    ```
  </async_operations>
  
  <state_pollution>
    **Problem**: Tests affect each other's state
    
    **Solution**:
    ```lua
    -- Reset state between tests
    local function reset_state()
      vim.cmd("bufdo bwipeout")
      vim.lsp.stop_client(vim.lsp.get_clients())
    end
    ```
  </state_pollution>
  
  <environment_differences>
    **Problem**: Tests pass locally but fail in CI
    
    **Solution**:
    - Use consistent NeoVim version
    - Pin plugin versions with lazy-lock.json
    - Document external dependencies
    - Test in clean environment
  </environment_differences>
</pitfalls>
