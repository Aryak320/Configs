# NeoVim Plugin Ecosystem

**Domain**: NeoVim plugin landscape and management

---

## Plugin Manager: lazy.nvim

<lazy_nvim>
  <features>
    - Automatic lazy-loading
    - Fast startup optimization
    - Lock file for reproducibility
    - Plugin profiling
    - UI for management
  </features>
  
  <spec_format>
    ```lua
    return {
      "owner/repo",
      event = "VeryLazy",    -- Lazy-load trigger
      dependencies = {...},  -- Plugin dependencies
      opts = {...},          -- Configuration options
      config = function()    -- Setup function
        require("plugin").setup()
      end,
    }
    ```
  </spec_format>
  
  <lazy_loading_triggers>
    - event: Event-based (VeryLazy, BufRead, etc.)
    - cmd: Command-based loading
    - ft: Filetype-based loading
    - keys: Keybinding-based loading
    - lazy = true: Manual loading
  </lazy_loading_triggers>
</lazy_nvim>

---

## Essential Plugin Categories

<categories>
  <lsp_completion>
    - nvim-lspconfig: LSP client configurations
    - mason.nvim: LSP/DAP/linter installer
    - nvim-cmp: Completion engine
    - LuaSnip: Snippet engine
  </lsp_completion>
  
  <treesitter>
    - nvim-treesitter: Syntax highlighting
    - Tree-sitter parsers
    - Incremental selection
    - Code analysis
  </treesitter>
  
  <fuzzy_finding>
    - telescope.nvim: Fuzzy finder
    - fzf-lua: Alternative fuzzy finder
    - Pickers for files, grep, buffers
  </fuzzy_finding>
  
  <git>
    - neogit: Git interface
    - gitsigns.nvim: Git decorations
    - diffview.nvim: Diff viewer
  </git>
  
  <ui>
    - lualine.nvim: Statusline
    - nvim-tree.lua: File explorer
    - which-key.nvim: Keybinding hints
    - nvim-notify: Notifications
  </ui>
</categories>

---

## Plugin Management Best Practices

<best_practices>
  <lazy_loading>
    - Heavy plugins (telescope, nvim-tree): event = "VeryLazy"
    - Language-specific: ft = "python"
    - Command-heavy: cmd = {"CommandName"}
    - Defer UI plugins when possible
  </lazy_loading>
  
  <dependencies>
    - Use dependencies field for plugin chains
    - Automatic loading of dependencies
    - Version pinning with commit/tag
  </dependencies>
  
  <organization>
    - One plugin per file in lua/plugins/
    - Group related plugins
    - Clear, descriptive filenames
  </organization>
</best_practices>
