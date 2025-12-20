# OpenCode Custom Keybindings

## Overview

This document describes the custom keybinding configuration for OpenCode, which implements a vim-inspired navigation and editing experience while preserving OpenCode's native functionality. The customization focuses on:

- **Ergonomic leader key** (Ctrl+D instead of Ctrl+X)
- **Vim-like navigation** using h/j/k/l patterns
- **Consistent modifier usage** (Alt for vim-style, Leader for OpenCode features)
- **Conflict resolution** between vim patterns and OpenCode defaults
- **Terminal compatibility** across different terminal emulators

## Leader Key

| Setting | Value | Rationale |
|---------|-------|-----------|
| **Original** | `Ctrl+X` | Default OpenCode leader |
| **Custom** | `Ctrl+D` | More ergonomic for frequent use, avoids conflict with cut operation |

The leader key is used throughout OpenCode for accessing primary features. `Ctrl+D` was chosen because:
- More comfortable hand position than `Ctrl+X`
- Less likely to conflict with standard terminal operations
- Frees up `Ctrl+D` from its original delete function (now handled by Delete key)

## Session Navigation

Vim-inspired session navigation using leader key combinations:

| Action | Original | Custom | Description |
|--------|----------|--------|-------------|
| **Next session** | `Ctrl+Alt+J` | `<leader>j` | Cycle to child session forward (vim down motion) |
| **Previous session** | `Ctrl+Alt+K` | `<leader>k` | Cycle to child session backward (vim up motion) |
| **Session list** | `<leader>l` | `<leader>s` | Open session list (moved to avoid conflict with "last message") |
| **New session** | `<leader>n` | `<leader>n` | Create new session (preserved) |
| **Timeline** | `<leader>g` | `<leader>g` | Open session timeline (preserved) |
| **Compact** | `<leader>c` | `<leader>c` | Compact session view (preserved) |
| **Export** | `<leader>x` | `<leader>x` | Export session (preserved) |
| **Interrupt** | `Escape` | `Escape` | Interrupt current operation (preserved) |

**Rationale**: Using `j`/`k` for forward/backward navigation mirrors vim's vertical movement, making session navigation intuitive for vim users.

## Message Navigation

Vim-inspired message scrolling and jumping:

| Action | Original | Custom | Description |
|--------|----------|--------|-------------|
| **Half page down** | `Ctrl+Alt+D` | `Alt+j` | Scroll messages down (vim-like) |
| **Half page up** | `Ctrl+Alt+U` | `Alt+k` | Scroll messages up (vim-like) |
| **First message** | `Ctrl+Alt+Home` | `<leader>h` | Jump to first message (vim home) |
| **Last message** | `Ctrl+Alt+G` | `<leader>l` | Jump to last message (vim G) |
| **Page down** | `PageDown` | `PageDown` | Full page down (preserved) |
| **Page up** | `PageUp` | `PageUp` | Full page up (preserved) |
| **Toggle conceal** | `Ctrl+Alt+C` | `none` | Disabled (rarely used) |

**Rationale**: 
- `Alt+j`/`Alt+k` for half-page scrolling matches vim's `Ctrl+D`/`Ctrl+U` semantics
- `<leader>h`/`<leader>l` for first/last mirrors vim's `gg`/`G` but uses h/l for left/right metaphor
- Alt modifier avoids conflicts with leader-based session navigation

## Input Editing - Core Operations

Modified to resolve conflicts with leader key and vim navigation:

| Action | Original | Custom | Description |
|--------|----------|--------|-------------|
| **Newline** | `Ctrl+J, Shift+Return` | `Shift+Return, Ctrl+Return, Alt+Return` | Insert newline (Ctrl+J removed) |
| **Delete** | `Delete, Ctrl+D` | `Delete, Shift+Delete` | Delete character (Ctrl+D removed for leader) |
| **Clear** | `Ctrl+C` | `Ctrl+C` | Clear input (preserved) |
| **Paste** | `Ctrl+V` | `Ctrl+V` | Paste from clipboard (preserved) |
| **Submit** | `Return` | `Return` | Submit message (preserved) |

**Rationale**:
- Removed `Ctrl+J` from newline to free it for potential vim navigation
- Removed `Ctrl+D` from delete to use as leader key
- Multiple newline options provide flexibility across terminals

## Vim-Like Editing - Phase 1: Core Navigation

Character and line movement using vim-style bindings:

| Action | Bindings | Vim Equivalent | Description |
|--------|----------|----------------|-------------|
| **Move left** | `Left, Ctrl+B, Alt+h` | `h` | Move cursor left one character |
| **Move down** | `Down, Alt+j` | `j` | Move cursor down one line |
| **Move up** | `Up, Alt+k` | `k` | Move cursor up one line |
| **Move right** | `Right, Ctrl+F, Alt+l` | `l` | Move cursor right one character |
| **Line home** | `Ctrl+A, Alt+0` | `0` | Move to start of line |
| **Line end** | `Ctrl+E, Alt+4` | `$` | Move to end of line (Alt+4 = Alt+Shift+$) |
| **Buffer home** | `Home, Alt+g` | `gg` | Move to start of buffer |
| **Buffer end** | `End, Alt+Shift+G` | `G` | Move to end of buffer |

**Rationale**:
- Alt modifier used instead of leader to avoid conflicts with session navigation
- Preserves Emacs-style bindings (`Ctrl+A`, `Ctrl+E`, `Ctrl+B`, `Ctrl+F`)
- `Alt+0` and `Alt+4` approximate vim's `0` and `$` keys

## Vim-Like Editing - Phase 2: Word Movement

Word-level navigation:

| Action | Bindings | Vim Equivalent | Description |
|--------|----------|----------------|-------------|
| **Word forward** | `Alt+F, Alt+Right, Ctrl+Right, Alt+w, Alt+e` | `w`, `e` | Move forward one word |
| **Word backward** | `Alt+B, Alt+Left, Ctrl+Left` | `b` | Move backward one word |

**Rationale**:
- Combines Emacs-style (`Alt+F`, `Alt+B`) with vim-style (`Alt+w`, `Alt+e`)
- Preserves standard terminal word movement (`Ctrl+Left`, `Ctrl+Right`)
- Both `w` and `e` mapped to forward movement (OpenCode doesn't distinguish word-start vs word-end)

## Vim-Like Editing - Phase 3: Deletion

Character, word, and line deletion operations:

| Action | Bindings | Vim Equivalent | Description |
|--------|----------|----------------|-------------|
| **Backspace** | `Backspace, Shift+Backspace, Alt+Shift+X` | `X` | Delete character before cursor |
| **Delete word forward** | `Alt+D, Alt+Delete, Ctrl+Delete` | `dw` | Delete from cursor to end of word |
| **Delete word backward** | `Ctrl+W, Ctrl+Backspace, Alt+Backspace` | `db` | Delete from cursor to start of word |
| **Delete line** | `Ctrl+Shift+D` | `dd` | Delete entire line |
| **Delete to line end** | `Ctrl+K` | `D` | Delete from cursor to end of line |
| **Delete to line start** | `Ctrl+U` | `d0` | Delete from cursor to start of line |

**Rationale**:
- `Alt+Shift+X` approximates vim's `X` (delete before cursor)
- `Ctrl+Shift+D` for line deletion avoids conflict with leader key
- Preserves Emacs-style line deletion (`Ctrl+K`, `Ctrl+U`)
- Multiple bindings provide compatibility across terminals

## Vim-Like Editing - Phase 4: Visual Mode

Selection operations approximating vim's visual mode:

| Action | Bindings | Vim Equivalent | Description |
|--------|----------|----------------|-------------|
| **Select left** | `Shift+Left, Alt+v,h` | `v` + `h` | Extend selection left |
| **Select down** | `Shift+Down, Alt+v,j` | `v` + `j` | Extend selection down |
| **Select up** | `Shift+Up, Alt+v,k` | `v` + `k` | Extend selection up |
| **Select right** | `Shift+Right, Alt+v,l` | `v` + `l` | Extend selection right |
| **Select word forward** | `Alt+Shift+F, Alt+Shift+Right` | `v` + `w` | Extend selection forward one word |
| **Select word backward** | `Alt+Shift+B, Alt+Shift+Left` | `v` + `b` | Extend selection backward one word |
| **Select to line home** | `Ctrl+Shift+A` | `v` + `0` | Extend selection to line start |
| **Select to line end** | `Ctrl+Shift+E` | `v` + `$` | Extend selection to line end |
| **Select to buffer home** | `Shift+Home` | `v` + `gg` | Extend selection to buffer start |
| **Select to buffer end** | `Shift+End` | `v` + `G` | Extend selection to buffer end |

**Rationale**:
- Standard Shift+Arrow keys preserved for compatibility
- `Alt+v,{motion}` provides vim-style visual mode approximation
- Shift+modifier combinations for word-level selection
- OpenCode doesn't support true modal editing, so visual mode is approximated

## Vim-Like Editing - Phase 5: Undo/Redo

Input history management:

| Action | Bindings | Vim Equivalent | Description |
|--------|----------|----------------|-------------|
| **Input undo** | `Ctrl+-, Super+Z` | `u` | Undo last input change |
| **Input redo** | `Ctrl+., Super+Shift+Z` | `Ctrl+R` | Redo last undone change |

**Note**: These are separate from message-level undo/redo:

| Action | Bindings | Description |
|--------|----------|-------------|
| **Message undo** | `<leader>u` | Undo last message operation |
| **Message redo** | `<leader>r` | Redo last undone message operation |

**Rationale**:
- `Ctrl+-` and `Ctrl+.` chosen for easy access (adjacent keys)
- `Super+Z` provides familiar undo for GUI users
- Separate input vs message undo prevents confusion

## OpenCode Native Features (Preserved)

All standard OpenCode features remain accessible:

### UI and Display
| Action | Binding | Description |
|--------|---------|-------------|
| **Sidebar toggle** | `<leader>b` | Toggle sidebar visibility |
| **Theme list** | `<leader>t` | Open theme selector |

### Model and Agent Selection
| Action | Binding | Description |
|--------|---------|-------------|
| **Model list** | `<leader>m` | Open model selector |
| **Agent list** | `<leader>a` | Open agent selector |
| **Agent cycle** | `Tab` | Cycle to next agent |
| **Agent cycle reverse** | `Shift+Tab` | Cycle to previous agent |

### Commands and Operations
| Action | Binding | Description |
|--------|---------|-------------|
| **Command list** | `Ctrl+P` | Open command palette |
| **Copy messages** | `<leader>y` | Copy selected messages |
| **Editor open** | `<leader>e` | Open external editor |
| **App exit** | `Ctrl+C, <leader>q` | Exit OpenCode |

## Vim-Mode Capabilities and Limitations

### Capabilities ✅

This configuration provides:
- **Character navigation**: h/j/k/l movement patterns
- **Word movement**: w/b/e navigation
- **Line navigation**: 0/$ for line start/end, gg/G for buffer start/end
- **Deletion operations**: x/X, dw/db, dd/D/d0 patterns
- **Visual mode approximation**: v + motion for selections
- **Undo/redo**: u and Ctrl+R equivalents
- **Consistent modifier usage**: Alt for vim-style, Leader for OpenCode features

### Limitations ⚠️

OpenCode is not a modal editor, so the following vim features are **not available**:

- **Modal editing**: No separate insert/normal/visual modes
- **Command mode**: No `:` commands (use `Ctrl+P` for command palette instead)
- **Operators + motions**: No `d{motion}`, `c{motion}`, `y{motion}` composition
- **Text objects**: No `iw`, `i"`, `it` inner/around objects
- **Registers**: No named registers for yanking/pasting
- **Macros**: No `q` macro recording
- **Marks**: No `m{letter}` position marks
- **Search**: No `/` or `?` search (use OpenCode's search features)
- **Repeat**: No `.` command to repeat last change
- **Count prefixes**: No `3j` or `5dd` numeric prefixes

### Workarounds

For missing vim features, use these OpenCode alternatives:

| Vim Feature | OpenCode Alternative |
|-------------|---------------------|
| `:w` (save) | Sessions auto-save |
| `:q` (quit) | `<leader>q` or `Ctrl+C` |
| `/search` | `Ctrl+P` → search commands |
| `y{motion}` (yank) | `<leader>y` (copy messages) |
| `.` (repeat) | Manual repetition |
| `:{range}d` (delete range) | Select with Shift+arrows, then Delete |

## Quick Reference Card

### Essential Bindings

```
LEADER KEY: Ctrl+D

NAVIGATION
  Alt+h/j/k/l     Character movement (left/down/up/right)
  Alt+w/b         Word forward/backward
  Alt+0/Alt+4     Line start/end
  Alt+g/Alt+G     Buffer start/end

DELETION
  Alt+Shift+X     Delete before cursor (backspace)
  Alt+D           Delete word forward
  Ctrl+W          Delete word backward
  Ctrl+Shift+D    Delete line
  Ctrl+K          Delete to line end

SELECTION
  Shift+arrows    Extend selection
  Alt+v,{motion}  Visual mode approximation

SESSIONS
  <leader>j/k     Next/previous session
  <leader>s       Session list
  <leader>n       New session

MESSAGES
  Alt+j/k         Half page down/up
  <leader>h/l     First/last message
  <leader>y       Copy messages

UNDO/REDO
  Ctrl+-          Input undo
  Ctrl+.          Input redo
  <leader>u/r     Message undo/redo

OPENCODE
  <leader>m       Model list
  <leader>a       Agent list
  <leader>t       Theme list
  Ctrl+P          Command palette
  <leader>q       Quit
```

## Troubleshooting

### Common Issues

#### 1. Alt+Key Not Working

**Problem**: Alt+h/j/k/l or other Alt combinations don't work.

**Solutions**:
- **Terminal emulator**: Check if Alt is configured to send escape sequences
  - **Ghostty**: Ensure `alt-sends-escape = true` in config
  - **Alacritty**: Set `alt_send_esc: true` in alacritty.yml
  - **iTerm2**: Profiles → Keys → Left/Right Option key → Esc+
- **tmux**: Add `set -g xterm-keys on` to .tmux.conf
- **Screen**: May require `bindkey` configuration

#### 2. Leader Key Not Responding

**Problem**: `Ctrl+D` doesn't trigger leader key.

**Solutions**:
- Verify OpenCode loaded the config: Check for `~/.config/opencode/opencode.json`
- Restart OpenCode after config changes
- Check for terminal intercepting `Ctrl+D` (EOF signal)
- Try alternative: Use `<leader>` in bindings, OpenCode will recognize it

#### 3. Conflicts with Terminal Shortcuts

**Problem**: Some bindings conflict with terminal emulator shortcuts.

**Solutions**:
- **Ctrl+Shift+D**: May conflict with terminal split/duplicate
  - Disable terminal binding or use alternative line deletion
- **Alt+j/k**: May conflict with terminal tab switching
  - Reconfigure terminal or use PageUp/PageDown instead
- **Ctrl+C**: May send SIGINT instead of clearing input
  - Use `<leader>q` for quit, or configure terminal to pass through

#### 4. Vim Bindings Feel Incomplete

**Problem**: Missing expected vim features (operators, text objects, etc.)

**Solution**: This is expected - OpenCode is not a modal editor. See [Limitations](#limitations-️) section for workarounds.

#### 5. Undo/Redo Not Working as Expected

**Problem**: Undo doesn't behave like vim's undo.

**Explanation**: 
- **Input undo** (`Ctrl+-`): Undoes changes in the current input field
- **Message undo** (`<leader>u`): Undoes message-level operations
- These are separate systems - input undo won't undo submitted messages

## Terminal Compatibility

### Tested Terminals

| Terminal | Status | Notes |
|----------|--------|-------|
| **Ghostty** | ✅ Full support | Set `alt-sends-escape = true` |
| **Alacritty** | ✅ Full support | Set `alt_send_esc: true` |
| **Kitty** | ✅ Full support | Works out of box |
| **iTerm2** | ✅ Full support | Configure Option key as Esc+ |
| **GNOME Terminal** | ⚠️ Partial | Some Alt combinations may conflict with menu |
| **Konsole** | ✅ Full support | Works out of box |
| **Windows Terminal** | ⚠️ Partial | Alt key behavior varies |
| **tmux** | ✅ Full support | Add `set -g xterm-keys on` |

### Terminal-Specific Configuration

#### Ghostty
```
# ~/.config/ghostty/config
alt-sends-escape = true
```

#### Alacritty
```yaml
# ~/.config/alacritty/alacritty.yml
key_bindings:
  - { key: J, mods: Alt, chars: "\x1bj" }
  - { key: K, mods: Alt, chars: "\x1bk" }
  # ... or globally:
alt_send_esc: true
```

#### iTerm2
1. Preferences → Profiles → Keys
2. Set "Left Option key" to "Esc+"
3. Set "Right Option key" to "Esc+"

#### tmux
```bash
# ~/.tmux.conf
set -g xterm-keys on
set -g default-terminal "screen-256color"
```

### Key Sequence Testing

To verify your terminal sends correct sequences:

```bash
# Run this and press Alt+j
cat -v
# Should show: ^[j (Escape + j)

# Or use:
showkey -a
# Press Alt+j, should show: ^[ j
```

## Configuration File Location

The keybinding configuration is stored in:
```
~/.config/opencode/opencode.json
```

To edit manually:
```bash
# Open in editor
$EDITOR ~/.config/opencode/opencode.json

# Or use OpenCode's editor
# Press <leader>e while in OpenCode
```

After editing, restart OpenCode to apply changes.

## Further Customization

To customize keybindings further:

1. **Edit the config file**: Modify `~/.config/opencode/opencode.json`
2. **Available actions**: See OpenCode documentation for complete action list
3. **Binding syntax**:
   - Single key: `"a"`, `"return"`, `"escape"`
   - With modifier: `"ctrl+a"`, `"alt+j"`, `"shift+return"`
   - Leader: `"<leader>x"` (expands to configured leader key)
   - Multiple: `"ctrl+a,alt+a"` (comma-separated alternatives)
4. **Restart required**: OpenCode must be restarted after config changes

### Example: Adding Custom Binding

```json
{
  "keybinds": {
    "leader": "ctrl+d",
    
    // Add custom binding
    "session_new": "<leader>n,alt+n",  // Now both work
    
    // Disable a binding
    "messages_toggle_conceal": "none",
    
    // ... rest of config
  }
}
```

## Resources

- **OpenCode Documentation**: https://opencode.ai/docs
- **Config Schema**: `~/.config/opencode/opencode.json` (`$schema` field)
- **Vim Reference**: https://vimhelp.org (for vim command equivalents)
- **This Document**: `~/.config/opencode/KEYBINDINGS.md`

## Version History

- **2025-12-20**: Initial vim-inspired keybinding configuration
  - Implemented 5-phase vim-like editing
  - Changed leader key to Ctrl+D
  - Added comprehensive documentation

---

**Last Updated**: 2025-12-20  
**OpenCode Version**: Compatible with OpenCode 1.x  
**Configuration Version**: 1.0
