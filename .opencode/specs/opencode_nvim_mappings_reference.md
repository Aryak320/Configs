# OpenCode.nvim Mappings Reference

**Date**: 2025-12-19  
**Purpose**: Comprehensive reference of all opencode.nvim keybindings and API functions  
**Location**: This document provides a complete overview to facilitate customization decisions

---

## Table of Contents

1. [Current Configuration Overview](#current-configuration-overview)
2. [Global Keybindings](#global-keybindings)
3. [Which-Key Keybindings](#which-key-keybindings)
4. [Terminal-Specific Keybindings](#terminal-specific-keybindings)
5. [Available API Functions](#available-api-functions)
6. [Context Placeholders](#context-placeholders)
7. [Built-in Prompts](#built-in-prompts)
8. [Commands](#commands)
9. [Recommended Default Mappings](#recommended-default-mappings)
10. [Configuration Files](#configuration-files)

---

## Current Configuration Overview

Your opencode.nvim configuration has **disabled all default plugin keymaps** and uses custom bindings defined in your neotex configuration.

**Key Configuration Settings** (from `/home/benjamin/.config/nvim/lua/neotex/plugins/ai/opencode.lua:48`):
```lua
-- Disable ALL default keymaps (prevent conflicts with Vim defaults)
keys = {},
```

---

## Global Keybindings

**Location**: `/home/benjamin/.config/nvim/lua/neotex/config/keymaps.lua:283`

| Keymap | Mode | Function | Description |
|--------|------|----------|-------------|
| `<C-CR>` | Normal, Insert | `require("opencode").toggle()` | Toggle OpenCode terminal window |

---

## Which-Key Keybindings

**Location**: `/home/benjamin/.config/nvim/lua/neotex/plugins/editor/which-key.lua:259-265`

All mappings are under the `<leader>a` prefix (AI commands group):

| Keymap | Mode | Function | Description | Icon |
|--------|------|----------|-------------|------|
| `<leader>ab` | Normal | `require("opencode").prompt("@buffer")` | Send current buffer as context | 󰈙 |
| `<leader>ad` | Normal | `require("opencode").prompt("@diagnostics")` | Send diagnostics as context | 󰒓 |
| `<leader>as` | Normal | `require("opencode").select()` | Open action selector menu | 󰒋 |
| `<leader>ah` | Normal | `require("opencode").command("session.list")` | Show session history | 󰆼 |

### Commented-Out Which-Key Bindings

The following are **disabled** but available for activation:

| Keymap | Mode | Function | Description | Icon |
|--------|------|----------|-------------|------|
| `<leader>aa` | Normal, Visual | `require("opencode").ask()` | Ask opencode (interactive prompt) | 󰘳 |
| `<leader>ai` | Normal | `require("opencode").command("session.new")` | Initialize new session | 󰐕 |
| `<leader>ao` | Normal | `require("opencode").toggle()` | Toggle opencode (duplicate of `<C-CR>`) | 󰚩 |
| `<leader>ap` | Normal, Visual | `require("opencode").prompt("@this")` | Prompt with current selection/cursor | 󰏪 |

---

## Terminal-Specific Keybindings

**Location**: `/home/benjamin/.config/nvim/lua/neotex/config/keymaps.lua:133-144`

### OpenCode Terminal Only

These bindings are **only active** when `vim.bo.filetype == "opencode_terminal"`:

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<C-j>` | Terminal | `<Down>` | Navigate menu down (arrow key) |
| `<C-k>` | Terminal | `<Up>` | Navigate menu up (arrow key) |
| `<C-h>` | Terminal | `<Cmd>wincmd h<CR>` | Navigate to left window |
| `<C-l>` | Terminal | `<Cmd>wincmd l<CR>` | Navigate to right window |
| `<C-CR>` | Terminal | `require('opencode').toggle()` | Close OpenCode terminal |

### Universal Terminal Bindings (All terminals)

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<M-Right>` | Terminal | Resize vertical -2 | Shrink terminal width |
| `<M-Left>` | Terminal | Resize vertical +2 | Expand terminal width |
| `<M-l>` | Terminal | Resize vertical -2 | Shrink terminal width (Alt+l) |
| `<M-h>` | Terminal | Resize vertical +2 | Expand terminal width (Alt+h) |

**Note**: `<Esc>` mapping is **skipped** for OpenCode terminals to allow internal normal mode usage.

---

## Available API Functions

**Source**: `/home/benjamin/.local/share/nvim/lazy/opencode.nvim/lua/opencode.lua`

The `require("opencode")` module exposes these public functions:

### Core Functions

| Function | Purpose | Example Usage |
|----------|---------|---------------|
| `ask(prompt?, opts?)` | Interactive input prompt for opencode | `require("opencode").ask("@this: ", { submit = true })` |
| `select()` | Open picker to select from all functionality | `require("opencode").select()` |
| `prompt(text, opts?)` | Send prompt directly to opencode | `require("opencode").prompt("@buffer")` |
| `command(cmd)` | Execute opencode command | `require("opencode").command("session.list")` |
| `toggle()` | Toggle opencode terminal visibility | `require("opencode").toggle()` |
| `start()` | Start opencode terminal | `require("opencode").start()` |
| `stop()` | Stop opencode terminal | `require("opencode").stop()` |
| `statusline()` | Get statusline component | For lualine integration |

### Function Options

**`ask(prompt?, opts?)`**:
- `prompt` (string): Initial prompt text (supports context placeholders)
- `opts.submit` (boolean): Auto-submit after entering prompt
- `opts.blink_cmp_sources` (table): Completion sources for blink.cmp

**`prompt(text, opts?)`**:
- `text` (string): Prompt text with context placeholders
- `opts.submit` (boolean): Auto-submit prompt
- `opts.clear` (boolean): Clear input after submitting

**`select()`**:
- Opens picker with three sections: Prompts, Commands, Provider actions
- Supports preview when using snacks.picker

---

## Context Placeholders

**Source**: `/home/benjamin/.local/share/nvim/lazy/opencode.nvim/lua/opencode/config.lua:49-58`

These placeholders inject editor context into prompts:

| Placeholder | Context Injected | Use Case |
|-------------|------------------|----------|
| `@this` | Visual selection or cursor position | Selected code/text or line under cursor |
| `@buffer` | Entire current buffer | Full file content |
| `@buffers` | All open buffers | Multi-file context |
| `@visible` | Visible text in viewport | What you see on screen |
| `@diagnostics` | LSP diagnostics for buffer | Errors, warnings, hints |
| `@quickfix` | Quickfix list entries | Search results, errors |
| `@diff` | Git diff for current changes | Uncommitted changes |
| `@grapple` | Grapple.nvim tags | Bookmarked files |

### Example Usage

```lua
-- Explain current selection or cursor line
require("opencode").prompt("Explain @this")

-- Fix all diagnostics in current buffer
require("opencode").prompt("Fix @diagnostics", { submit = true })

-- Review git changes
require("opencode").prompt("Review @diff for correctness", { submit = true })
```

---

## Built-in Prompts

**Source**: `/home/benjamin/.local/share/nvim/lazy/opencode.nvim/lua/opencode/config.lua:59-71`

These named prompts can be referenced by name:

| Name | Prompt Template | Auto-submit | Description |
|------|----------------|-------------|-------------|
| `ask_append` | `""` | No | Opens ask() for inserting context mid-prompt |
| `ask_this` | `"@this: "` | Yes | Ask about current selection/cursor with follow-up |
| `diagnostics` | `"Explain @diagnostics"` | Yes | Explain current diagnostics |
| `diff` | `"Review the following git diff for correctness and readability: @diff"` | Yes | Review git changes |
| `document` | `"Add comments documenting @this"` | Yes | Document code at cursor/selection |
| `explain` | `"Explain @this and its context"` | Yes | Explain code in context |
| `fix` | `"Fix @diagnostics"` | Yes | Fix LSP errors/warnings |
| `implement` | `"Implement @this"` | Yes | Implement TODO/stub/interface |
| `optimize` | `"Optimize @this for performance and readability"` | Yes | Optimize code |
| `review` | `"Review @this for correctness and readability"` | Yes | Code review |
| `test` | `"Add tests for @this"` | Yes | Generate tests |

### Using Named Prompts

Via `select()`:
```lua
require("opencode").select()  -- Then choose a prompt from the picker
```

Direct reference (custom config):
```lua
-- In your config
vim.keymap.set("n", "<leader>ae", function()
  require("opencode").prompt("explain", { submit = true })
end)
```

---

## Commands

**Source**: `/home/benjamin/.local/share/nvim/lazy/opencode.nvim/README.md:256-274`

OpenCode session control commands (via `require("opencode").command(cmd)`):

### Session Management

| Command | Description |
|---------|-------------|
| `session.list` | List all sessions |
| `session.new` | Start a new session |
| `session.share` | Share the current session |
| `session.interrupt` | Interrupt current response |
| `session.compact` | Compact session (reduce context size) |
| `session.undo` | Undo last action |
| `session.redo` | Redo last undone action |

### Navigation

| Command | Description |
|---------|-------------|
| `session.page.up` | Scroll up one page |
| `session.page.down` | Scroll down one page |
| `session.half.page.up` | Scroll up half page |
| `session.half.page.down` | Scroll down half page |
| `session.first` | Jump to first message |
| `session.last` | Jump to last message |

### Prompt Control

| Command | Description |
|---------|-------------|
| `prompt.submit` | Submit current TUI input |
| `prompt.clear` | Clear current TUI input |

### Agent Control

| Command | Description |
|---------|-------------|
| `agent.cycle` | Cycle through available agents |

---

## Recommended Default Mappings

**Source**: OpenCode.nvim README (recommended keymaps)

The plugin documentation suggests these mappings (currently **not active** in your config):

```lua
-- Recommended from plugin README
vim.keymap.set({ "n", "x" }, "<C-a>", function() 
  require("opencode").ask("@this: ", { submit = true }) 
end, { desc = "Ask opencode" })

vim.keymap.set({ "n", "x" }, "<C-x>", function() 
  require("opencode").select() 
end, { desc = "Execute opencode action…" })

vim.keymap.set({ "n", "x" }, "ga", function() 
  require("opencode").prompt("@this") 
end, { desc = "Add to opencode" })

vim.keymap.set({ "n", "t" }, "<C-.>", function() 
  require("opencode").toggle() 
end, { desc = "Toggle opencode" })

vim.keymap.set("n", "<S-C-u>", function() 
  require("opencode").command("session.half.page.up") 
end, { desc = "opencode half page up" })

vim.keymap.set("n", "<S-C-d>", function() 
  require("opencode").command("session.half.page.down") 
end, { desc = "opencode half page down" })

-- Restore native increment/decrement if using <C-a>/<C-x> for opencode
vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
```

**Conflicts with your config**:
- `<C-a>` and `<C-x>`: Standard Vim increment/decrement operations
- `<C-.>`: May conflict with terminal emulator key handling
- You're currently using `<C-CR>` instead for toggle (better choice!)

---

## Configuration Files

Reference locations for making changes:

### Plugin Configuration
**File**: `/home/benjamin/.config/nvim/lua/neotex/plugins/ai/opencode.lua`  
**Purpose**: Plugin setup, provider config, default options

Key sections:
- Line 20-49: `vim.g.opencode_opts` table (provider, contexts, events)
- Line 48: `keys = {}` (disables all default plugin keymaps)

### Global Keymaps
**File**: `/home/benjamin/.config/nvim/lua/neotex/config/keymaps.lua`  
**Purpose**: Non-prefixed global bindings

Key sections:
- Line 283: `<C-CR>` toggle mapping (normal + insert modes)
- Line 121-144: Terminal-specific OpenCode keybindings

### Which-Key Bindings
**File**: `/home/benjamin/.config/nvim/lua/neotex/plugins/editor/which-key.lua`  
**Purpose**: `<leader>a` prefixed AI command bindings

Key sections:
- Line 259-265: Active OpenCode which-key mappings
- Comments show disabled mappings available for activation

---

## Change Planning Worksheet

Use this section to document your desired changes:

### Mappings to Add

| Keymap | Mode | Function | Reason |
|--------|------|----------|--------|
| | | | |
| | | | |

### Mappings to Change

| Current | New | Reason |
|---------|-----|--------|
| | | |
| | | |

### Mappings to Remove

| Keymap | Reason |
|--------|--------|
| | |
| | |

### Context Placeholders to Add/Modify

| Placeholder | Context Function | Purpose |
|-------------|------------------|---------|
| | | |
| | | |

### Custom Prompts to Add

| Name | Prompt Text | Auto-submit | Purpose |
|------|-------------|-------------|---------|
| | | | |
| | | | |

---

## Notes

- All default plugin keymaps are disabled via `keys = {}` in opencode.lua:48
- Terminal navigation is OpenCode-aware: `<C-j>/<C-k>` send arrow keys only in OpenCode terminal
- The `<C-CR>` binding works in normal, insert, and terminal modes for toggle
- Which-key provides visual menu and descriptions for `<leader>a` commands
- Consider enabling commented-out mappings like `<leader>aa` (ask) and `<leader>ap` (prompt @this)

---

**Generated**: 2025-12-19  
**Plugin Version**: NickvanDyke/opencode.nvim (installed via lazy.nvim)  
**Config Location**: `~/.config/nvim/lua/neotex/`
