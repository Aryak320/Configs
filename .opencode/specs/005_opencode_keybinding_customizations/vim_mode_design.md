# Vim-Mode Design for OpenCode

**Date**: 2025-12-20  
**Purpose**: Design vim-like keybindings for OpenCode input editing  
**Research Source**: `/home/benjamin/.config/.opencode/specs/opencode_keybinds_research.md`  
**Standards**: `/home/benjamin/.config/CLAUDE.md`

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Feasibility Analysis](#feasibility-analysis)
3. [Available Input Actions](#available-input-actions)
4. [Vim Command Mappings](#vim-command-mappings)
5. [Mode Switching Strategy](#mode-switching-strategy)
6. [Implementation Approach](#implementation-approach)
7. [Limitations and Workarounds](#limitations-and-workarounds)
8. [Keybinding Conflicts](#keybinding-conflicts)
9. [Recommended Configuration](#recommended-configuration)
10. [Testing Strategy](#testing-strategy)

---

## Executive Summary

**Feasibility**: ⚠️ **Partial** - OpenCode supports vim-like navigation but lacks true modal editing

**Key Findings**:
- ✅ OpenCode provides comprehensive cursor movement actions (left/right/up/down, word movement, line navigation)
- ✅ Selection operations available (shift+movement for visual-like selection)
- ✅ Deletion operations supported (character, word, line deletion)
- ❌ **No native mode system** (Normal/Insert/Visual modes)
- ❌ **No command composition** (e.g., `d3w` for "delete 3 words")
- ❌ **No text objects** (e.g., `diw` for "delete inner word")
- ⚠️ **Limited vim emulation** - Can map individual vim keys but not vim's modal philosophy

**Recommendation**: Implement **vim-inspired keybindings** rather than full vim-mode emulation. Focus on:
1. Single-key navigation (h/j/k/l) using leader key pattern
2. Vim-style word movement (w/b/e)
3. Vim-style deletion shortcuts (x for delete char, dd for delete line)
4. Emacs-style bindings as fallback (already present: ctrl+a/e/k/u)

---

## Feasibility Analysis

### What OpenCode Provides

OpenCode's input system offers **action-based keybindings** rather than modal editing:

| Category | Available Actions | Vim Equivalent |
|----------|-------------------|----------------|
| **Cursor Movement** | `input_move_left/right/up/down` | h/j/k/l |
| **Word Movement** | `input_word_forward/backward` | w/b |
| **Line Navigation** | `input_line_home/end` | 0/$ |
| **Buffer Navigation** | `input_buffer_home/end` | gg/G |
| **Selection** | `input_select_*` (all movement actions) | v + movement |
| **Deletion** | `input_delete`, `input_backspace`, `input_delete_word_*`, `input_delete_line` | x/X/dw/dd |
| **Undo/Redo** | `input_undo/redo` | u/ctrl+r |

### What OpenCode Does NOT Provide

| Missing Feature | Impact | Workaround |
|----------------|--------|------------|
| **Modal editing** (Normal/Insert/Visual) | Cannot have context-dependent keybindings | Use leader key + vim key (e.g., `<leader>h` instead of `h`) |
| **Command composition** (`d3w`, `c2j`) | Cannot combine operators with counts | Map individual actions only |
| **Text objects** (`iw`, `ap`, `i"`) | Cannot operate on semantic units | Use word/line deletion only |
| **Registers** (`"ayy`, `"ap`) | Cannot use named clipboards | Use system clipboard only |
| **Macros** (`qa...q`, `@a`) | Cannot record/replay commands | Not possible |
| **Ex commands** (`:w`, `:q`) | Cannot use command-line mode | Use OpenCode's native commands |

### Conclusion

OpenCode supports **vim-inspired navigation** but not **vim modal editing**. The best approach is to map vim-style keys to OpenCode's input actions using the leader key pattern.

---

## Available Input Actions

### Cursor Movement Actions

| Action | Default Keybind | Description |
|--------|----------------|-------------|
| `input_move_left` | `left`, `ctrl+b` | Move cursor left one character |
| `input_move_right` | `right`, `ctrl+f` | Move cursor right one character |
| `input_move_up` | `up` | Move cursor up one line |
| `input_move_down` | `down` | Move cursor down one line |

### Word Movement Actions

| Action | Default Keybind | Description |
|--------|----------------|-------------|
| `input_word_forward` | `alt+f`, `alt+right`, `ctrl+right` | Move forward one word |
| `input_word_backward` | `alt+b`, `alt+left`, `ctrl+left` | Move backward one word |

### Line Navigation Actions

| Action | Default Keybind | Description |
|--------|----------------|-------------|
| `input_line_home` | `ctrl+a` | Jump to line start |
| `input_line_end` | `ctrl+e` | Jump to line end |
| `input_visual_line_home` | `alt+a` | Jump to visual line start |
| `input_visual_line_end` | `alt+e` | Jump to visual line end |

### Buffer Navigation Actions

| Action | Default Keybind | Description |
|--------|----------------|-------------|
| `input_buffer_home` | `home` | Jump to buffer start |
| `input_buffer_end` | `end` | Jump to buffer end |

### Selection Actions

| Action | Default Keybind | Description |
|--------|----------------|-------------|
| `input_select_left` | `shift+left` | Select left one character |
| `input_select_right` | `shift+right` | Select right one character |
| `input_select_up` | `shift+up` | Select up one line |
| `input_select_down` | `shift+down` | Select down one line |
| `input_select_word_forward` | `alt+shift+f`, `alt+shift+right` | Select forward one word |
| `input_select_word_backward` | `alt+shift+b`, `alt+shift+left` | Select backward one word |
| `input_select_line_home` | `ctrl+shift+a` | Select to line start |
| `input_select_line_end` | `ctrl+shift+e` | Select to line end |
| `input_select_buffer_home` | `shift+home` | Select to buffer start |
| `input_select_buffer_end` | `shift+end` | Select to buffer end |

### Deletion Actions

| Action | Default Keybind | Description |
|--------|----------------|-------------|
| `input_backspace` | `backspace`, `shift+backspace` | Delete character before cursor |
| `input_delete` | `ctrl+d`, `delete`, `shift+delete` | Delete character at cursor |
| `input_delete_line` | `ctrl+shift+d` | Delete entire line |
| `input_delete_to_line_end` | `ctrl+k` | Delete to line end |
| `input_delete_to_line_start` | `ctrl+u` | Delete to line start |
| `input_delete_word_forward` | `alt+d`, `alt+delete`, `ctrl+delete` | Delete word forward |
| `input_delete_word_backward` | `ctrl+w`, `ctrl+backspace`, `alt+backspace` | Delete word backward |

### Edit History Actions

| Action | Default Keybind | Description |
|--------|----------------|-------------|
| `input_undo` | `ctrl+-`, `super+z` | Undo last edit |
| `input_redo` | `ctrl+.`, `super+shift+z` | Redo last undone edit |

### Input Control Actions

| Action | Default Keybind | Description |
|--------|----------------|-------------|
| `input_clear` | `ctrl+c` | Clear entire input buffer |
| `input_paste` | `ctrl+v` | Paste from clipboard |
| `input_submit` | `return` | Submit input |
| `input_newline` | `shift+return`, `ctrl+return`, `alt+return`, `ctrl+j` | Insert newline |

---

## Vim Command Mappings

### Strategy: Leader-Based Vim Navigation

Since OpenCode doesn't support modal editing, we'll use the **leader key pattern** to create vim-like navigation:

- **Leader key**: `ctrl+x` (default) or customizable
- **Vim navigation**: `<leader>h/j/k/l` for cursor movement
- **Vim word movement**: `<leader>w/b/e` for word navigation
- **Vim deletion**: `<leader>x` for delete char, `<leader>d` for delete operations

### Core Navigation Mappings

| Vim Command | OpenCode Action | Proposed Keybind | Description |
|-------------|----------------|------------------|-------------|
| `h` | `input_move_left` | `<leader>h` | Move left |
| `j` | `input_move_down` | `<leader>j` | Move down |
| `k` | `input_move_up` | `<leader>k` | Move up |
| `l` | `input_move_right` | `<leader>l` | Move right |
| `0` | `input_line_home` | `<leader>0` | Jump to line start |
| `$` | `input_line_end` | `<leader>4` (shift+4) | Jump to line end |
| `gg` | `input_buffer_home` | `<leader>g` | Jump to buffer start |
| `G` | `input_buffer_end` | `<leader>shift+g` | Jump to buffer end |

**Note**: `<leader>4` represents `ctrl+x` then `shift+4` (which produces `$` on US keyboards).

### Word Movement Mappings

| Vim Command | OpenCode Action | Proposed Keybind | Description |
|-------------|----------------|------------------|-------------|
| `w` | `input_word_forward` | `<leader>w` | Move forward one word |
| `b` | `input_word_backward` | `<leader>b` | Move backward one word |
| `e` | `input_word_forward` | `<leader>e` | Move to end of word (approximation) |

**Limitation**: OpenCode doesn't distinguish between `w` (start of next word) and `e` (end of current word). Both map to `input_word_forward`.

### Deletion Mappings

| Vim Command | OpenCode Action | Proposed Keybind | Description |
|-------------|----------------|------------------|-------------|
| `x` | `input_delete` | `<leader>x` | Delete character at cursor |
| `X` | `input_backspace` | `<leader>shift+x` | Delete character before cursor |
| `dw` | `input_delete_word_forward` | `<leader>dw` | Delete word forward |
| `db` | `input_delete_word_backward` | `<leader>db` | Delete word backward |
| `dd` | `input_delete_line` | `<leader>dd` | Delete entire line |
| `D` | `input_delete_to_line_end` | `<leader>shift+d` | Delete to line end |
| `d0` | `input_delete_to_line_start` | `<leader>d0` | Delete to line start |

**Limitation**: OpenCode doesn't support multi-key sequences like `dw` or `dd`. We'll need to map these as single actions.

### Visual Mode Approximation

| Vim Command | OpenCode Action | Proposed Keybind | Description |
|-------------|----------------|------------------|-------------|
| `v` + `h` | `input_select_left` | `<leader>vh` | Select left |
| `v` + `j` | `input_select_down` | `<leader>vj` | Select down |
| `v` + `k` | `input_select_up` | `<leader>vk` | Select up |
| `v` + `l` | `input_select_right` | `<leader>vl` | Select right |
| `v` + `w` | `input_select_word_forward` | `<leader>vw` | Select word forward |
| `v` + `b` | `input_select_word_backward` | `<leader>vb` | Select word backward |

**Limitation**: OpenCode doesn't support visual mode. Selection must be done with shift+movement keys or leader+v+movement.

### Undo/Redo Mappings

| Vim Command | OpenCode Action | Proposed Keybind | Description |
|-------------|----------------|------------------|-------------|
| `u` | `input_undo` | `<leader>u` | Undo |
| `ctrl+r` | `input_redo` | `<leader>r` | Redo |

**Conflict**: `<leader>u` is already mapped to `messages_undo` (different from `input_undo`). We'll need to resolve this conflict.

---

## Mode Switching Strategy

### Problem: No Native Mode System

OpenCode does not have a concept of Normal/Insert/Visual modes. All keybindings are active simultaneously.

### Solution: Leader-Based "Pseudo-Modes"

Instead of true modal editing, we'll use **leader key prefixes** to simulate modes:

| Pseudo-Mode | Leader Pattern | Example |
|-------------|---------------|---------|
| **Normal Mode** | `<leader>` + vim key | `<leader>h` = move left |
| **Visual Mode** | `<leader>v` + vim key | `<leader>vl` = select right |
| **Delete Mode** | `<leader>d` + vim key | `<leader>dw` = delete word |

### Workflow Example

**Traditional Vim**:
1. Press `Esc` to enter Normal mode
2. Press `3w` to move forward 3 words
3. Press `dw` to delete word
4. Press `i` to enter Insert mode

**OpenCode Vim-Inspired**:
1. Type normally (always in "insert mode")
2. Press `<leader>w` three times to move forward 3 words
3. Press `<leader>dw` to delete word
4. Continue typing (no mode switch needed)

### Trade-offs

| Aspect | Traditional Vim | OpenCode Vim-Inspired |
|--------|----------------|----------------------|
| **Efficiency** | High (single keypress for navigation) | Medium (leader + key) |
| **Learning Curve** | Steep (modal editing) | Gentle (no mode switching) |
| **Muscle Memory** | Vim users need adjustment | Easier for non-Vim users |
| **Conflicts** | Minimal (modes separate contexts) | Higher (all keys active) |

---

## Implementation Approach

### Phase 1: Core Navigation (Minimal Viable Vim)

**Goal**: Provide basic vim-like navigation without breaking existing workflows.

**Keybindings**:
```json
{
  "keybinds": {
    "leader": "ctrl+x",
    
    // Core navigation (h/j/k/l)
    "input_move_left": "left,ctrl+b,<leader>h",
    "input_move_down": "down,<leader>j",
    "input_move_up": "up,<leader>k",
    "input_move_right": "right,ctrl+f,<leader>l",
    
    // Line navigation (0/$)
    "input_line_home": "ctrl+a,<leader>0",
    "input_line_end": "ctrl+e,<leader>4",
    
    // Buffer navigation (gg/G)
    "input_buffer_home": "home,<leader>g",
    "input_buffer_end": "end,<leader>shift+g"
  }
}
```

**Testing**:
- Verify `<leader>h/j/k/l` moves cursor correctly
- Verify existing keybindings still work (arrow keys, ctrl+a/e)
- Test in both standalone terminal and Neovim integration

### Phase 2: Word Movement (w/b/e)

**Goal**: Add vim-style word navigation.

**Conflict Resolution**: `<leader>b` is already mapped to `sidebar_toggle`. We'll need to choose:
- **Option A**: Use different key for sidebar (e.g., `<leader>s` for sidebar)
- **Option B**: Use different key for word backward (e.g., `<leader>shift+b`)
- **Option C**: Keep both (sidebar toggle requires exact `<leader>b`, word backward uses `alt+b`)

**Recommended**: Option A (remap sidebar to `<leader>s`, use `<leader>b` for word backward)

**Keybindings**:
```json
{
  "keybinds": {
    // Word movement (w/b/e)
    "input_word_forward": "alt+f,alt+right,ctrl+right,<leader>w,<leader>e",
    "input_word_backward": "alt+b,alt+left,ctrl+left,<leader>b",
    
    // Remap sidebar to avoid conflict
    "sidebar_toggle": "<leader>s"
  }
}
```

### Phase 3: Deletion Operations (x/d)

**Goal**: Add vim-style deletion shortcuts.

**Conflict Resolution**: `<leader>x` is already mapped to `session_export`. We'll remap session export.

**Keybindings**:
```json
{
  "keybinds": {
    // Character deletion (x/X)
    "input_delete": "ctrl+d,delete,shift+delete,<leader>x",
    "input_backspace": "backspace,shift+backspace,<leader>shift+x",
    
    // Word deletion (dw/db)
    "input_delete_word_forward": "alt+d,alt+delete,ctrl+delete,<leader>dw",
    "input_delete_word_backward": "ctrl+w,ctrl+backspace,alt+backspace,<leader>db",
    
    // Line deletion (dd/D/d0)
    "input_delete_line": "ctrl+shift+d,<leader>dd",
    "input_delete_to_line_end": "ctrl+k,<leader>shift+d",
    "input_delete_to_line_start": "ctrl+u,<leader>d0",
    
    // Remap session export to avoid conflict
    "session_export": "<leader>shift+x"
  }
}
```

**Limitation**: Multi-key sequences like `dw` and `dd` are not supported. OpenCode will interpret these as:
- `<leader>d` followed by `w` (two separate actions)
- We need to map `<leader>dw` as a single keybind string

**Workaround**: Use comma-separated alternatives:
```json
{
  "input_delete_word_forward": "<leader>dw,alt+d"
}
```

### Phase 4: Visual Mode Approximation (v)

**Goal**: Provide selection operations similar to vim's visual mode.

**Keybindings**:
```json
{
  "keybinds": {
    // Visual mode approximation (v + movement)
    "input_select_left": "shift+left,<leader>vh",
    "input_select_down": "shift+down,<leader>vj",
    "input_select_up": "shift+up,<leader>vk",
    "input_select_right": "shift+right,<leader>vl",
    
    // Visual word selection (vw/vb)
    "input_select_word_forward": "alt+shift+f,alt+shift+right,<leader>vw",
    "input_select_word_backward": "alt+shift+b,alt+shift+left,<leader>vb",
    
    // Visual line selection (v0/v$)
    "input_select_line_home": "ctrl+shift+a,<leader>v0",
    "input_select_line_end": "ctrl+shift+e,<leader>v4"
  }
}
```

### Phase 5: Undo/Redo (u/ctrl+r)

**Goal**: Add vim-style undo/redo.

**Conflict Resolution**: `<leader>u` is mapped to `messages_undo`, `<leader>r` is mapped to `messages_redo`. These are different from `input_undo`/`input_redo`.

**Decision**: Keep both sets of undo/redo:
- `<leader>u` / `<leader>r` for message-level undo/redo
- `<leader>iu` / `<leader>ir` for input-level undo/redo (vim-style)

**Keybindings**:
```json
{
  "keybinds": {
    // Input undo/redo (vim-style)
    "input_undo": "ctrl+-,super+z,<leader>iu",
    "input_redo": "ctrl+.,super+shift+z,<leader>ir",
    
    // Message undo/redo (keep existing)
    "messages_undo": "<leader>u",
    "messages_redo": "<leader>r"
  }
}
```

---

## Limitations and Workarounds

### Limitation 1: No Modal Editing

**Impact**: Cannot have context-dependent keybindings (e.g., `h` moves left in Normal mode, types 'h' in Insert mode).

**Workaround**: Use leader key pattern (`<leader>h` instead of `h`).

**Trade-off**: Requires two keypresses instead of one, but avoids conflicts with typing.

### Limitation 2: No Command Composition

**Impact**: Cannot combine operators with counts (e.g., `d3w` for "delete 3 words").

**Workaround**: Repeat commands manually (press `<leader>dw` three times).

**Trade-off**: Less efficient than vim, but still functional.

### Limitation 3: No Text Objects

**Impact**: Cannot operate on semantic units (e.g., `diw` for "delete inner word", `ci"` for "change inside quotes").

**Workaround**: Use word/line deletion only. For more complex edits, use external editor (`<leader>e` to open editor).

**Trade-off**: Limited editing capabilities compared to vim.

### Limitation 4: Multi-Key Sequences Not Supported

**Impact**: OpenCode doesn't support sequences like `dd` (press `d` twice) or `dw` (press `d` then `w`).

**Workaround**: Map multi-key sequences as single keybind strings (e.g., `<leader>dd` as one binding).

**Trade-off**: Requires exact key sequence, cannot compose dynamically.

### Limitation 5: No Registers

**Impact**: Cannot use named clipboards (e.g., `"ayy` to yank to register 'a').

**Workaround**: Use system clipboard only (`ctrl+v` to paste).

**Trade-off**: Limited clipboard management.

### Limitation 6: No Macros

**Impact**: Cannot record and replay command sequences.

**Workaround**: Use shell scripts or OpenCode commands for repetitive tasks.

**Trade-off**: Less automation than vim.

### Limitation 7: No Ex Commands

**Impact**: Cannot use command-line mode (`:w`, `:q`, `:s/foo/bar/`).

**Workaround**: Use OpenCode's native commands (`ctrl+p` for command list).

**Trade-off**: Different workflow than vim.

---

## Keybinding Conflicts

### Conflict Analysis

| Proposed Vim Keybind | Existing OpenCode Action | Resolution |
|---------------------|-------------------------|------------|
| `<leader>b` | `sidebar_toggle` | Remap sidebar to `<leader>s` |
| `<leader>x` | `session_export` | Remap export to `<leader>shift+x` |
| `<leader>u` | `messages_undo` | Keep both: `<leader>u` for messages, `<leader>iu` for input |
| `<leader>r` | `messages_redo` | Keep both: `<leader>r` for messages, `<leader>ir` for input |
| `<leader>e` | `editor_open` | Keep existing (vim `e` is for word-end, use `<leader>w` instead) |
| `<leader>g` | `session_timeline` | Remap timeline to `<leader>t`, use `<leader>g` for buffer home |
| `<leader>t` | `theme_list` | Remap theme to `<leader>shift+t` |

### Conflict Resolution Strategy

**Priority Order**:
1. **High Priority**: Core vim navigation (h/j/k/l, w/b, x/d)
2. **Medium Priority**: Session management (n/l/c)
3. **Low Priority**: UI toggles (sidebar, theme, status)

**Resolution Rules**:
1. Remap low-priority actions to shifted versions (e.g., `<leader>shift+t` for theme)
2. Use alternative keys for medium-priority actions (e.g., `<leader>s` for sidebar instead of `<leader>b`)
3. Preserve high-priority vim keybindings

### Recommended Remappings

```json
{
  "keybinds": {
    // Vim navigation (high priority)
    "input_move_left": "left,ctrl+b,<leader>h",
    "input_move_down": "down,<leader>j",
    "input_move_up": "up,<leader>k",
    "input_move_right": "right,ctrl+f,<leader>l",
    "input_word_forward": "alt+f,alt+right,ctrl+right,<leader>w",
    "input_word_backward": "alt+b,alt+left,ctrl+left,<leader>b",
    "input_delete": "ctrl+d,delete,shift+delete,<leader>x",
    "input_buffer_home": "home,<leader>g",
    
    // Session management (medium priority, remapped)
    "session_new": "<leader>n",
    "session_list": "<leader>l",
    "session_compact": "<leader>c",
    "session_export": "<leader>shift+x",
    "session_timeline": "<leader>shift+g",
    
    // UI toggles (low priority, remapped)
    "sidebar_toggle": "<leader>s",
    "theme_list": "<leader>shift+t",
    "status_view": "<leader>shift+s",
    "editor_open": "<leader>e"
  }
}
```

---

## Recommended Configuration

### Full Vim-Inspired Configuration

**File**: `~/.config/opencode/opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  
  "keybinds": {
    "leader": "ctrl+x",
    
    // ============================================
    // VIM-INSPIRED NAVIGATION
    // ============================================
    
    // Core navigation (h/j/k/l)
    "input_move_left": "left,ctrl+b,<leader>h",
    "input_move_down": "down,<leader>j",
    "input_move_up": "up,<leader>k",
    "input_move_right": "right,ctrl+f,<leader>l",
    
    // Line navigation (0/$)
    "input_line_home": "ctrl+a,<leader>0",
    "input_line_end": "ctrl+e,<leader>4",
    "input_visual_line_home": "alt+a",
    "input_visual_line_end": "alt+e",
    
    // Buffer navigation (gg/G)
    "input_buffer_home": "home,<leader>g",
    "input_buffer_end": "end,<leader>shift+g",
    
    // Word movement (w/b/e)
    "input_word_forward": "alt+f,alt+right,ctrl+right,<leader>w,<leader>e",
    "input_word_backward": "alt+b,alt+left,ctrl+left,<leader>b",
    
    // Character deletion (x/X)
    "input_delete": "ctrl+d,delete,shift+delete,<leader>x",
    "input_backspace": "backspace,shift+backspace,<leader>shift+x",
    
    // Word deletion (dw/db)
    "input_delete_word_forward": "alt+d,alt+delete,ctrl+delete,<leader>dw",
    "input_delete_word_backward": "ctrl+w,ctrl+backspace,alt+backspace,<leader>db",
    
    // Line deletion (dd/D/d0)
    "input_delete_line": "ctrl+shift+d,<leader>dd",
    "input_delete_to_line_end": "ctrl+k,<leader>shift+d",
    "input_delete_to_line_start": "ctrl+u,<leader>d0",
    
    // Visual mode approximation (v + movement)
    "input_select_left": "shift+left,<leader>vh",
    "input_select_down": "shift+down,<leader>vj",
    "input_select_up": "shift+up,<leader>vk",
    "input_select_right": "shift+right,<leader>vl",
    "input_select_word_forward": "alt+shift+f,alt+shift+right,<leader>vw",
    "input_select_word_backward": "alt+shift+b,alt+shift+left,<leader>vb",
    "input_select_line_home": "ctrl+shift+a,<leader>v0",
    "input_select_line_end": "ctrl+shift+e,<leader>v4",
    "input_select_buffer_home": "shift+home,<leader>vg",
    "input_select_buffer_end": "shift+end,<leader>vshift+g",
    
    // Input undo/redo (vim-style)
    "input_undo": "ctrl+-,super+z,<leader>iu",
    "input_redo": "ctrl+.,super+shift+z,<leader>ir",
    
    // ============================================
    // OPENCODE NATIVE KEYBINDINGS (REMAPPED)
    // ============================================
    
    // Application control
    "app_exit": "ctrl+c,ctrl+d,<leader>q",
    "editor_open": "<leader>e",
    "terminal_suspend": "ctrl+z",
    
    // Session management
    "session_new": "<leader>n",
    "session_list": "<leader>l",
    "session_timeline": "<leader>shift+g",
    "session_export": "<leader>shift+x",
    "session_interrupt": "escape",
    "session_compact": "<leader>c",
    "session_child_cycle": "<leader>+right",
    "session_child_cycle_reverse": "<leader>+left",
    "session_share": "none",
    "session_unshare": "none",
    
    // Message navigation
    "messages_page_up": "pageup",
    "messages_page_down": "pagedown",
    "messages_half_page_up": "ctrl+alt+u",
    "messages_half_page_down": "ctrl+alt+d",
    "messages_first": "ctrl+g,home",
    "messages_last": "ctrl+alt+g,end",
    "messages_copy": "<leader>y",
    "messages_undo": "<leader>u",
    "messages_redo": "<leader>r",
    "messages_last_user": "none",
    "messages_toggle_conceal": "<leader>shift+h",
    
    // UI toggles (remapped to avoid conflicts)
    "sidebar_toggle": "<leader>s",
    "theme_list": "<leader>shift+t",
    "status_view": "<leader>shift+s",
    "username_toggle": "none",
    
    // Model and agent selection
    "model_list": "<leader>m",
    "model_cycle_recent": "f2",
    "model_cycle_recent_reverse": "shift+f2",
    "agent_list": "<leader>a",
    "agent_cycle": "tab",
    "agent_cycle_reverse": "shift+tab",
    
    // Commands
    "command_list": "ctrl+p",
    
    // Input control
    "input_clear": "ctrl+c",
    "input_paste": "ctrl+v",
    "input_submit": "return",
    "input_newline": "shift+return,ctrl+return,alt+return,ctrl+j"
  },
  
  // Optional: Other settings
  "autoupdate": true,
  "theme": "opencode"
}
```

### Minimal Vim Configuration (Core Navigation Only)

For users who want vim navigation without full vim emulation:

```json
{
  "$schema": "https://opencode.ai/config.json",
  
  "keybinds": {
    "leader": "ctrl+x",
    
    // Core vim navigation (h/j/k/l)
    "input_move_left": "left,ctrl+b,<leader>h",
    "input_move_down": "down,<leader>j",
    "input_move_up": "up,<leader>k",
    "input_move_right": "right,ctrl+f,<leader>l",
    
    // Word movement (w/b)
    "input_word_forward": "alt+f,alt+right,ctrl+right,<leader>w",
    "input_word_backward": "alt+b,alt+left,ctrl+left,<leader>b",
    
    // Remap sidebar to avoid conflict
    "sidebar_toggle": "<leader>s"
  }
}
```

---

## Testing Strategy

### Test Plan

#### Phase 1: Core Navigation Testing

**Test Cases**:
1. **Basic movement**:
   - Press `<leader>h` → cursor moves left
   - Press `<leader>j` → cursor moves down
   - Press `<leader>k` → cursor moves up
   - Press `<leader>l` → cursor moves right

2. **Line navigation**:
   - Press `<leader>0` → cursor jumps to line start
   - Press `<leader>4` → cursor jumps to line end

3. **Buffer navigation**:
   - Press `<leader>g` → cursor jumps to buffer start
   - Press `<leader>shift+g` → cursor jumps to buffer end

4. **Existing keybindings still work**:
   - Arrow keys still move cursor
   - `ctrl+a` / `ctrl+e` still work
   - `home` / `end` still work

#### Phase 2: Word Movement Testing

**Test Cases**:
1. **Word forward**:
   - Type "hello world test"
   - Press `<leader>w` → cursor moves to start of "world"
   - Press `<leader>w` → cursor moves to start of "test"

2. **Word backward**:
   - Cursor at end of "test"
   - Press `<leader>b` → cursor moves to start of "test"
   - Press `<leader>b` → cursor moves to start of "world"

3. **Sidebar toggle still works**:
   - Press `<leader>s` → sidebar toggles (not `<leader>b`)

#### Phase 3: Deletion Testing

**Test Cases**:
1. **Character deletion**:
   - Type "hello"
   - Move cursor to 'e'
   - Press `<leader>x` → 'e' deleted, result: "hllo"

2. **Word deletion**:
   - Type "hello world"
   - Move cursor to 'h' in "hello"
   - Press `<leader>dw` → "hello" deleted, result: " world"

3. **Line deletion**:
   - Type "line 1\nline 2\nline 3"
   - Move cursor to "line 2"
   - Press `<leader>dd` → "line 2" deleted

4. **Session export still works**:
   - Press `<leader>shift+x` → session export dialog opens (not `<leader>x`)

#### Phase 4: Visual Mode Testing

**Test Cases**:
1. **Character selection**:
   - Type "hello"
   - Press `<leader>vl` three times → "hel" selected

2. **Word selection**:
   - Type "hello world"
   - Press `<leader>vw` → "hello" selected

3. **Line selection**:
   - Type "hello world"
   - Press `<leader>v4` → entire line selected

#### Phase 5: Undo/Redo Testing

**Test Cases**:
1. **Input undo**:
   - Type "hello"
   - Press `<leader>iu` → "hello" undone

2. **Input redo**:
   - Press `<leader>ir` → "hello" redone

3. **Message undo still works**:
   - Press `<leader>u` → message-level undo (not input undo)

### Testing Environments

1. **Standalone terminal**:
   - Run `opencode` in terminal
   - Test all keybindings

2. **Neovim integration**:
   - Open Neovim
   - Press `<C-CR>` to toggle OpenCode terminal
   - Test all keybindings

3. **Different terminals**:
   - Test in Ghostty (your primary terminal)
   - Test in other terminals (Alacritty, Kitty, etc.)

### Regression Testing

After each phase, verify:
- ✅ Existing OpenCode keybindings still work
- ✅ Neovim keybindings still work (`<C-CR>`, `<leader>ab`, etc.)
- ✅ No conflicts with terminal emulator keybindings
- ✅ Leader key pattern works consistently

---

## Conclusion

### Summary

**Feasibility**: ⚠️ **Partial** - Vim-inspired navigation is possible, but full vim emulation is not.

**Recommended Approach**:
1. Implement **vim-inspired keybindings** using leader key pattern
2. Focus on core navigation (h/j/k/l), word movement (w/b), and deletion (x/d)
3. Accept limitations (no modal editing, no command composition, no text objects)
4. Use external editor (`<leader>e`) for complex editing tasks

**Benefits**:
- ✅ Familiar vim-style navigation for vim users
- ✅ Consistent keybindings across OpenCode TUI and Neovim integration
- ✅ No conflicts with existing OpenCode features
- ✅ Gradual adoption (can enable phases incrementally)

**Trade-offs**:
- ⚠️ Requires two keypresses (leader + key) instead of one
- ⚠️ Not a full vim replacement (use external editor for complex edits)
- ⚠️ Some keybinding conflicts require remapping OpenCode defaults

### Next Steps

1. **Create configuration file**: `~/.config/opencode/opencode.json`
2. **Start with Phase 1**: Core navigation (h/j/k/l) only
3. **Test thoroughly**: Verify no conflicts with existing workflows
4. **Incrementally add phases**: Word movement → Deletion → Visual mode → Undo/redo
5. **Document customizations**: Keep track of remapped keybindings
6. **Iterate based on usage**: Adjust keybindings based on real-world usage patterns

---

**Generated**: 2025-12-20  
**Research Source**: `/home/benjamin/.config/.opencode/specs/opencode_keybinds_research.md`  
**Standards**: `/home/benjamin/.config/CLAUDE.md`
