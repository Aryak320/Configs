# Implementation Plan: NixOS Sleep Inhibit Toggle in Neovim

## Metadata

- **Date**: 2025-12-20
- **Feature**: Add sleep inhibitor toggle mapping under `<leader>rz` in which-key.lua
- **Status**: [COMPLETED]
- **Type**: new_feature
- **Implementation**: sequential
- **Estimated Hours**: 2-4 hours
- **Standards File**: /home/benjamin/.config/STANDARDS.md
- **Research Reports**: 
  - [NixOS Sleep Prevention for OpenCode](../reports/017_nixos_sleep_prevention_opencode.md)
- **Revisions**: none

## Dependencies

**Implementation Waves**:
- **Wave 1**: Phase 1 (standalone)
- **Wave 2**: Phase 2 (depends on Phase 1)
- **Wave 3**: Phase 3 (depends on Phase 2)

**Dependency Graph**:
```
Phase 1 ──> Phase 2 ──> Phase 3
```

## Phase 1: Create Sleep Inhibitor Lua Module [COMPLETED]

**Dependencies**: []

**Description**: Create a standalone Lua module that manages systemd sleep inhibitor functionality with proper error handling, state management, and automatic cleanup.

**Tasks**:
1. Create new file `~/.config/nvim/lua/neotex/util/sleep-inhibit.lua`
2. Implement module structure with state tracking (`inhibit_job_id`, `is_active`)
3. Implement `enable()` function to start systemd-inhibit background process
4. Implement `disable()` function to stop inhibitor and clean up
5. Implement `toggle()` function for easy on/off switching
6. Implement `status()` function to check current inhibitor state
7. Add VimLeavePre autocmd for automatic cleanup on Neovim exit
8. Add comprehensive error handling with vim.notify feedback
9. Document all functions with LuaDoc comments

**Files Created**:
- `~/.config/nvim/lua/neotex/util/sleep-inhibit.lua` - Sleep inhibitor module

**Testing**:
- **Type**: automated
- **Method**: programmatic
- **Commands**: 
  ```bash
  # Test module loading
  nvim --headless -c "lua require('neotex.util.sleep-inhibit')" -c "quit" 2>&1 | grep -q "Error" && echo "FAIL: Module load error" || echo "PASS: Module loads"
  
  # Test enable function
  nvim --headless -c "lua local si = require('neotex.util.sleep-inhibit'); si.enable(); vim.wait(1000); print(si.is_active and 'PASS' or 'FAIL')" -c "quit"
  
  # Test toggle function
  nvim --headless -c "lua local si = require('neotex.util.sleep-inhibit'); si.toggle(); vim.wait(500); si.toggle(); print(not si.is_active and 'PASS' or 'FAIL')" -c "quit"
  
  # Test cleanup on exit
  nvim --headless -c "lua require('neotex.util.sleep-inhibit').enable()" -c "quit" && sleep 1 && ! systemd-inhibit --list | grep -q "Neovim" && echo "PASS: Cleanup works" || echo "FAIL: Cleanup failed"
  ```
- **Success Criteria**: All tests pass, no errors in module loading

**Success Criteria**:
- [ ] Module file created at correct path
- [ ] All functions implemented with proper error handling
- [ ] State tracking works correctly (is_active flag)
- [ ] Background job starts and stops cleanly
- [ ] VimLeavePre autocmd registered for cleanup
- [ ] All automated tests pass
- [ ] No Lua syntax errors

**Rollback**: `rm ~/.config/nvim/lua/neotex/util/sleep-inhibit.lua`

---

## Phase 2: Integrate Sleep Inhibitor into which-key.lua [COMPLETED]

**Dependencies**: [1]

**Description**: Add the sleep inhibitor toggle mapping under `<leader>rz` in the which-key.lua configuration file, following existing patterns and conventions.

**Tasks**:
1. Open `~/.config/nvim/lua/neotex/plugins/editor/which-key.lua`
2. Locate the `<leader>r - RUN GROUP` section (around line 648)
3. Add new mapping entry for `<leader>rz` after `<leader>ru` (line 676)
4. Configure mapping with:
   - Key: `<leader>rz`
   - Function: Call `require('neotex.util.sleep-inhibit').toggle()`
   - Description: "toggle sleep inhibitor"
   - Icon: "󰒲" (no-sleep icon)
5. Ensure proper formatting and alignment with existing entries
6. Verify alphabetical ordering within the group

**Files Modified**:
- `~/.config/nvim/lua/neotex/plugins/editor/which-key.lua` - Add sleep inhibitor mapping

**Testing**:
- **Type**: automated
- **Method**: programmatic
- **Commands**: 
  ```bash
  # Test which-key configuration loads without errors
  nvim --headless -c "lua require('neotex.plugins.editor.which-key')" -c "quit" 2>&1 | grep -q "Error" && echo "FAIL: Config error" || echo "PASS: Config loads"
  
  # Test mapping exists
  nvim --headless -c "lua local wk = require('which-key'); local mappings = wk.get_mappings(); print(vim.inspect(mappings))" -c "quit" 2>&1 | grep -q "toggle sleep inhibitor" && echo "PASS: Mapping exists" || echo "FAIL: Mapping not found"
  
  # Test keymap is callable
  nvim --headless -c "lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<leader>rz', true, false, true), 'x', false); vim.wait(500)" -c "quit" 2>&1 | grep -q "Error" && echo "FAIL: Keymap error" || echo "PASS: Keymap works"
  
  # Test integration with sleep-inhibit module
  nvim --headless -c "lua require('neotex.util.sleep-inhibit').toggle(); print(require('neotex.util.sleep-inhibit').is_active and 'PASS' or 'FAIL')" -c "quit"
  ```
- **Success Criteria**: All tests pass, mapping appears in which-key menu

**Success Criteria**:
- [ ] Mapping added to which-key.lua in correct location
- [ ] Mapping follows existing code style and conventions
- [ ] Icon and description are appropriate
- [ ] Alphabetical ordering maintained
- [ ] All automated tests pass
- [ ] No Lua syntax errors in which-key.lua

**Rollback**: `git checkout ~/.config/nvim/lua/neotex/plugins/editor/which-key.lua`

---

## Phase 3: End-to-End Testing and Documentation [COMPLETED]

**Dependencies**: [2]

**Description**: Perform comprehensive end-to-end testing of the sleep inhibitor functionality and update documentation to reflect the new feature.

**Tasks**:
1. Test complete workflow in running Neovim instance:
   - Press `<leader>rz` to enable inhibitor
   - Verify notification appears
   - Check systemd-inhibit --list shows Neovim lock
   - Press `<leader>rz` again to disable
   - Verify lock is removed
2. Test automatic cleanup on Neovim exit
3. Test error handling (systemd-inhibit not available, etc.)
4. Update which-key.lua header documentation with new mapping
5. Add usage notes to Neovim configuration documentation
6. Create commit with conventional commit message

**Files Modified**:
- `~/.config/nvim/lua/neotex/plugins/editor/which-key.lua` - Update header documentation

**Testing**:
- **Type**: automated
- **Method**: programmatic
- **Commands**: 
  ```bash
  # Full integration test
  nvim --headless -c "lua local si = require('neotex.util.sleep-inhibit'); si.enable(); vim.wait(1000); local active = si.is_active; si.disable(); vim.wait(500); print(active and not si.is_active and 'PASS' or 'FAIL')" -c "quit"
  
  # Test systemd-inhibit lock creation
  nvim --headless -c "lua require('neotex.util.sleep-inhibit').enable()" -c "sleep 2" -c "quit" &
  NVIM_PID=$!
  sleep 1
  systemd-inhibit --list | grep -q "Neovim" && echo "PASS: Lock created" || echo "FAIL: No lock"
  wait $NVIM_PID
  
  # Test lock cleanup after exit
  nvim --headless -c "lua require('neotex.util.sleep-inhibit').enable()" -c "quit"
  sleep 1
  ! systemd-inhibit --list | grep -q "Neovim" && echo "PASS: Lock cleaned up" || echo "FAIL: Lock persists"
  
  # Test which-key menu display
  nvim --headless -c "lua require('which-key').show('<leader>r')" -c "sleep 1" -c "quit" 2>&1 | grep -q "toggle sleep inhibitor" && echo "PASS: Menu entry exists" || echo "FAIL: Menu entry missing"
  
  # Test error handling (simulate systemd-inhibit failure)
  PATH=/tmp/empty:$PATH nvim --headless -c "lua require('neotex.util.sleep-inhibit').enable()" -c "quit" 2>&1 | grep -q "Failed to start" && echo "PASS: Error handled" || echo "FAIL: No error handling"
  ```
- **Success Criteria**: All integration tests pass, documentation updated

**Success Criteria**:
- [ ] Sleep inhibitor enables/disables correctly via `<leader>rz`
- [ ] Notifications appear for state changes
- [ ] systemd-inhibit lock appears in system when active
- [ ] Lock is automatically removed on Neovim exit
- [ ] Error handling works for edge cases
- [ ] Documentation updated in which-key.lua header
- [ ] All automated tests pass
- [ ] Commit created with proper message

**Rollback**: `git reset HEAD~1`

---

## Implementation Notes

### Key Design Decisions

1. **Module Location**: Placed in `neotex/util/` alongside other utility modules for consistency
2. **Keymap Location**: Added to `<leader>r` (run) group as `<leader>rz` for "sleep inhibit zone"
3. **Icon Choice**: Using "󰒲" (no-sleep/caffeine icon) for visual clarity
4. **Cleanup Strategy**: VimLeavePre autocmd ensures fail-safe cleanup on exit
5. **Error Handling**: All functions use vim.notify for user feedback

### Testing Strategy

All testing is automated and programmatic:
- Module loading tests verify Lua syntax and require() works
- Function tests verify enable/disable/toggle behavior
- Integration tests verify systemd-inhibit interaction
- Cleanup tests verify automatic lock release
- Error handling tests verify graceful degradation

### NixOS Integration

The implementation assumes systemd is available (standard on NixOS). No additional NixOS configuration is required since systemd-inhibit is part of the base systemd package.

### Future Enhancements

Potential improvements for future iterations:
- Status line integration to show inhibitor state
- Auto-enable on specific file types or project detection
- Configuration options for inhibit types (sleep, idle, etc.)
- Integration with project-specific .nvim.lua configs
