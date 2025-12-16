# NeoVim Configuration Management System

Research-driven development system for NeoVim configuration using OpenCode agents.

---

## Overview

This system provides a structured, agent-based approach to managing your NeoVim configuration through:
- **Research-first methodology**: Investigate before implementing
- **Automated workflows**: Agents handle heavy lifting
- **Context isolation**: Minimal token usage through delegation
- **Parallel execution**: Fast, efficient operations
- **Git integration**: Automatic versioning and history

---

## Delegation Architecture

The system uses a **delegation-first architecture** with two types of agents:

### Coordinator Agents (95% Context Reduction)

Coordinator agents delegate ALL work to specialist subagents and receive only brief summaries:

- **Researcher** → research subagents (codebase analysis, docs fetching, best practices)
- **Implementer** → implementation subagents (code generation, modification, testing, documentation)
- **Tester** → test subagents (health checks, plugin tests, LSP validation)
- **Documenter** → documentation subagents (module docs, examples, guides, READMEs)

**Benefits**:
- 95% context reduction (see ~500 tokens instead of ~10,000)
- 40-60% time savings through parallel execution
- Higher quality through specialist expertise

### Specialist Agents (Direct Execution)

Specialist agents execute work directly without delegation:

- **Planner** → creates implementation plans (plan creation IS its specialty)
- **Orchestrator** → routes requests to primary agents

### Conditional Coordinators

- **Reviser** → delegates only when new research is needed

**See**: [DELEGATION_BEST_PRACTICES.md](DELEGATION_BEST_PRACTICES.md) for complete guide

---

## Quick Start

1. **Research** a topic:
   ```
   /research "Optimize lazy.nvim plugin loading for faster startup"
   ```

2. **Plan** implementation from research:
   ```
   /plan .opencode/specs/001_lazy_loading_optimization/reports/OVERVIEW.md
   ```

3. **Implement** the plan:
   ```
   /implement .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md
   ```

4. **Revise** if needed:
   ```
   /revise .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md "Add performance benchmarking"
   ```

---

## Architecture

### Main Components

1. **Orchestrator** (`agent/neovim-orchestrator.md`)
   - Routes requests to primary agents
   - Minimal context, pure delegation

2. **Primary Agents** (`agent/`)
   - **Researcher**: Conducts multi-faceted research
   - **Planner**: Creates implementation plans
   - **Reviser**: Updates plans with new requirements
   - **Implementer**: Executes plans with testing
   - **Tester**: Validates implementations and runs health checks
   - **Documenter**: Creates and updates documentation

3. **Research Subagents** (`agent/subagents/research/`)
   - codebase-analyzer
   - docs-fetcher
   - best-practices-researcher
   - dependency-analyzer
   - refactor-finder

4. **Implementation Subagents** (`agent/subagents/implementation/`)
   - code-generator
   - code-modifier

5. **Analysis Subagents** (`agent/subagents/analysis/`)
   - cruft-finder
   - plugin-analyzer
   - performance-profiler

6. **Configuration Subagents** (`agent/subagents/configuration/`)
   - health-checker
   - keybinding-optimizer
   - lsp-configurator

---

## Directory Structure

```
.opencode/
  agent/                    # Agent definitions
    neovim-orchestrator.md  # Main orchestrator
    documenter.md           # Documentation agent
    implementer.md          # Implementation agent
    planner.md              # Planning agent
    researcher.md           # Research agent
    reviser.md              # Revision agent
    tester.md               # Testing agent
    subagents/              # Specialized subagents
      research/             # Research specialists
      implementation/       # Code generation/modification
      analysis/             # Analysis tools
      configuration/        # Configuration specialists
  context/                  # Context files for agents
    domain/                 # Domain knowledge
    processes/              # Workflow definitions
    standards/              # Coding standards
    templates/              # File templates
  workflows/                # Workflow definitions
  command/                  # Command definitions
  specs/                    # Project specifications
    TODO.md                 # Project tracking
    NNN_project_name/       # Individual projects
      reports/              # Research reports
      plans/                # Implementation plans
      state.json            # Project state
    archive/                # Archived projects
  state/                    # System state
    global.json             # Global state tracking
  logs/                     # System logs
  cache/                    # Cached resources
    docs/                   # Documentation cache
```

---

## Commands

- `/research "<topic>"` - Research a topic
- `/plan <overview-path> ["prompt"]` - Create implementation plan
- `/revise <plan-path> "<changes>"` - Revise existing plan
- `/implement <plan-path>` - Execute implementation plan
- `/todo` - Show project status
- `/health-check` - Run :checkhealth and report
- `/optimize-performance` - Analyze and improve performance
- `/remove-cruft` - Find and remove unused code
- `/test` - Run configuration tests
- `/update-docs` - Update documentation
- `/empty-archive` - Clean up archived projects
- `/help` - Show help information

---

## Workflows

### Research → Plan → Implement

The standard workflow for new features or improvements:

1. **Research**: Investigate the topic thoroughly
2. **Plan**: Create phased implementation plan
3. **Implement**: Execute plan with automated testing
4. (Optional) **Revise**: Update plan if requirements change

### Quick Optimization

For performance improvements and cleanup:

1. `/optimize-performance` - Get optimization recommendations
2. `/plan` based on recommendations
3. `/implement` the optimizations
4. `/test` to verify improvements

### Health Maintenance

Regular health checks and cleanup:

1. `/health-check` - Identify issues
2. `/remove-cruft` - Find unused code
3. Create plans to fix issues
4. Implement fixes

---

## Key Features

### Context Isolation

- Primary agents delegate to subagents
- Subagents return brief summaries + file paths
- Primary agents never read full artifacts
- 95%+ context reduction through metadata passing

### Parallel Execution

- Research: Up to 5 concurrent subagents
- Implementation: Parallel phases within waves
- Fast, efficient operations

### Git Integration

- Automatic commits after each phase
- Conventional commit format
- Complete project history
- Easy rollback if needed

### State Management

- Global state tracking
- Per-project state
- TODO.md for project status
- Comprehensive logging

---

## Standards Compliance

All code follows `/home/benjamin/.config/STANDARDS.md`:
- Naming conventions (snake_case)
- Module patterns (local M = {})
- Documentation (LuaDoc comments)
- Error handling (pcall, validation)
- Keybinding organization (which-key.lua vs keymaps.lua)

---

## Integration Points

- **NeoVim Config**: `/home/benjamin/.config/nvim/`
- **Standards**: `/home/benjamin/.config/STANDARDS.md`
- **Dotfiles**: `~/.dotfiles/` (NixOS configuration)
- **Git**: Automatic commits, worktree support
- **External Tools**: lazy.nvim, Mason, LSP servers, etc.

---

## Support

- **Architecture**: See `ARCHITECTURE.md`
- **Quick Start**: See `QUICK_START.md`
- **Troubleshooting**: Check `logs/errors.log`
- **Documentation**: See `context/` directory

---

## Version

System Version: 1.0.0
Created: 2025-12-15
