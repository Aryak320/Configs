# NeoVim Architecture

**Domain**: Core NeoVim architecture and design

---

## Core Components

<architecture>
  <init_system>
    - init.lua: Main entry point
    - Runtime path management
    - Plugin loading orchestration
    - Configuration modules
  </init_system>
  
  <plugin_system>
    - lazy.nvim: Plugin manager
    - Lazy-loading mechanisms
    - Event-based loading
    - Dependency management
  </plugin_system>
  
  <lua_runtime>
    - Lua 5.1/LuaJIT
    - vim.* API modules
    - Built-in Lua stdlib
    - Module system (require/package)
  </lua_runtime>
  
  <api_layers>
    - vim.api: Low-level NeoVim API
    - vim.fn: Vimscript function access
    - vim.lsp: LSP client API
    - vim.treesitter: Tree-sitter integration
    - vim.diagnostic: Diagnostic system
  </api_layers>
</architecture>

---

## Configuration Structure

<structure>
  <typical_layout>
    ~/.config/nvim/
      init.lua              # Entry point
      lua/
        core/              # Core settings (options, keymaps)
        plugins/           # Plugin specifications
        lsp/               # LSP configurations
        config/            # Feature configurations
        utils/             # Utility modules
  </typical_layout>
  
  <loading_order>
    1. init.lua execution
    2. Core module loading
    3. Plugin manager bootstrap
    4. Plugin specifications loaded
    5. Lazy-loading setup
    6. Event-driven plugin loading
  </loading_order>
</structure>

---

## Key Concepts

<concepts>
  <autocommands>
    - Event-driven configuration
    - vim.api.nvim_create_autocmd
    - Autogroups for organization
    - Common events: BufEnter, VimEnter, FileType
  </autocommands>
  
  <lazy_loading>
    - Defer plugin loading until needed
    - Event triggers (VeryLazy, BufRead, etc.)
    - Command triggers (cmd = "CommandName")
    - Filetype triggers (ft = "python")
  </lazy_loading>
  
  <buffer_window>
    - Buffers: In-memory file representations
    - Windows: Viewports into buffers
    - Tabs: Window container layouts
    - Buffer-local vs global settings
  </buffer_window>
</concepts>

---

## References

- NeoVim Documentation: https://neovim.io/doc/
- Lua Guide: https://neovim.io/doc/user/lua-guide.html
- API Documentation: https://neovim.io/doc/user/api.html
