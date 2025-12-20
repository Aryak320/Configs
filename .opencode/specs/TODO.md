# TODO - NeoVim Configuration Projects

Track all configuration projects and their status.

---

## Not Started

<!-- New projects will be added here -->

---

## In Progress

---

## Completed

### Project 005: OpenCode Keybinding Customizations (Completed 2025-12-20)
**Path**: `specs/005_opencode_keybinding_customizations/`  
**Plan**: `plans/level_0_plan.md`  
**Goal**: Implement custom OpenCode keybindings with Ctrl+D leader and vim-like navigation  
**Phases**: 5/5 (Backup, Research, Implementation, Testing, Documentation)  
**Waves**: 3 (optimized for parallel execution)  
**Effort**: 4-6 hours  
**Priority**: Medium

**Key Features**:
- ✅ Leader key change: Ctrl+X → Ctrl+D
- ✅ Session navigation: `<leader>j/k` for child session cycling
- ✅ Message navigation: Alt+j/k for half-page, `<leader>h/l` for first/last
- ✅ Input changes: Remove Ctrl+J from newline, disable Ctrl+D delete
- ✅ Vim-like editing: All 5 phases implemented (navigation, word movement, deletion, visual, undo/redo)

**Commits**: 5 (9c8d166f, 2f36a8ad, 13a657a0, b0d31de4, 6071723c)

### Project 018: NixOS Sleep Inhibit Toggle in Neovim (Completed 2025-12-20)
**Path**: `/home/benjamin/.dotfiles/specs/plans/018_nixos_sleep_inhibit_toggle.md`  
**Plan**: `018_nixos_sleep_inhibit_toggle.md`  
**Goal**: Add sleep inhibitor toggle mapping under `<leader>rz` in which-key.lua  
**Phases**: 3/3 (Module Creation, Integration, Testing)  
**Waves**: 3 (sequential execution)  
**Effort**: 2-4 hours  
**Priority**: Medium

**Key Features**:
- ✅ Lua module for systemd sleep inhibitor management
- ✅ Toggle mapping under `<leader>rz` in which-key.lua
- ✅ Automatic cleanup on Neovim exit
- ✅ Error handling and user notifications

**Commits**: 3 (bba54ef4, e88ac24b, e8426113)

### Project 003: System Enhancement from ProofChecker Patterns (Completed 2025-12-16)
**Path**: `specs/003_system_enhancement_from_proofchecker/`  
**Plan**: `plans/implementation_v1.md`  
**Goal**: Enhance .config/.opencode system with patterns from ProofChecker  
**Phases**: 4/4 (Context, Meta-System, Project Structure, Workflow)  
**Effort**: 20-30 hours  
**Priority**: High

**Key Enhancements**:
- ✅ Context index and essential patterns (27 files mapped, 13 patterns)
- ✅ Meta-system for self-extensibility (4 commands, 3 agents)
- ✅ Project summaries (2 templates, SYSTEM_SUMMARY.md)
- ✅ Approval gates and quick-win detection (4 workflow commands)

**Commits**: 5 (41f835b6, 0c3b463b, 318bc417, 628c3b9d, and status updates)

---

## Usage

This file is automatically updated by the planner and implementer agents:
- **Planner**: Adds new projects to "Not Started" when creating plans
- **Implementer**: Moves projects from "Not Started" to "In Progress" when starting
- **Implementer**: Moves projects from "In Progress" to "Completed" when done

Manual updates are also acceptable.
