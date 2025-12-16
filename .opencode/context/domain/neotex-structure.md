# NeoTeX Structure

**Domain**: Specific NeoVim configuration organization for this setup

---

## Directory Organization

<structure>
  /home/benjamin/.config/nvim/
    init.lua                      # Main entry point
    lua/
      core/                       # Core settings
        options.lua              # vim.opt settings
        autocmds.lua             # Autocommands
      plugins/                    # Plugin specs (lazy.nvim)
        {plugin-name}.lua        # One file per plugin/category
      lsp/                        # LSP configurations
        servers/                 # Per-language server configs
        init.lua                 # LSP setup orchestration
      config/                     # Feature configurations
        keymaps/                 # Keybinding modules
          which-key.lua          # Leader key mappings
          keymaps.lua            # Non-leader mappings
        autocmds/                # Autocommand modules
      utils/                      # Utility modules
</structure>

---

## Configuration Principles

<principles>
  <modularity>
    - One concern per file
    - Clear module boundaries
    - Explicit dependencies
  </modularity>
  
  <organization>
    - Plugin specs in plugins/
    - LSP configs in lsp/
    - Core settings in core/
    - Feature configs in config/
  </organization>
  
  <keybinding_split>
    - Leader mappings → which-key.lua
    - Direct mappings → keymaps.lua
    - Categorized and documented
  </keybinding_split>
</principles>

---

## Standards Compliance

All code follows `/home/benjamin/.config/STANDARDS.md`:
- Naming conventions (snake_case files, clear names)
- Documentation requirements (LuaDoc comments)
- Module patterns (local M = {})
- Error handling (pcall for risky operations)
