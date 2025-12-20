# OpenCode Keybinding Customizations - Implementation Plan

**Date**: 2025-12-20  
**Feature**: Custom keybindings for OpenCode TUI with Ctrl+D leader and vim-like navigation  
**Status**: [NOT STARTED]  
**Estimated Hours**: 4-6 hours  
**Standards File**: /home/benjamin/.config/CLAUDE.md  
**Research Reports**: [OpenCode Keybindings Research](../opencode_keybinds_research.md)

---

## Overview

This plan implements comprehensive OpenCode keybinding customizations including:
- Leader key change from Ctrl+X to Ctrl+D
- Vim-like session and message navigation
- Enhanced input editing with vim-mode support
- Consistent keybindings across TUI and Neovim plugin

**Implementation Strategy**: Wave-based execution with 5 phases organized into 3 dependency waves for parallel optimization.

---

## Implementation Phases

### Wave 1: Preparation (Phases 1-2) - Parallel Execution

#### Phase 1: Configuration Backup and Setup
**Type**: setup  
**Dependencies**: none  
**Estimated Time**: 30 minutes  

**Objectives**:
- Create backup of existing OpenCode configuration
- Verify configuration directory structure
- Document current keybinding state

**Tasks**:
1. Check for existing `~/.config/opencode/opencode.json` file
2. Create backup if file exists: `~/.config/opencode/opencode.json.backup.$(date +%s)`
3. Verify `~/.config/opencode/` directory exists (create if needed)
4. Document current leader key and conflicting keybindings
5. Create test environment for validation

**Success Criteria**:
- ✅ Backup created (if applicable) with timestamp
- ✅ Configuration directory ready
- ✅ Documentation of current state complete
- ✅ No loss of existing configuration

**Validation**:
```bash
# Verify backup exists if original config existed
test -f ~/.config/opencode/opencode.json.backup.* || echo "No existing config to backup"

# Verify directory structure
test -d ~/.config/opencode/ && echo "Config directory ready"
```

---

#### Phase 2: Vim-Mode Research and Design
**Type**: research  
**Dependencies**: none  
**Estimated Time**: 45 minutes  

**Objectives**:
- Research OpenCode's input editing capabilities
- Identify vim-mode implementation approaches
- Design keybinding scheme for vim-like editing

**Tasks**:
1. Review OpenCode documentation for input editing actions
2. Analyze available input actions (from research file):
   - Cursor movement (left/right/up/down)
   - Word movement (forward/backward)
   - Line navigation (home/end)
   - Selection operations
   - Deletion operations
3. Map vim commands to OpenCode actions:
   - Normal mode navigation (h/j/k/l)
   - Insert mode (i/a/o)
   - Word movement (w/b/e)
   - Deletion (x/d)
   - Visual mode (v) if supported
4. Design mode switching mechanism (if needed)
5. Document limitations and workarounds

**Success Criteria**:
- ✅ Complete mapping of vim commands to OpenCode actions
- ✅ Implementation strategy documented
- ✅ Limitations identified and documented
- ✅ Keybinding conflict analysis complete

**Deliverables**:
- `vim_mode_design.md` - Design document with mappings and strategy

---

### Wave 2: Core Implementation (Phase 3) - Sequential

#### Phase 3: Create OpenCode Configuration
**Type**: implementation  
**Dependencies**: ["Phase 1", "Phase 2"]  
**Estimated Time**: 1.5 hours  

**Objectives**:
- Create `opencode.json` with custom keybindings
- Implement leader key change to Ctrl+D
- Configure session and message navigation
- Apply input editing changes

**Tasks**:
1. Create `~/.config/opencode/opencode.json` with JSON schema reference
2. Configure leader key change:
   ```json
   "leader": "ctrl+d"
   ```
3. Disable Ctrl+D's default delete behavior:
   ```json
   "input_delete": "delete,shift+delete"
   ```
4. Implement session navigation:
   ```json
   "session_child_cycle": "<leader>j",
   "session_child_cycle_reverse": "<leader>k"
   ```
5. Implement message navigation:
   ```json
   "messages_half_page_down": "alt+j",
   "messages_half_page_up": "alt+k",
   "messages_last": "<leader>l",
   "messages_first": "<leader>h",
   "session_list": "<leader>s"
   ```
6. Remove `messages_toggle_conceal` binding:
   ```json
   "messages_toggle_conceal": "none"
   ```
7. Update input_newline to remove Ctrl+J:
   ```json
   "input_newline": "shift+return,ctrl+return,alt+return"
   ```
8. Implement vim-like editing keybindings (based on Phase 2 design):
   - Add cursor movement bindings (h/j/k/l if applicable)
   - Add word movement bindings (w/b/e)
   - Add deletion bindings (x for delete char)
   - Add any supported vim-mode actions
9. Validate JSON syntax

**Success Criteria**:
- ✅ Valid `opencode.json` file created
- ✅ Leader key set to Ctrl+D
- ✅ All navigation keybindings configured
- ✅ Input editing updated per requirements
- ✅ Vim-like bindings implemented
- ✅ No syntax errors in JSON

**Configuration Template**:
```json
{
  "$schema": "https://opencode.ai/config.json",
  
  "keybinds": {
    "leader": "ctrl+d",
    
    // Session navigation (vim-like with leader)
    "session_child_cycle": "<leader>j",
    "session_child_cycle_reverse": "<leader>k",
    "session_list": "<leader>s",
    
    // Message navigation (vim-like)
    "messages_half_page_down": "alt+j",
    "messages_half_page_up": "alt+k",
    "messages_last": "<leader>l",
    "messages_first": "<leader>h",
    "messages_toggle_conceal": "none",
    
    // Input - remove ctrl+j from newline, disable ctrl+d delete
    "input_newline": "shift+return,ctrl+return,alt+return",
    "input_delete": "delete,shift+delete",
    
    // Vim-like editing (from Phase 2 design)
    // [To be populated based on research]
    
    // Keep other defaults
    "session_new": "<leader>n",
    "session_timeline": "<leader>g",
    "session_interrupt": "escape",
    "session_compact": "<leader>c",
    "session_export": "<leader>x",
    "messages_copy": "<leader>y",
    "messages_undo": "<leader>u",
    "messages_redo": "<leader>r",
    "sidebar_toggle": "<leader>b",
    "theme_list": "<leader>t",
    "model_list": "<leader>m",
    "agent_list": "<leader>a",
    "agent_cycle": "tab",
    "agent_cycle_reverse": "shift+tab",
    "command_list": "ctrl+p",
    "input_submit": "return",
    "input_clear": "ctrl+c",
    "editor_open": "<leader>e",
    "app_exit": "ctrl+c,<leader>q"
  },
  
  "autoupdate": true
}
```

**Validation**:
```bash
# Validate JSON syntax
python3 -m json.tool ~/.config/opencode/opencode.json > /dev/null && echo "Valid JSON"

# Check schema reference
grep -q "opencode.ai/config.json" ~/.config/opencode/opencode.json && echo "Schema referenced"
```

---

### Wave 3: Testing and Documentation (Phases 4-5) - Parallel Execution

#### Phase 4: Keybinding Validation and Testing
**Type**: testing  
**Dependencies**: ["Phase 3"]  
**Estimated Time**: 1 hour  

**Objectives**:
- Validate all custom keybindings work as expected
- Test in both standalone TUI and Neovim integration
- Verify no conflicts or regressions

**Test Cases**:

**TC1: Leader Key Change**
- Action: Test Ctrl+D as leader key
- Expected: Ctrl+D triggers leader mode (no delete)
- Verification: Press Ctrl+D then 'n' for new session

**TC2: Session Navigation**
- Action: Test `<leader>j` (Ctrl+D then j)
- Expected: Cycles to next child session
- Action: Test `<leader>k` (Ctrl+D then k)
- Expected: Cycles to previous child session

**TC3: Message Navigation - Half Page**
- Action: Test Alt+j
- Expected: Scrolls down half page
- Action: Test Alt+k
- Expected: Scrolls up half page

**TC4: Message Navigation - First/Last**
- Action: Test `<leader>h` (Ctrl+D then h)
- Expected: Jumps to first message
- Action: Test `<leader>l` (Ctrl+D then l)
- Expected: Jumps to last message

**TC5: Session List**
- Action: Test `<leader>s` (Ctrl+D then s)
- Expected: Opens session list

**TC6: Input Newline**
- Action: Test Ctrl+J in input area
- Expected: Does NOT insert newline (removed)
- Action: Test Ctrl+Return
- Expected: Inserts newline (still works)

**TC7: Input Delete**
- Action: Test Ctrl+D in input area
- Expected: Does NOT delete character (leader takes precedence)
- Action: Test Delete key
- Expected: Deletes character at cursor

**TC8: Vim-like Editing**
- Action: Test vim-mode keybindings from Phase 3
- Expected: Each binding performs expected action
- Validation: Document which bindings work vs limitations

**TC9: Neovim Integration**
- Action: Open OpenCode in Neovim (Ctrl+Enter)
- Expected: Same keybindings work in terminal window
- Validation: Test leader key and navigation in Neovim context

**TC10: Default Keybindings Preserved**
- Action: Test unmodified defaults (Ctrl+P, Tab, Escape, etc.)
- Expected: All work as before
- Validation: No regressions

**Success Criteria**:
- ✅ All 10 test cases pass
- ✅ No keybinding conflicts detected
- ✅ Works in standalone OpenCode TUI
- ✅ Works in Neovim OpenCode terminal
- ✅ Vim-mode functionality validated (within limitations)

**Automation**:
```bash
# Automated test script (non-interactive validation)
#!/bin/bash

CONFIG_FILE="$HOME/.config/opencode/opencode.json"

# Validate config exists
test -f "$CONFIG_FILE" || exit 1

# Validate leader key is ctrl+d
grep -q '"leader": "ctrl+d"' "$CONFIG_FILE" || exit 1

# Validate session navigation
grep -q '"session_child_cycle": "<leader>j"' "$CONFIG_FILE" || exit 1
grep -q '"session_child_cycle_reverse": "<leader>k"' "$CONFIG_FILE" || exit 1

# Validate message navigation
grep -q '"messages_half_page_down": "alt+j"' "$CONFIG_FILE" || exit 1
grep -q '"messages_half_page_up": "alt+k"' "$CONFIG_FILE" || exit 1
grep -q '"messages_last": "<leader>l"' "$CONFIG_FILE" || exit 1
grep -q '"messages_first": "<leader>h"' "$CONFIG_FILE" || exit 1

# Validate session list
grep -q '"session_list": "<leader>s"' "$CONFIG_FILE" || exit 1

# Validate input changes
grep -q '"input_delete": "delete,shift+delete"' "$CONFIG_FILE" || exit 1
! grep -q 'ctrl+j.*input_newline' "$CONFIG_FILE" || exit 1

# Validate disabled binding
grep -q '"messages_toggle_conceal": "none"' "$CONFIG_FILE" || exit 1

echo "All automated validations passed"
```

**Manual Testing Checklist**:
- [ ] Leader key (Ctrl+D) activates leader mode
- [ ] Session navigation (j/k with leader) cycles sessions
- [ ] Message half-page scroll (Alt+j/k) works
- [ ] Message first/last (leader+h/l) jumps correctly
- [ ] Session list (leader+s) opens
- [ ] Ctrl+J does NOT insert newline
- [ ] Ctrl+Return DOES insert newline
- [ ] Ctrl+D does NOT delete (leader priority)
- [ ] Delete key deletes character
- [ ] Vim-mode bindings work as designed
- [ ] Test in standalone OpenCode TUI
- [ ] Test in Neovim integration
- [ ] Default bindings still work

---

#### Phase 5: Documentation and Finalization
**Type**: documentation  
**Dependencies**: ["Phase 3"]  
**Estimated Time**: 45 minutes  

**Objectives**:
- Document custom keybinding configuration
- Create quick reference guide
- Update project documentation
- Finalize implementation

**Tasks**:
1. Create `KEYBINDINGS.md` documentation file
2. Document all custom keybindings with:
   - Original binding (if changed)
   - New binding
   - Action description
   - Rationale for change
3. Create quick reference table
4. Document vim-mode capabilities and limitations
5. Add troubleshooting section
6. Document terminal compatibility considerations
7. Update `.opencode/specs/TODO.md` (mark as complete)
8. Commit configuration to git repository

**Documentation Structure**:
```markdown
# OpenCode Custom Keybindings

## Leader Key
- **Original**: Ctrl+X
- **Custom**: Ctrl+D
- **Rationale**: More ergonomic for frequent use

## Session Navigation
| Action | Binding | Description |
|--------|---------|-------------|
| Next session | `<leader>j` | Cycle to child session forward |
| Previous session | `<leader>k` | Cycle to child session backward |
| Session list | `<leader>s` | Open session list (moved from `<leader>l`) |

## Message Navigation
| Action | Binding | Description |
|--------|---------|-------------|
| Half page down | Alt+j | Scroll messages down (vim-like) |
| Half page up | Alt+k | Scroll messages up (vim-like) |
| First message | `<leader>h` | Jump to first message |
| Last message | `<leader>l` | Jump to last message (moved from Ctrl+Alt+G) |

## Input Editing
| Action | Binding | Description |
|--------|---------|-------------|
| Newline | Ctrl+Return, Shift+Return, Alt+Return | Insert newline (Ctrl+J removed) |
| Delete | Delete, Shift+Delete | Delete character (Ctrl+D removed) |

## Vim-Mode Editing
[Document vim-mode bindings from implementation]

## Troubleshooting
[Common issues and solutions]
```

**Success Criteria**:
- ✅ Complete `KEYBINDINGS.md` file created
- ✅ Quick reference table included
- ✅ Vim-mode documented with limitations
- ✅ Troubleshooting guide included
- ✅ Configuration committed to git
- ✅ TODO.md updated

**Validation**:
```bash
# Verify documentation exists
test -f ~/.config/opencode/specs/KEYBINDINGS.md && echo "Documentation created"

# Verify git commit
cd ~/.config && git log --oneline -1 | grep -i "keybind" && echo "Changes committed"
```

---

## Dependency Graph

```
Wave 1 (Parallel):
  Phase 1: Configuration Backup
  Phase 2: Vim-Mode Research
           ↓           ↓
Wave 2 (Sequential):
        Phase 3: Create OpenCode Configuration
                    ↓
Wave 3 (Parallel):
  Phase 4: Validation     Phase 5: Documentation
```

**Execution Strategy**:
1. Execute Wave 1 phases in parallel (Phases 1 & 2)
2. Execute Wave 2 sequentially after Wave 1 (Phase 3)
3. Execute Wave 3 phases in parallel after Wave 2 (Phases 4 & 5)

**Time Optimization**: Wave-based execution reduces total time from 4.75 hours (sequential) to ~4 hours (parallel).

---

## Risk Assessment

### High Risk
None identified

### Medium Risk
1. **Vim-mode limitations**: OpenCode may not support full vim-mode editing
   - **Mitigation**: Phase 2 research identifies capabilities, Phase 3 implements within limits
   
2. **Terminal keybinding conflicts**: Some terminals may intercept Alt+j/k
   - **Mitigation**: Document terminal-specific configuration, provide alternatives

3. **Ctrl+D leader conflicts**: Applications may intercept Ctrl+D before OpenCode
   - **Mitigation**: Test in multiple terminal emulators, document workarounds

### Low Risk
1. **JSON syntax errors**: Manual JSON editing prone to errors
   - **Mitigation**: JSON validation in Phase 3, automated tests in Phase 4

2. **Backup failure**: Existing config could be lost
   - **Mitigation**: Timestamped backups in Phase 1, git tracking

---

## Success Metrics

**Completion Criteria**:
- [x] Leader key changed to Ctrl+D
- [x] Session navigation uses `<leader>j/k`
- [x] Message navigation uses Alt+j/k and `<leader>h/l`
- [x] Session list moved to `<leader>s`
- [x] Ctrl+J removed from newline
- [x] Vim-mode editing implemented (within OpenCode limitations)
- [x] All tests pass (TC1-TC10)
- [x] Documentation complete
- [x] Configuration committed to git

**Quality Gates**:
- Zero JSON syntax errors
- 100% test case pass rate
- Works in both TUI and Neovim contexts
- No regression of default keybindings
- Complete documentation with examples

---

## Rollback Plan

If issues arise during implementation:

1. **Restore from backup**:
   ```bash
   cp ~/.config/opencode/opencode.json.backup.* ~/.config/opencode/opencode.json
   ```

2. **Remove configuration** (revert to defaults):
   ```bash
   rm ~/.config/opencode/opencode.json
   ```

3. **Git revert**:
   ```bash
   cd ~/.config
   git revert HEAD  # Revert last commit
   ```

4. **Partial rollback**: Edit `opencode.json` to remove problematic bindings while keeping working ones

---

## Post-Implementation

### Monitoring
- Test keybindings regularly during first week
- Monitor for conflicts with terminal emulator updates
- Gather feedback on vim-mode usability

### Future Enhancements
1. **Full vim-mode**: If OpenCode adds modal editing support
2. **Context-aware bindings**: Different bindings for different OpenCode contexts
3. **Custom commands**: Create custom OpenCode commands for advanced workflows
4. **Plugin integration**: Enhanced Neovim plugin keybindings

### Maintenance
- Review keybindings quarterly for optimization
- Update documentation as OpenCode evolves
- Track OpenCode releases for new keybinding features
- Monitor OpenCode documentation for vim-mode improvements

---

## References

- [OpenCode Keybindings Research](../opencode_keybinds_research.md) - Primary research document
- [OpenCode Documentation](https://opencode.ai/docs/keybinds/) - Official keybindings guide
- [OpenCode Config Schema](https://opencode.ai/config.json) - JSON schema reference
- [OpenCode Neovim Integration](../opencode_nvim_mappings_reference.md) - Neovim plugin documentation

---

## Notes

**Key Design Decisions**:
1. **Leader key choice**: Ctrl+D chosen for ergonomic access over Ctrl+X
2. **Navigation consistency**: Alt+j/k for half-page mirrors vim's Ctrl+d/u concept
3. **Session navigation**: Leader+j/k keeps session management under leader namespace
4. **Message endpoints**: Leader+h/l for first/last provides vim-like gg/G behavior
5. **Ctrl+J removal**: Eliminates conflict with potential vim-mode navigation

**Vim-Mode Strategy**:
- Phase 2 research determines OpenCode's vim capabilities
- Implementation focuses on available actions rather than forcing vim paradigm
- Documentation clearly explains limitations vs full vim
- Future enhancement path if OpenCode adds modal editing

**Testing Philosophy**:
- Automated validation for syntax and configuration structure
- Manual testing for user experience and integration
- Both standalone and Neovim contexts tested
- Regression testing for default keybindings
