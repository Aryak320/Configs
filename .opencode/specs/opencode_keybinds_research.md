# OpenCode Keybindings Research

**Date**: 2025-12-19  
**Purpose**: Research OpenCode's native keybinding system for customization  
**Goal**: Configure consistent keybindings across OpenCode TUI and opencode.nvim plugin

---

## Table of Contents

1. [Configuration Overview](#configuration-overview)
2. [Default Keybindings](#default-keybindings)
3. [Leader Key Concept](#leader-key-concept)
4. [Configuration Locations](#configuration-locations)
5. [Keybind Categories](#keybind-categories)
6. [Customization Examples](#customization-examples)
7. [Integration with opencode.nvim](#integration-with-opencodenvim)
8. [Recommendation](#recommendation)

---

## Configuration Overview

OpenCode uses a **global JSON config file** to manage keybindings across all instances (terminal TUI and IDE plugins).

**Config File Location**: `~/.config/opencode/opencode.json`

**Schema**: `https://opencode.ai/config.json`

**Format**: JSON or JSONC (JSON with Comments)

**Status on Your System**: ❌ No `opencode.json` file found (only `package.json` exists)

---

## Default Keybindings

OpenCode comes with a comprehensive set of default keybindings. Here's the complete list:

### Application Control

| Keybind | Action | Description |
|---------|--------|-------------|
| `ctrl+c`, `ctrl+d`, `<leader>q` | `app_exit` | Exit OpenCode |
| `<leader>e` | `editor_open` | Open editor |
| `<leader>t` | `theme_list` | List themes |
| `<leader>b` | `sidebar_toggle` | Toggle sidebar |
| `<leader>s` | `status_view` | View status |
| `ctrl+z` | `terminal_suspend` | Suspend terminal |
| `none` | `username_toggle` | Toggle username (disabled) |

### Session Management

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>n` | `session_new` | Start new session |
| `<leader>l` | `session_list` | List sessions |
| `<leader>g` | `session_timeline` | View session timeline |
| `<leader>x` | `session_export` | Export session |
| `escape` | `session_interrupt` | Interrupt session |
| `<leader>c` | `session_compact` | Compact session |
| `<leader>+right` | `session_child_cycle` | Cycle child sessions forward |
| `<leader>+left` | `session_child_cycle_reverse` | Cycle child sessions backward |
| `none` | `session_share` | Share session (disabled) |
| `none` | `session_unshare` | Unshare session (disabled) |

### Message Navigation

| Keybind | Action | Description |
|---------|--------|-------------|
| `pageup` | `messages_page_up` | Scroll messages up one page |
| `pagedown` | `messages_page_down` | Scroll messages down one page |
| `ctrl+alt+u` | `messages_half_page_up` | Scroll up half page |
| `ctrl+alt+d` | `messages_half_page_down` | Scroll down half page |
| `ctrl+g`, `home` | `messages_first` | Jump to first message |
| `ctrl+alt+g`, `end` | `messages_last` | Jump to last message |
| `<leader>y` | `messages_copy` | Copy messages |
| `<leader>u` | `messages_undo` | Undo last action |
| `<leader>r` | `messages_redo` | Redo action |
| `<leader>h` | `messages_toggle_conceal` | Toggle conceal |
| `none` | `messages_last_user` | Jump to last user message (disabled) |

### Model/Agent Selection

| Keybind | Action | Description |
|---------|--------|-------------|
| `<leader>m` | `model_list` | List available models |
| `f2` | `model_cycle_recent` | Cycle recent models forward |
| `shift+f2` | `model_cycle_recent_reverse` | Cycle recent models backward |
| `<leader>a` | `agent_list` | List agents |
| `tab` | `agent_cycle` | Cycle agents forward |
| `shift+tab` | `agent_cycle_reverse` | Cycle agents backward |

### Commands

| Keybind | Action | Description |
|---------|--------|-------------|
| `ctrl+p` | `command_list` | List commands |

### Input Control

| Keybind | Action | Description |
|---------|--------|-------------|
| `ctrl+c` | `input_clear` | Clear input |
| `ctrl+v` | `input_paste` | Paste into input |
| `return` | `input_submit` | Submit input |
| `shift+return`, `ctrl+return`, `alt+return`, `ctrl+j` | `input_newline` | Insert newline |

### Cursor Movement

| Keybind | Action | Description |
|---------|--------|-------------|
| `left`, `ctrl+b` | `input_move_left` | Move cursor left |
| `right`, `ctrl+f` | `input_move_right` | Move cursor right |
| `up` | `input_move_up` | Move cursor up |
| `down` | `input_move_down` | Move cursor down |
| `ctrl+a` | `input_line_home` | Jump to line start |
| `ctrl+e` | `input_line_end` | Jump to line end |
| `alt+a` | `input_visual_line_home` | Jump to visual line start |
| `alt+e` | `input_visual_line_end` | Jump to visual line end |
| `home` | `input_buffer_home` | Jump to buffer start |
| `end` | `input_buffer_end` | Jump to buffer end |

### Selection

| Keybind | Action | Description |
|---------|--------|-------------|
| `shift+left` | `input_select_left` | Select left |
| `shift+right` | `input_select_right` | Select right |
| `shift+up` | `input_select_up` | Select up |
| `shift+down` | `input_select_down` | Select down |
| `ctrl+shift+a` | `input_select_line_home` | Select to line start |
| `ctrl+shift+e` | `input_select_line_end` | Select to line end |
| `alt+shift+a` | `input_select_visual_line_home` | Select to visual line start |
| `alt+shift+e` | `input_select_visual_line_end` | Select to visual line end |
| `shift+home` | `input_select_buffer_home` | Select to buffer start |
| `shift+end` | `input_select_buffer_end` | Select to buffer end |

### Deletion

| Keybind | Action | Description |
|---------|--------|-------------|
| `backspace`, `shift+backspace` | `input_backspace` | Delete character before cursor |
| `ctrl+d`, `delete`, `shift+delete` | `input_delete` | Delete character at cursor |
| `ctrl+shift+d` | `input_delete_line` | Delete entire line |
| `ctrl+k` | `input_delete_to_line_end` | Delete to line end |
| `ctrl+u` | `input_delete_to_line_start` | Delete to line start |

### Word Movement

| Keybind | Action | Description |
|---------|--------|-------------|
| `alt+f`, `alt+right`, `ctrl+right` | `input_word_forward` | Move forward one word |
| `alt+b`, `alt+left`, `ctrl+left` | `input_word_backward` | Move backward one word |
| `alt+shift+f`, `alt+shift+right` | `input_select_word_forward` | Select forward one word |
| `alt+shift+b`, `alt+shift+left` | `input_select_word_backward` | Select backward one word |
| `alt+d`, `alt+delete`, `ctrl+delete` | `input_delete_word_forward` | Delete word forward |
| `ctrl+w`, `ctrl+backspace`, `alt+backspace` | `input_delete_word_backward` | Delete word backward |

### Edit History

| Keybind | Action | Description |
|---------|--------|-------------|
| `ctrl+-`, `super+z` | `input_undo` | Undo |
| `ctrl+.`, `super+shift+z` | `input_redo` | Redo |

### History Navigation

| Keybind | Action | Description |
|---------|--------|-------------|
| `up` | `history_previous` | Previous history item |
| `down` | `history_next` | Next history item |

---

## Leader Key Concept

**Default Leader**: `ctrl+x`

OpenCode uses a **leader key pattern** (borrowed from Vim) to avoid keybinding conflicts with the terminal. Most actions require:

1. Press the leader key first (e.g., `ctrl+x`)
2. Release it
3. Press the action key (e.g., `n` for new session)

### Example

To start a new session:
1. Press `ctrl+x`
2. Release
3. Press `n`

This is represented as: `<leader>n`

### Why Use a Leader?

- **Avoids conflicts**: Terminal emulators already use many `ctrl+` combinations
- **Muscle memory**: Familiar pattern from Vim
- **Customizable**: You can change the leader to any key combination
- **Optional**: You can configure direct keybindings without a leader

---

## Configuration Locations

OpenCode supports **multiple config locations** with a **merge strategy**:

### 1. Global Config (Recommended for Keybindings)

**Path**: `~/.config/opencode/opencode.json`

**Use for**: Themes, keybinds, providers (settings that apply everywhere)

**Example**:
```json
{
  "$schema": "https://opencode.ai/config.json",
  "keybinds": {
    "leader": "ctrl+x",
    "session_new": "<leader>n"
  }
}
```

### 2. Project Config

**Path**: `./opencode.json` (in project root or nearest Git directory)

**Use for**: Project-specific settings (models, agents, tools)

**Merge behavior**: Overrides global config for conflicting keys only

### 3. Custom Path

**Environment Variable**: `OPENCODE_CONFIG`

**Example**:
```bash
export OPENCODE_CONFIG=/path/to/custom-config.json
opencode run "Hello world"
```

### 4. Custom Directory

**Environment Variable**: `OPENCODE_CONFIG_DIR`

**Use for**: Alternative config directory with agents, commands, modes, plugins

---

## Keybind Categories

### 1. **Application-Level**
   - Exit, theme, sidebar, status
   - Recommended location: **Global config**

### 2. **Session Management**
   - New session, list, export, compact
   - Recommended location: **Global config**

### 3. **Navigation**
   - Page up/down, half-page scrolling
   - **KEY FINDING**: This is where `ctrl+x+right` bindings would go
   - Recommended location: **Global config**

### 4. **Input Editing**
   - Cursor movement, selection, deletion
   - Recommended location: **Global config**

### 5. **Model/Agent Selection**
   - Switch models, cycle agents
   - Recommended location: **Global config** or **Project config** (if project-specific models)

---

## Customization Examples

### Example 1: Change Leader Key

```json
{
  "$schema": "https://opencode.ai/config.json",
  "keybinds": {
    "leader": "ctrl+space"
  }
}
```

Now `<leader>n` becomes `ctrl+space` then `n`.

### Example 2: Disable a Keybind

```json
{
  "$schema": "https://opencode.ai/config.json",
  "keybinds": {
    "session_compact": "none"
  }
}
```

### Example 3: Add Multiple Keys to One Action

```json
{
  "$schema": "https://opencode.ai/config.json",
  "keybinds": {
    "session_new": "ctrl+n,<leader>n,f1"
  }
}
```

### Example 4: Custom Navigation Bindings

If you want to customize the `ctrl+x+right` style bindings:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "keybinds": {
    "leader": "ctrl+x",
    "session_child_cycle": "<leader>+right,ctrl+shift+right",
    "session_child_cycle_reverse": "<leader>+left,ctrl+shift+left",
    "messages_page_down": "pagedown,<leader>+down",
    "messages_page_up": "pageup,<leader>+up"
  }
}
```

---

## Integration with opencode.nvim

The **opencode.nvim plugin** integrates with OpenCode's TUI and **respects the OpenCode config file**. This means:

### What opencode.nvim Controls

1. **Neovim-specific bindings**:
   - Toggle OpenCode terminal window (`<C-CR>` in your config)
   - Send context to OpenCode (`<leader>ab`, `<leader>ad`, etc.)
   - Open action picker (`<leader>as`)
   - Session history (`<leader>ah`)

2. **Terminal-specific navigation** (when inside OpenCode terminal):
   - `<C-j>/<C-k>` send arrow keys for menu navigation
   - Window navigation (`<C-h>/<C-l>`)
   - Terminal resizing (`<M-h>/<M-l>`)

### What OpenCode Config Controls

1. **Inside OpenCode TUI** (all the keybindings from the defaults above):
   - Session management (`ctrl+x n`, `ctrl+x l`, etc.)
   - Message navigation (`pageup`, `ctrl+alt+u`, etc.)
   - **Child session cycling** (`ctrl+x right`, `ctrl+x left`)
   - Input editing (cursor movement, deletion, etc.)
   - Model/agent selection

### The Relationship

```
┌─────────────────────────────────────────────────────┐
│ Neovim (opencode.nvim)                              │
│                                                     │
│  ┌──────────────────────────────────────────────┐  │
│  │ Neovim Keybindings                           │  │
│  │  - <C-CR>: Toggle OpenCode terminal         │  │
│  │  - <leader>ab: Send buffer context          │  │
│  │  - <leader>as: Open picker                  │  │
│  └──────────────────────────────────────────────┘  │
│                                                     │
│  ┌──────────────────────────────────────────────┐  │
│  │ OpenCode Terminal (TUI)                      │  │
│  │                                              │  │
│  │  Uses: ~/.config/opencode/opencode.json     │  │
│  │                                              │  │
│  │  OpenCode Keybindings:                       │  │
│  │   - ctrl+x n: New session                   │  │
│  │   - ctrl+x right: Cycle child sessions      │  │
│  │   - pageup/down: Navigate messages          │  │
│  │   - tab: Cycle agents                       │  │
│  └──────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────┐
│ Terminal (outside Neovim)                           │
│                                                     │
│  OpenCode TUI                                       │
│                                                     │
│  Uses: ~/.config/opencode/opencode.json            │
│                                                     │
│  Same keybindings as inside Neovim                  │
└─────────────────────────────────────────────────────┘
```

**Key Insight**: By configuring `~/.config/opencode/opencode.json`, you get **consistent keybindings** in:
- OpenCode TUI running standalone in terminal
- OpenCode TUI running inside Neovim terminal window (via opencode.nvim)

---

## Recommendation

### For Consistent Keybindings Across All Environments

**Create**: `~/.config/opencode/opencode.json`

**Why**:
1. ✅ Works in OpenCode TUI (standalone terminal)
2. ✅ Works in OpenCode TUI (inside Neovim via opencode.nvim)
3. ✅ Single source of truth
4. ✅ No duplication of configuration
5. ✅ Schema validation and autocomplete in editors

**What NOT to do**:
- ❌ Don't try to configure OpenCode's internal keybindings (like `ctrl+x right`) in opencode.nvim
- ❌ opencode.nvim doesn't control OpenCode's TUI keybindings
- ❌ opencode.nvim only controls Neovim-to-OpenCode integration (toggle, context sending)

### Suggested Configuration

**File**: `~/.config/opencode/opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  
  "keybinds": {
    "leader": "ctrl+x",
    
    // Session management
    "session_new": "<leader>n",
    "session_list": "<leader>l",
    "session_timeline": "<leader>g",
    "session_interrupt": "escape",
    "session_compact": "<leader>c",
    
    // Child session navigation (ctrl+x right/left pattern)
    "session_child_cycle": "<leader>+right",
    "session_child_cycle_reverse": "<leader>+left",
    
    // Message navigation
    "messages_page_up": "pageup",
    "messages_page_down": "pagedown",
    "messages_half_page_up": "ctrl+alt+u",
    "messages_half_page_down": "ctrl+alt+d",
    "messages_first": "ctrl+g,home",
    "messages_last": "ctrl+alt+g,end",
    
    // Actions
    "messages_copy": "<leader>y",
    "messages_undo": "<leader>u",
    "messages_redo": "<leader>r",
    
    // UI
    "sidebar_toggle": "<leader>b",
    "theme_list": "<leader>t",
    "status_view": "<leader>s",
    
    // Models and Agents
    "model_list": "<leader>m",
    "agent_list": "<leader>a",
    "agent_cycle": "tab",
    "agent_cycle_reverse": "shift+tab",
    
    // Commands
    "command_list": "ctrl+p",
    
    // Input
    "input_submit": "return",
    "input_newline": "shift+return,ctrl+return,alt+return,ctrl+j",
    "input_clear": "ctrl+c"
  },
  
  // Optional: Other settings
  "autoupdate": true,
  "theme": "opencode"
}
```

### Leave opencode.nvim Config As-Is

Your existing opencode.nvim configuration is **perfect** for Neovim integration:

**File**: `~/.config/nvim/lua/neotex/plugins/ai/opencode.lua`

```lua
-- Plugin configuration (keep as-is)
vim.g.opencode_opts = {
  provider = {
    enabled = "snacks",
    snacks = {
      auto_close = false,
      win = {
        position = "right",
        width = 0.40,
        enter = true,
      },
    },
  },
  reload_on_edit = true,
  permission_requests = "notify",
  include_diagnostics = true,
  include_buffer = true,
  include_visible = true,
  
  -- Disable default plugin keymaps (prevents conflicts)
  keys = {},
}
```

**File**: `~/.config/nvim/lua/neotex/config/keymaps.lua`

Keep your existing Neovim-specific bindings:
- `<C-CR>`: Toggle OpenCode terminal
- Terminal-specific navigation (`<C-j>/<C-k>` for menu navigation)

**File**: `~/.config/nvim/lua/neotex/plugins/editor/which-key.lua`

Keep your existing context-sending bindings:
- `<leader>ab`: Send buffer context
- `<leader>ad`: Send diagnostics
- `<leader>as`: Open action selector
- `<leader>ah`: Session history

---

## Next Steps

1. **Create the config file**:
   ```bash
   touch ~/.config/opencode/opencode.json
   ```

2. **Add your desired keybindings** to `opencode.json` (use the suggested configuration above as a starting point)

3. **Test in both environments**:
   - Run `opencode` in standalone terminal → keybindings work
   - Open OpenCode in Neovim (`<C-CR>`) → same keybindings work

4. **Iterate**: Adjust keybindings in one place (`opencode.json`) and they apply everywhere

---

## Special Notes

### Shift+Enter on Some Terminals

Some terminals (like Windows Terminal) don't send `Shift+Enter` by default. You may need to configure your terminal emulator to send escape sequences. See the [OpenCode docs](https://opencode.ai/docs/keybinds/#shiftenter) for terminal-specific setup.

### Terminal Conflicts

If you experience keybinding conflicts with your terminal emulator or shell:
1. Use the leader key pattern (`ctrl+x` + key)
2. Avoid single-key shortcuts for critical actions
3. Check terminal emulator settings for reserved keybindings

### Testing Your Config

After creating `opencode.json`:

```bash
# Validate your config (uses schema)
cat ~/.config/opencode/opencode.json

# Test in standalone terminal
opencode

# Test in Neovim
nvim
# Then press <C-CR> to toggle OpenCode
```

---

**Generated**: 2025-12-19  
**Source**: [OpenCode Keybinds Documentation](https://opencode.ai/docs/keybinds/)  
**Config Schema**: [https://opencode.ai/config.json](https://opencode.ai/config.json)
