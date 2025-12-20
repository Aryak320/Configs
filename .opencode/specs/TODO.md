# TODO - NeoVim Configuration Projects

Track all configuration projects and their status.

---

## Not Started

### Project 005: OpenCode Keybinding Customizations
**Path**: `specs/005_opencode_keybinding_customizations/`  
**Plan**: `plans/level_0_plan.md`  
**Goal**: Implement custom OpenCode keybindings with Ctrl+D leader and vim-like navigation  
**Phases**: 5 (Backup, Research, Implementation, Testing, Documentation)  
**Waves**: 3 (optimized for parallel execution)  
**Effort**: 4-6 hours  
**Priority**: Medium

**Key Features**:
- Leader key change: Ctrl+X → Ctrl+D
- Session navigation: `<leader>j/k` for child session cycling
- Message navigation: Alt+j/k for half-page, `<leader>h/l` for first/last
- Input changes: Remove Ctrl+J from newline, disable Ctrl+D delete
- Vim-like editing enhancements (based on OpenCode capabilities)

**Research**: [opencode_keybinds_research.md](opencode_keybinds_research.md)

<!-- New projects will be added here -->

---

## In Progress

<!-- Projects currently being implemented -->

---

## Completed

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
