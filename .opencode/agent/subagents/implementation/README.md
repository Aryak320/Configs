# Implementation Subagents

Code generation and modification specialists invoked by the implementer primary agent during implementation phases.

---

## Purpose

These agents create or modify code during implementation phases. They share common characteristics:
- Write/edit permissions
- Code generation/modification
- Standards compliance (STANDARDS.md)
- Brief summary returns

---

## Agents

### code-generator.md
**Purpose**: Creates new Lua modules, plugin configurations, and NeoVim code

**Responsibilities**:
- Generate new Lua modules
- Create plugin specifications
- Set up LSP configurations
- Generate keybindings
- Follow STANDARDS.md strictly

**Returns**: Brief summary + created file paths

---

### code-modifier.md
**Purpose**: Modifies existing configurations and refactors code

**Responsibilities**:
- Modify existing Lua modules
- Refactor code structure
- Migrate deprecated APIs
- Apply improvements
- Maintain standards compliance

**Returns**: Brief summary + modified file paths

---

## Invocation

Implementation subagents are invoked by the implementer primary agent (`agent/implementer.md`) during implementation phases. They are never invoked directly by commands.

**Example workflow**:
```
User → /implement plan_path
  ↓
Orchestrator → @implementer
  ↓
Implementer → For each phase:
  ├─ @subagents/implementation/code-generator (if new files)
  ├─ @subagents/implementation/code-modifier (if modifications)
  └─ @tester (validation)
  ↓
Implementer → Commits each phase
```

---

## Standards Compliance

All code generated or modified by implementation subagents must follow:
- `/home/benjamin/.config/STANDARDS.md` - Global coding standards
- Naming conventions (snake_case for Lua)
- Module patterns (local M = {})
- Documentation (LuaDoc comments)
- Error handling (pcall, validation)

---

## Context Reduction

Implementation subagents enable context reduction through:
- Brief summary returns (1-2 paragraphs)
- File path passing (not full content)
- Focused scope (single phase at a time)
- Clear success/failure status
