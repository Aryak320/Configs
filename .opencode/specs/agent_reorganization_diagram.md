# Agent Reorganization - Visual Structure

## Current Structure (Before)

```
.opencode/agent/
├── neovim-orchestrator.md (mode: primary)
└── subagents/
    ├── best-practices-researcher.md (mode: subagent)
    ├── code-generator.md (mode: subagent)
    ├── code-modifier.md (mode: subagent)
    ├── codebase-analyzer.md (mode: subagent)
    ├── cruft-finder.md (mode: subagent)
    ├── dependency-analyzer.md (mode: subagent)
    ├── docs-fetcher.md (mode: subagent)
    ├── documenter.md (mode: subagent) ← TO PROMOTE
    ├── health-checker.md (mode: subagent)
    ├── implementer.md (mode: subagent) ← TO PROMOTE
    ├── keybinding-optimizer.md (mode: subagent)
    ├── lsp-configurator.md (mode: subagent)
    ├── performance-profiler.md (mode: subagent)
    ├── planner.md (mode: subagent) ← TO PROMOTE
    ├── plugin-analyzer.md (mode: subagent)
    ├── refactor-finder.md (mode: subagent)
    ├── researcher.md (mode: subagent) ← TO PROMOTE
    ├── reviser.md (mode: subagent) ← TO PROMOTE
    └── tester.md (mode: subagent) ← TO PROMOTE

Total: 1 primary, 19 subagents (flat structure)
```

---

## Target Structure (After)

```
.opencode/agent/
├── neovim-orchestrator.md (mode: primary)
├── documenter.md (mode: primary) ← PROMOTED
├── implementer.md (mode: primary) ← PROMOTED
├── planner.md (mode: primary) ← PROMOTED
├── researcher.md (mode: primary) ← PROMOTED
├── reviser.md (mode: primary) ← PROMOTED
├── tester.md (mode: primary) ← PROMOTED
└── subagents/
    ├── research/
    │   ├── best-practices-researcher.md (mode: subagent)
    │   ├── codebase-analyzer.md (mode: subagent)
    │   ├── dependency-analyzer.md (mode: subagent)
    │   ├── docs-fetcher.md (mode: subagent)
    │   └── refactor-finder.md (mode: subagent)
    ├── implementation/
    │   ├── code-generator.md (mode: subagent)
    │   └── code-modifier.md (mode: subagent)
    ├── analysis/
    │   ├── cruft-finder.md (mode: subagent)
    │   ├── plugin-analyzer.md (mode: subagent)
    │   └── performance-profiler.md (mode: subagent)
    └── configuration/
        ├── health-checker.md (mode: subagent)
        ├── keybinding-optimizer.md (mode: subagent)
        └── lsp-configurator.md (mode: subagent)

Total: 7 primary, 13 subagents (organized into 4 categories)
```

---

## Agent Hierarchy and Invocation Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER REQUEST                             │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    ORCHESTRATOR (Primary)                        │
│                  neovim-orchestrator.md                          │
│                                                                   │
│  Routes requests to appropriate primary agents                   │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    PRIMARY AGENTS (6)                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │ researcher   │  │  planner     │  │  reviser     │          │
│  └──────┬───────┘  └──────────────┘  └──────────────┘          │
│         │                                                         │
│         ▼                                                         │
│  ┌─────────────────────────────────────────────────┐            │
│  │         Research Subagents (5)                  │            │
│  │  • best-practices-researcher                    │            │
│  │  • codebase-analyzer                            │            │
│  │  • dependency-analyzer                          │            │
│  │  • docs-fetcher                                 │            │
│  │  • refactor-finder                              │            │
│  └─────────────────────────────────────────────────┘            │
│                                                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │ implementer  │  │  tester      │  │ documenter   │          │
│  └──────┬───────┘  └──────────────┘  └──────────────┘          │
│         │                                                         │
│         ▼                                                         │
│  ┌─────────────────────────────────────────────────┐            │
│  │      Implementation Subagents (2)               │            │
│  │  • code-generator                               │            │
│  │  • code-modifier                                │            │
│  └─────────────────────────────────────────────────┘            │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│              STANDALONE SUBAGENTS (6)                            │
│         (Can be invoked directly via commands)                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  Analysis Subagents (3):                                         │
│  • cruft-finder (/remove-cruft)                                 │
│  • plugin-analyzer                                               │
│  • performance-profiler (/optimize-performance)                 │
│                                                                   │
│  Configuration Subagents (3):                                    │
│  • health-checker (/health-check)                               │
│  • keybinding-optimizer                                          │
│  • lsp-configurator                                              │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## Command → Agent Mapping

### Commands Invoking Primary Agents

| Command | Invokes | New Reference |
|---------|---------|---------------|
| `/research` | researcher | `@researcher` |
| `/plan` | planner | `@planner` |
| `/revise` | reviser | `@reviser` |
| `/implement` | implementer | `@implementer` |
| `/test` | tester | `@tester` |
| `/update-docs` | documenter | `@documenter` |

### Commands Invoking Subagents Directly

| Command | Invokes | New Reference |
|---------|---------|---------------|
| `/remove-cruft` | cruft-finder | `@subagents/analysis/cruft-finder` |
| `/optimize-performance` | performance-profiler | `@subagents/analysis/performance-profiler` |
| `/health-check` | health-checker | `@subagents/configuration/health-checker` |

---

## Workflow Example: Research → Plan → Implement

```
1. User: /research "Optimize lazy.nvim loading"
   ↓
2. Orchestrator → @researcher (primary)
   ↓
3. Researcher → Parallel invocation:
   ├─ @subagents/research/codebase-analyzer
   ├─ @subagents/research/docs-fetcher
   ├─ @subagents/research/best-practices-researcher
   └─ @subagents/research/dependency-analyzer
   ↓
4. Researcher ← Brief summaries + report paths
   ↓
5. Researcher → Creates OVERVIEW.md
   ↓
6. User ← OVERVIEW.md path

---

7. User: /plan .opencode/specs/001_lazy_loading/reports/OVERVIEW.md
   ↓
8. Orchestrator → @planner (primary)
   ↓
9. Planner → Reads OVERVIEW.md + linked reports
   ↓
10. Planner → Creates implementation_v1.md
   ↓
11. User ← Plan path

---

12. User: /implement .opencode/specs/001_lazy_loading/plans/implementation_v1.md
    ↓
13. Orchestrator → @implementer (primary)
    ↓
14. Implementer → For each phase:
    ├─ @subagents/implementation/code-generator (if new files)
    ├─ @subagents/implementation/code-modifier (if modifications)
    └─ @tester (validation)
    ↓
15. Implementer → Commits each phase
    ↓
16. User ← Completion summary
```

---

## Directory Size Comparison

### Before
```
agent/
├── 1 file (neovim-orchestrator.md)
└── subagents/
    └── 19 files (all agents)
```

### After
```
agent/
├── 7 files (orchestrator + 6 primary agents)
└── subagents/
    ├── research/ (5 files)
    ├── implementation/ (2 files)
    ├── analysis/ (3 files)
    └── configuration/ (3 files)
```

**Benefits**:
- Primary agents clearly separated from subagents
- Subagents organized by function
- Easier to find the right agent for a task
- Reflects actual usage patterns
