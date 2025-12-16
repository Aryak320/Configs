# Essential Patterns

Common patterns for NeoVim configuration tasks. These patterns follow the coding standards defined in `/home/benjamin/.config/nvim/CLAUDE.md` and `/home/benjamin/.config/nvim/docs/CODE_STANDARDS.md`.

## Pattern: Add Plugin

**Use Case**: Adding a new plugin to lazy.nvim configuration

**Steps**:
1. Create new file in appropriate `lua/neotex/plugins/` subdirectory
2. Return lazy.nvim plugin specification table
3. Configure lazy loading (event, ft, cmd, or keys)
4. Add dependencies if needed
5. Configure plugin in `config` function or `opts` table

**Code Example**:
```lua
-- lua/neotex/plugins/editor/new-plugin.lua
return {
  "author/plugin-name",
  event = "VeryLazy",  -- Lazy load after startup
  dependencies = {
    "required/dependency",
  },
  opts = {
    -- Plugin configuration options
    enabled = true,
    timeout = 5000,
  },
  config = function(_, opts)
    require("plugin-name").setup(opts)
  end,
}
```

**Troubleshooting**:
- **Plugin not loading**: Check event trigger (VeryLazy, BufReadPre, etc.)
- **Dependency errors**: Ensure dependencies listed in `dependencies` table
- **Configuration not applied**: Verify `config` function calls `setup(opts)`
- **Slow startup**: Use lazy loading events instead of loading at startup

---

## Pattern: Setup LSP Server

**Use Case**: Configuring a new language server with nvim-lspconfig

**Steps**:
1. Open `lua/neotex/plugins/lsp/lspconfig.lua`
2. Add `vim.lsp.config()` call for new server
3. Specify cmd, filetypes, and root_markers
4. Configure server-specific settings
5. Add server name to `vim.lsp.enable()` call

**Code Example**:
```lua
-- In lua/neotex/plugins/lsp/lspconfig.lua config function
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- Add to enable call
vim.lsp.enable({ "lua_ls", "pyright", "texlab", "rust_analyzer" })
```

**Troubleshooting**:
- **Server not starting**: Verify LSP binary installed (`which rust-analyzer`)
- **Wrong root directory**: Check root_markers match project structure
- **Capabilities missing**: Ensure `capabilities` variable passed to config
- **Settings not applied**: Check server documentation for correct settings structure
- **Multiple instances**: Ensure server name added to `vim.lsp.enable()` call

---

## Pattern: Optimize Performance

**Use Case**: Improving NeoVim startup time and runtime performance

**Steps**:
1. Profile startup with `:StartupTime` command
2. Identify slow-loading plugins
3. Add lazy loading events to plugin specs
4. Cache expensive computations
5. Use autocommands instead of polling

**Code Example**:
```lua
-- Before: Loads at startup (slow)
return {
  "heavy/plugin",
  config = function()
    require("heavy.plugin").setup()
  end,
}

-- After: Lazy loads on event (fast)
return {
  "heavy/plugin",
  event = "VeryLazy",  -- Load after startup complete
  config = function()
    require("heavy.plugin").setup()
  end,
}

-- Cache expensive operations
local M = {}
local _cached_root = nil

function M.get_git_root()
  if _cached_root then
    return _cached_root
  end
  
  local ok, result = pcall(vim.fn.systemlist, "git rev-parse --show-toplevel")
  if ok and vim.v.shell_error == 0 then
    _cached_root = result[1]
    return _cached_root
  end
  
  return vim.fn.getcwd()
end
```

**Troubleshooting**:
- **Still slow**: Check `:StartupTime` for remaining bottlenecks
- **Plugin not working**: Event trigger may be too late, try earlier event
- **Cache stale**: Invalidate cache on relevant events (DirChanged, etc.)
- **Target**: Aim for <150ms startup time

---

## Pattern: Debug Issue

**Use Case**: Diagnosing and fixing NeoVim configuration problems

**Steps**:
1. Check `:messages` for error messages
2. Use `:verbose map <key>` to find keymap conflicts
3. Verify module loading with `:lua print(vim.inspect(package.loaded))`
4. Reload module during development
5. Check plugin lazy loading with `:Lazy`

**Code Example**:
```lua
-- Check for errors
:messages

-- Find keymap conflicts
:verbose map <leader>ff

-- Inspect loaded modules
:lua print(vim.inspect(package.loaded["neotex.plugins.editor.telescope"]))

-- Reload module during development
:lua package.loaded['neotex.plugins.editor.telescope'] = nil
:lua require('neotex.plugins.editor.telescope')

-- Check plugin status
:Lazy

-- Debug with pcall
local ok, err = pcall(require, "problematic.module")
if not ok then
  vim.notify("Error loading module: " .. err, vim.log.levels.ERROR)
end
```

**Troubleshooting**:
- **No error messages**: Check `:checkhealth` for plugin issues
- **Module not found**: Verify file path matches require statement
- **Keymap not working**: Check if plugin loaded (`:Lazy` command)
- **Silent failures**: Add pcall error handling to identify issues

---

## Pattern: Add Keybinding

**Use Case**: Adding new keybindings following centralized keymap strategy

**Steps**:
1. For non-leader keys: Add to `lua/neotex/config/keymaps.lua`
2. For leader keys: Add to `lua/neotex/plugins/editor/which-key.lua`
3. For buffer-local: Create dedicated function
4. Use descriptive descriptions for which-key integration
5. Check for conflicts with `:verbose map <key>`

**Code Example**:
```lua
-- Non-leader keymap in lua/neotex/config/keymaps.lua
local map = vim.keymap.set

map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Leader keymap in lua/neotex/plugins/editor/which-key.lua
wk.add({
  { "<leader>f", group = "Find" },
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
})

-- Buffer-local keymap
function _G.set_markdown_keymaps()
  local buf_map = vim.keymap.set
  buf_map("n", "<C-n>", "<cmd>AutolistToggleCheckbox<CR>", {
    buffer = 0,
    desc = "Toggle checkbox",
  })
end

-- Call in autocommand
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    _G.set_markdown_keymaps()
  end,
})
```

**Troubleshooting**:
- **Keymap not working**: Check `:verbose map <key>` for conflicts
- **Which-key not showing**: Verify leader key set before which-key loads
- **Buffer-local not applying**: Check FileType autocommand pattern
- **Conflicts**: Keep plugin `keys = {}` empty to prevent conflicts

---

## Pattern: Configure Plugin

**Use Case**: Customizing plugin behavior and settings

**Steps**:
1. Read plugin documentation for available options
2. Use `opts` table for simple configuration
3. Use `config` function for complex setup
4. Add dependencies if plugin requires them
5. Configure lazy loading appropriately

**Code Example**:
```lua
-- Simple configuration with opts
return {
  "plugin/name",
  event = "VeryLazy",
  opts = {
    enabled = true,
    timeout = 5000,
    features = {
      auto_save = true,
    },
  },
}

-- Complex configuration with config function
return {
  "plugin/name",
  event = "VeryLazy",
  dependencies = {
    "required/dependency",
  },
  config = function()
    local plugin = require("plugin.name")
    
    -- Custom setup logic
    plugin.setup({
      enabled = true,
      on_attach = function(client, bufnr)
        -- Custom on_attach logic
      end,
    })
    
    -- Additional configuration
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        plugin.format()
      end,
    })
  end,
}
```

**Troubleshooting**:
- **Options not applied**: Check plugin docs for correct option names
- **Config function not running**: Verify plugin loaded (`:Lazy`)
- **Dependencies missing**: Add to `dependencies` table
- **Lazy loading issues**: Adjust event trigger timing

---

## Pattern: Test Changes

**Use Case**: Validating configuration changes before committing

**Steps**:
1. Check startup time with `:StartupTime`
2. Verify no errors in `:messages`
3. Test affected functionality manually
4. Check for keymap conflicts
5. Verify lazy loading works correctly

**Code Example**:
```lua
-- Check startup time (target <150ms)
:StartupTime

-- Check for errors
:messages

-- Verify plugin loaded
:Lazy

-- Check keymap
:verbose map <leader>ff

-- Test plugin functionality
:Telescope find_files

-- Reload configuration
:source $MYVIMRC

-- Check health
:checkhealth
```

**Troubleshooting**:
- **Startup slow**: Profile with `:StartupTime`, add lazy loading
- **Errors on startup**: Check `:messages` for stack traces
- **Plugin not working**: Verify loaded with `:Lazy`
- **Keymap conflicts**: Use `:verbose map` to identify conflicts

---

## Pattern: Refactor Code

**Use Case**: Improving code quality following clean-break development

**Steps**:
1. Map all usages of code to refactor
2. Design new architecture without legacy constraints
3. Update ALL references in single atomic change
4. Remove old implementation completely
5. Test thoroughly to ensure functionality preserved

**Code Example**:
```lua
-- Before: Scattered keymap definitions
-- In plugin file
return {
  "plugin/name",
  keys = {
    { "<leader>x", "<cmd>PluginCommand<cr>" },
  },
}

-- After: Centralized in which-key.lua
-- In plugin file (empty keys)
return {
  "plugin/name",
  event = "VeryLazy",
  keys = {},  -- Prevent conflicts
}

-- In lua/neotex/plugins/editor/which-key.lua
wk.add({
  { "<leader>x", "<cmd>PluginCommand<cr>", desc = "Execute plugin" },
})

-- Delete old implementation completely (no compatibility shims)
-- Remove commented-out code
-- Update documentation to reflect only current patterns
```

**Troubleshooting**:
- **Missed references**: Use `:grep` to find all usages
- **Functionality broken**: Test each change incrementally
- **Compatibility concerns**: Trust git history, delete old code
- **Documentation outdated**: Update docs to match current implementation

---

## Pattern: Update Documentation

**Use Case**: Maintaining accurate documentation for configuration

**Steps**:
1. Update README.md in affected directories
2. Remove historical commentary
3. Document current implementation only
4. Include code examples with syntax highlighting
5. Update navigation links

**Code Example**:
```markdown
# Plugin Name

Brief description of plugin purpose and functionality.

## Configuration

Current configuration approach:

```lua
return {
  "plugin/name",
  event = "VeryLazy",
  opts = {
    enabled = true,
  },
}
```

## Usage

Key features and usage patterns:

- Feature 1: Description
- Feature 2: Description

## Keybindings

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>x` | n | Execute plugin |

## Navigation

- [← Parent Directory](../README.md)
- [Subdirectory →](subdirectory/README.md)
```

**Troubleshooting**:
- **Historical notes**: Remove "Changed from X to Y" comments
- **Outdated examples**: Update code examples to match current implementation
- **Missing navigation**: Add links to parent and subdirectories
- **Emojis**: Do not use emojis in file content (UTF-8 encoding issues)

---

## Pattern: Rollback Changes

**Use Case**: Reverting problematic changes using git

**Steps**:
1. Identify commit to revert
2. Use git to rollback changes
3. Test configuration after rollback
4. Document reason for rollback
5. Plan alternative approach

**Code Example**:
```bash
# View recent commits
git log --oneline -10

# Revert specific commit
git revert <commit-hash>

# Revert multiple commits
git revert <commit-hash-1> <commit-hash-2>

# Reset to previous commit (destructive)
git reset --hard HEAD~1

# Create new branch for alternative approach
git checkout -b fix/alternative-approach

# Test configuration
nvim --startuptime startup.log
```

**Troubleshooting**:
- **Merge conflicts**: Resolve conflicts manually, test thoroughly
- **Lost work**: Use `git reflog` to recover lost commits
- **Partial revert**: Use `git revert -n` to stage without committing
- **Alternative approach**: Create new branch to test different solution

---

## Pattern: Add Autocommand

**Use Case**: Executing code automatically on NeoVim events

**Steps**:
1. Create augroup with descriptive name
2. Define autocommand with event and pattern
3. Use callback function for logic
4. Add description for documentation
5. Clear group to prevent duplicates

**Code Example**:
```lua
-- Create augroup
local augroup = vim.api.nvim_create_augroup("NeotexCustom", { clear = true })

-- Add autocommand
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*.lua",
  callback = function()
    -- Format Lua files before saving
    vim.lsp.buf.format({ async = false })
  end,
  desc = "Format Lua files on save",
})

-- Multiple events
vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
  group = augroup,
  pattern = "*.tex",
  callback = function()
    require("neotex.plugins.text.vimtex").setup_buffer()
  end,
  desc = "Setup VimTeX for LaTeX files",
})

-- Filetype-specific
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = "Enable wrap and spell for Markdown",
})
```

**Troubleshooting**:
- **Autocommand not firing**: Check event name and pattern
- **Duplicate execution**: Ensure augroup has `clear = true`
- **Performance issues**: Avoid expensive operations in frequently-fired events
- **Pattern not matching**: Use `:autocmd` to verify pattern syntax

---

## Pattern: Create Utility Module

**Use Case**: Extracting reusable functionality into utility module

**Steps**:
1. Create file in `lua/neotex/util/` directory
2. Follow standard module structure
3. Define private helper functions
4. Export public API functions
5. Add LuaLS documentation

**Code Example**:
```lua
-- lua/neotex/util/custom_utils.lua

-- Brief module description
--
-- Provides utility functions for custom operations.

local M = {}

-- Constants
local DEFAULT_TIMEOUT = 5000

-- Private helper functions
local function _validate_input(input)
  if not input or type(input) ~= "string" then
    return false, "Input must be a non-empty string"
  end
  return true
end

-- Public API

--- Process input with validation
---@param input string Input to process
---@param opts table|nil Optional configuration
---@return string|nil Processed result or nil on error
---@return string|nil Error message if failed
function M.process(input, opts)
  opts = opts or {}
  
  local valid, err = _validate_input(input)
  if not valid then
    return nil, err
  end
  
  local timeout = opts.timeout or DEFAULT_TIMEOUT
  local result = input:upper()  -- Example processing
  
  return result
end

--- Setup module with configuration
---@param opts table|nil Configuration options
function M.setup(opts)
  opts = opts or {}
  -- Setup logic
end

return M
```

**Troubleshooting**:
- **Module not found**: Verify file path matches require statement
- **Private functions exposed**: Prefix with underscore `_function_name`
- **Missing documentation**: Add LuaLS annotations for public functions
- **Circular dependencies**: Avoid requiring modules that require this module

---

## Pattern: Handle Errors Gracefully

**Use Case**: Implementing robust error handling in configuration

**Steps**:
1. Use pcall for operations that might fail
2. Return nil + error message for recoverable errors
3. Validate inputs at function boundaries
4. Provide fallback behavior when possible
5. Log errors with vim.notify

**Code Example**:
```lua
-- Protected plugin loading
local ok, plugin = pcall(require, "external.plugin")
if not ok then
  vim.notify("Plugin 'external.plugin' not available", vim.log.levels.WARN)
  return
end

-- Error propagation pattern
function M.load_config(config_path)
  -- Validate input
  if not config_path or type(config_path) ~= "string" then
    return nil, "Config path must be a string"
  end
  
  -- Check file exists
  if vim.fn.filereadable(config_path) ~= 1 then
    return nil, "Config file not found: " .. config_path
  end
  
  -- Protected file read
  local ok, content = pcall(vim.fn.readfile, config_path)
  if not ok then
    return nil, "Failed to read config file: " .. content
  end
  
  return content
end

-- Fallback behavior
function M.get_git_root()
  local ok, result = pcall(vim.fn.systemlist, "git rev-parse --show-toplevel")
  if ok and vim.v.shell_error == 0 then
    return result[1]
  end
  
  -- Fallback to current directory
  vim.notify("Not in git repository, using current directory", vim.log.levels.INFO)
  return vim.fn.getcwd()
end
```

**Troubleshooting**:
- **Silent failures**: Add vim.notify for user feedback
- **Cascade errors**: Use pcall to isolate failures
- **Unclear errors**: Provide descriptive error messages
- **No fallback**: Consider graceful degradation when possible

---

## Summary

These patterns cover the most common NeoVim configuration tasks:

1. **Add Plugin**: Lazy.nvim plugin specification with lazy loading
2. **Setup LSP Server**: Language server configuration with vim.lsp.config
3. **Optimize Performance**: Startup time optimization and caching
4. **Debug Issue**: Diagnostic commands and troubleshooting workflow
5. **Add Keybinding**: Centralized keymap management strategy
6. **Configure Plugin**: Plugin customization with opts and config
7. **Test Changes**: Validation checklist before committing
8. **Refactor Code**: Clean-break development approach
9. **Update Documentation**: Documentation standards and format
10. **Rollback Changes**: Git-based change management
11. **Add Autocommand**: Event-driven automation patterns
12. **Create Utility Module**: Reusable module structure
13. **Handle Errors**: Robust error handling patterns

All patterns follow the coding standards defined in:
- `/home/benjamin/.config/nvim/CLAUDE.md`
- `/home/benjamin/.config/nvim/docs/CODE_STANDARDS.md`
- `/home/benjamin/.config/STANDARDS.md`

For detailed coding conventions, module structure, and development process, refer to the standards documentation.
