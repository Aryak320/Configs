# NeoVim LSP System

**Domain**: Language Server Protocol integration

---

## LSP Architecture

<architecture>
  <client_server>
    - NeoVim LSP client (built-in)
    - Language servers (external processes)
    - JSON-RPC communication
    - Asynchronous operation
  </client_server>
  
  <components>
    - nvim-lspconfig: Server configurations
    - mason.nvim: Server installation
    - nvim-cmp: Completion integration
    - null-ls/conform: Formatting/linting
  </components>
</architecture>

---

## LSP Capabilities

<capabilities>
  <code_intelligence>
    - Go to definition (gd)
    - Find references (gr)
    - Hover documentation (K)
    - Signature help
  </code_intelligence>
  
  <diagnostics>
    - Real-time error detection
    - Warning and info messages
    - Diagnostic navigation
    - Virtual text display
  </diagnostics>
  
  <code_actions>
    - Quick fixes
    - Refactoring operations
    - Import organization
    - Code generation
  </code_actions>
  
  <formatting>
    - Document formatting
    - Range formatting
    - Format on save
    - Formatter integration
  </formatting>
</capabilities>

---

## Configuration Pattern

<configuration>
  <on_attach>
    ```lua
    local on_attach = function(client, bufnr)
      -- Setup buffer-local keybindings
      -- Configure formatting
      -- Enable inlay hints
    end
    ```
  </on_attach>
  
  <capabilities>
    ```lua
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    ```
  </capabilities>
  
  <server_setup>
    ```lua
    require('lspconfig').lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = {'vim'} }
        }
      }
    })
    ```
  </server_setup>
</configuration>

---

## Common Language Servers

<servers>
  <lua>lua_ls (Lua Language Server)</lua>
  <python>pyright, pylsp</python>
  <rust>rust_analyzer</rust>
  <typescript>tsserver, denols</typescript>
  <lean>lean_ls (Lean 4)</lean>
  <latex>texlab (LaTeX)</latex>
</servers>
