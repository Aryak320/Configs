# NeoVim Debugging Techniques

**Domain**: Error diagnosis, logging strategies, and troubleshooting workflows

---

## Error Diagnosis

<error_diagnosis>
  <messages_command>
    ```vim
    " View all messages (errors, warnings, info)
    :messages
    
    " Clear message history
    :messages clear
    
    " View messages in a buffer for easier searching
    :put =execute('messages')
    ```
    
    **What to Look For**:
    - Lua error stack traces
    - Plugin loading failures
    - Configuration errors
    - Deprecation warnings
    - LSP connection issues
  </messages_command>
  
  <checkhealth_diagnosis>
    ```vim
    " Comprehensive health check
    :checkhealth
    
    " Plugin-specific checks
    :checkhealth telescope
    :checkhealth lsp
    :checkhealth treesitter
    
    " Provider checks
    :checkhealth provider
    ```
    
    **Common Issues Detected**:
    - Missing external dependencies
    - Incorrect plugin configuration
    - Language provider problems
    - LSP server installation issues
    - Treesitter parser problems
  </checkhealth_diagnosis>
  
  <lsp_logs>
    ```vim
    " View LSP log file
    :LspLog
    
    " Set LSP log level for debugging
    :lua vim.lsp.set_log_level("debug")
    
    " Log file location
    :lua print(vim.lsp.get_log_path())
    ```
    
    **Log Levels**:
    - "trace": Most verbose (all messages)
    - "debug": Detailed debugging info
    - "info": General information
    - "warn": Warnings only
    - "error": Errors only (default)
    
    **Analysis**:
    ```lua
    -- Tail LSP log in real-time
    vim.cmd("terminal tail -f " .. vim.lsp.get_log_path())
    ```
  </lsp_logs>
  
  <treesitter_inspection>
    ```vim
    " Inspect treesitter parse tree
    :InspectTree
    
    " Show highlight groups under cursor
    :Inspect
    
    " View installed parsers
    :TSInstallInfo
    
    " Check parser status
    :checkhealth nvim-treesitter
    ```
    
    **Common Issues**:
    - Parser not installed
    - Syntax errors in file
    - Incorrect filetype detection
    - Parser version mismatch
  </treesitter_inspection>
</error_diagnosis>

---

## Logging Strategies

<logging_strategies>
  <vim_notify>
    ```lua
    -- Basic notification
    vim.notify("Plugin loaded successfully", vim.log.levels.INFO)
    
    -- Error notification
    vim.notify("Failed to load config", vim.log.levels.ERROR)
    
    -- Warning notification
    vim.notify("Deprecated function used", vim.log.levels.WARN)
    
    -- Debug notification (only shown if log level allows)
    vim.notify("Debug: Variable value = " .. value, vim.log.levels.DEBUG)
    ```
    
    **Log Levels**:
    - vim.log.levels.TRACE
    - vim.log.levels.DEBUG
    - vim.log.levels.INFO
    - vim.log.levels.WARN
    - vim.log.levels.ERROR
  </vim_notify>
  
  <custom_logging>
    ```lua
    -- Create custom logger module
    -- lua/utils/logger.lua
    local M = {}
    
    local log_file = vim.fn.stdpath("cache") .. "/debug.log"
    local log_level = vim.log.levels.DEBUG
    
    local function write_log(level, message)
      if level < log_level then
        return
      end
      
      local timestamp = os.date("%Y-%m-%d %H:%M:%S")
      local level_name = vim.log.levels[level] or "UNKNOWN"
      local log_line = string.format("[%s] %s: %s\n", timestamp, level_name, message)
      
      local file = io.open(log_file, "a")
      if file then
        file:write(log_line)
        file:close()
      end
    end
    
    function M.debug(message)
      write_log(vim.log.levels.DEBUG, message)
    end
    
    function M.info(message)
      write_log(vim.log.levels.INFO, message)
      vim.notify(message, vim.log.levels.INFO)
    end
    
    function M.warn(message)
      write_log(vim.log.levels.WARN, message)
      vim.notify(message, vim.log.levels.WARN)
    end
    
    function M.error(message)
      write_log(vim.log.levels.ERROR, message)
      vim.notify(message, vim.log.levels.ERROR)
    end
    
    function M.set_level(level)
      log_level = level
    end
    
    function M.get_log_path()
      return log_file
    end
    
    return M
    ```
    
    **Usage**:
    ```lua
    local logger = require("utils.logger")
    
    logger.debug("Loading configuration...")
    logger.info("Plugin initialized")
    logger.warn("Deprecated option used")
    logger.error("Failed to connect to LSP server")
    ```
  </custom_logging>
  
  <conditional_logging>
    ```lua
    -- Enable debug logging via environment variable
    local DEBUG = os.getenv("NVIM_DEBUG") == "1"
    
    local function debug_log(message)
      if DEBUG then
        print("[DEBUG] " .. message)
      end
    end
    
    -- Usage
    debug_log("Variable state: " .. vim.inspect(my_var))
    ```
    
    **Activation**:
    ```bash
    # Enable debug mode
    NVIM_DEBUG=1 nvim
    ```
  </conditional_logging>
  
  <structured_logging>
    ```lua
    -- Log with structured data
    local function log_event(event_type, data)
      local log_entry = {
        timestamp = os.time(),
        event = event_type,
        data = data,
      }
      
      local json = vim.fn.json_encode(log_entry)
      local log_file = vim.fn.stdpath("cache") .. "/events.jsonl"
      
      local file = io.open(log_file, "a")
      if file then
        file:write(json .. "\n")
        file:close()
      end
    end
    
    -- Usage
    log_event("plugin_loaded", { name = "telescope", time_ms = 45 })
    log_event("lsp_attached", { server = "lua_ls", bufnr = 1 })
    ```
  </structured_logging>
</logging_strategies>

---

## Minimal Config Testing

<minimal_config>
  <minimal_init>
    ```lua
    -- minimal.lua - Minimal configuration for testing
    
    -- Set up package path
    local root = vim.fn.fnamemodify("./.repro", ":p")
    
    -- Set stdpaths to use .repro directory
    for _, name in ipairs({ "config", "data", "state", "cache" }) do
      vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
    end
    
    -- Bootstrap lazy.nvim
    local lazypath = root .. "/plugins/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)
    
    -- Install only the plugin being tested
    require("lazy").setup({
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    })
    ```
    
    **Usage**:
    ```bash
    # Test with minimal config
    nvim -u minimal.lua
    
    # Test specific file
    nvim -u minimal.lua test.lua
    ```
  </minimal_init>
  
  <plugin_isolation>
    ```lua
    -- Test single plugin in isolation
    -- minimal_plugin.lua
    
    vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")
    
    require("lazy").setup({
      {
        "plugin/to/test",
        config = function()
          require("plugin").setup({
            -- minimal configuration
          })
        end,
      },
    })
    ```
  </plugin_isolation>
  
  <reproduction_template>
    ```lua
    -- repro.lua - Template for bug reports
    
    -- DO NOT change the paths
    local root = vim.fn.fnamemodify("./.repro", ":p")
    
    -- Set stdpaths
    for _, name in ipairs({ "config", "data", "state", "cache" }) do
      vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
    end
    
    -- Bootstrap lazy.nvim
    local lazypath = root .. "/plugins/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({ "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", lazypath })
    end
    vim.opt.rtp:prepend(lazypath)
    
    -- Install plugins
    require("lazy").setup({
      -- Add plugins that reproduce the issue
    })
    
    -- Add any additional config to reproduce the issue
    ```
  </reproduction_template>
</minimal_config>

---

## Bisecting Configuration

<bisecting>
  <binary_search_approach>
    ```lua
    -- Disable half of plugins to find problematic one
    -- lua/plugins/init.lua
    
    local TESTING = true  -- Toggle this
    
    local plugins = {
      -- First half
      { "plugin1" },
      { "plugin2" },
      { "plugin3" },
      
      -- Second half (disabled during testing)
      TESTING and {} or { "plugin4" },
      TESTING and {} or { "plugin5" },
      TESTING and {} or { "plugin6" },
    }
    
    return plugins
    ```
    
    **Process**:
    1. Disable half of plugins
    2. Test if issue persists
    3. If yes, issue is in enabled half
    4. If no, issue is in disabled half
    5. Repeat until single plugin identified
  </binary_search_approach>
  
  <git_bisect_config>
    ```bash
    # Use git bisect to find problematic commit
    
    # Start bisect
    git bisect start
    
    # Mark current (bad) commit
    git bisect bad
    
    # Mark last known good commit
    git bisect good <commit-hash>
    
    # Test each commit
    nvim --headless -c "lua require('test').run()" -c "quit"
    
    # Mark as good or bad
    git bisect good  # or git bisect bad
    
    # Repeat until found
    
    # End bisect
    git bisect reset
    ```
  </git_bisect_config>
  
  <incremental_loading>
    ```lua
    -- Load plugins incrementally to find issue
    local function load_plugins_incrementally()
      local plugins = {
        "telescope",
        "treesitter",
        "lspconfig",
        "cmp",
      }
      
      for i, plugin in ipairs(plugins) do
        print(string.format("Loading plugin %d/%d: %s", i, #plugins, plugin))
        
        local ok, err = pcall(require, plugin)
        if not ok then
          print(string.format("ERROR loading %s: %s", plugin, err))
          return false
        end
        
        print(string.format("✓ %s loaded successfully", plugin))
      end
      
      return true
    end
    ```
  </incremental_loading>
</bisecting>

---

## Common Issues and Solutions

<common_issues>
  <plugin_not_loading>
    **Symptoms**:
    - Plugin commands not available
    - Features not working
    - No errors in :messages
    
    **Diagnosis**:
    ```lua
    -- Check if plugin is loaded
    :lua print(vim.inspect(package.loaded["plugin_name"]))
    
    -- Check lazy.nvim status
    :Lazy
    
    -- Check plugin spec
    :lua print(vim.inspect(require("lazy.core.config").plugins["plugin-name"]))
    ```
    
    **Solutions**:
    - Verify plugin spec syntax
    - Check lazy-loading conditions
    - Ensure dependencies are loaded
    - Run :Lazy sync to install
  </plugin_not_loading>
  
  <lsp_not_attaching>
    **Symptoms**:
    - No diagnostics
    - No completion
    - LSP features not working
    
    **Diagnosis**:
    ```lua
    -- Check attached clients
    :lua print(vim.inspect(vim.lsp.get_clients()))
    
    -- Check LSP log
    :LspLog
    
    -- Check server installation
    :Mason
    ```
    
    **Solutions**:
    ```lua
    -- Verify server is installed
    :Mason
    
    -- Check filetype detection
    :set filetype?
    
    -- Manually start server
    :LspStart
    
    -- Check server configuration
    :lua print(vim.inspect(require("lspconfig").lua_ls))
    ```
  </lsp_not_attaching>
  
  <slow_startup>
    **Symptoms**:
    - Long startup time
    - Delayed UI rendering
    - Laggy initial input
    
    **Diagnosis**:
    ```bash
    # Profile startup
    nvim --startuptime startup.log +qall
    
    # View slowest operations
    sort -k2 -n startup.log | tail -20
    ```
    
    **Solutions**:
    - Convert plugins to lazy-loading
    - Defer UI initialization
    - Remove unused plugins
    - Optimize autocommands
    - See performance-optimization.md
  </slow_startup>
  
  <treesitter_errors>
    **Symptoms**:
    - Syntax highlighting broken
    - "No parser for X" errors
    - Treesitter crashes
    
    **Diagnosis**:
    ```vim
    :TSInstallInfo
    :checkhealth nvim-treesitter
    :InspectTree
    ```
    
    **Solutions**:
    ```vim
    " Install missing parser
    :TSInstall <language>
    
    " Update all parsers
    :TSUpdate
    
    " Reinstall parser
    :TSUninstall <language>
    :TSInstall <language>
    ```
  </treesitter_errors>
  
  <keybinding_conflicts>
    **Symptoms**:
    - Keybinding not working
    - Wrong action triggered
    - Multiple mappings for same key
    
    **Diagnosis**:
    ```vim
    " View all mappings for a key
    :nmap <leader>f
    :verbose nmap <leader>f
    
    " Check which-key registrations
    :WhichKey
    ```
    
    **Solutions**:
    ```lua
    -- Find conflicting mappings
    local function find_keymap_conflicts(mode, lhs)
      local maps = vim.api.nvim_get_keymap(mode)
      local conflicts = {}
      
      for _, map in ipairs(maps) do
        if map.lhs == lhs then
          table.insert(conflicts, map)
        end
      end
      
      return conflicts
    end
    
    -- Usage
    :lua print(vim.inspect(find_keymap_conflicts("n", "<leader>ff")))
    ```
  </keybinding_conflicts>
</common_issues>

---

## Debugging Workflow

<debugging_workflow>
  <step_by_step>
    1. **Identify the problem**
       - What is not working?
       - When did it start?
       - What changed recently?
    
    2. **Check error messages**
       - :messages
       - :checkhealth
       - :LspLog
    
    3. **Test in minimal config**
       - nvim -u minimal.lua
       - Does issue persist?
    
    4. **Bisect configuration**
       - Disable half of plugins
       - Narrow down to specific plugin/config
    
    5. **Enable debug logging**
       - vim.lsp.set_log_level("debug")
       - Custom logger with DEBUG mode
    
    6. **Isolate and reproduce**
       - Create minimal reproduction
       - Document steps to reproduce
    
    7. **Fix and verify**
       - Apply fix
       - Test thoroughly
       - Document solution
  </step_by_step>
  
  <debugging_checklist>
    - [ ] Check :messages for errors
    - [ ] Run :checkhealth
    - [ ] Review LSP logs if applicable
    - [ ] Test with minimal config
    - [ ] Check plugin loading status
    - [ ] Verify external dependencies
    - [ ] Review recent configuration changes
    - [ ] Search for similar issues online
    - [ ] Create minimal reproduction
    - [ ] Document findings
  </debugging_checklist>
</debugging_workflow>
