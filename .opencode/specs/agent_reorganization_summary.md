# Agent Reorganization - Executive Summary

## Quick Overview

This plan reorganizes the .opencode agent structure to improve clarity and discoverability.

### What Changes

**Before**:
- 1 primary agent (orchestrator)
- 19 subagents (all in flat `subagents/` directory)

**After**:
- 7 primary agents (orchestrator + 6 promoted workflow agents)
- 13 subagents (organized into 4 logical subdirectories)

### Why This Matters

1. **Clearer Hierarchy**: Primary agents handle main workflows, subagents handle specialized tasks
2. **Better Organization**: Subagents grouped by function (research, implementation, analysis, configuration)
3. **Improved Discoverability**: Easier to find the right agent for a task
4. **Consistent with Architecture**: Reflects actual usage patterns in the system

---

## Agents Being Promoted (6)

These agents orchestrate major workflows and should be primary:

| Agent | Role | Why Primary |
|-------|------|-------------|
| **researcher** | Research orchestrator | Coordinates parallel research subagents, creates OVERVIEW.md |
| **planner** | Implementation plan creator | Transforms research into phased implementation plans |
| **reviser** | Plan revision manager | Updates plans based on new requirements or blockers |
| **implementer** | Implementation executor | Executes plans in waves, coordinates implementation subagents |
| **tester** | Configuration tester | Validates implementations, runs health checks |
| **documenter** | Documentation generator | Creates and updates documentation |

---

## Subagent Organization (13 agents → 4 categories)

### Research Subagents (5)
*Invoked by researcher agent during research phases*

- **best-practices-researcher** - Community patterns & benchmarks
- **codebase-analyzer** - Scans NeoVim config for patterns
- **dependency-analyzer** - Maps plugin dependencies
- **docs-fetcher** - Fetches external documentation
- **refactor-finder** - Identifies improvement opportunities

### Implementation Subagents (2)
*Invoked by implementer agent during implementation phases*

- **code-generator** - Creates new Lua modules and configs
- **code-modifier** - Modifies existing configurations

### Analysis Subagents (3)
*Specialized analysis tools, can be invoked standalone*

- **cruft-finder** - Finds unused code and plugins
- **plugin-analyzer** - Deep plugin analysis
- **performance-profiler** - Startup time and performance analysis

### Configuration Subagents (3)
*Domain-specific configuration specialists*

- **health-checker** - Runs and interprets :checkhealth
- **keybinding-optimizer** - Manages keybinding organization
- **lsp-configurator** - LSP setup and optimization

---

## Implementation Phases

### Phase 1: Promote 6 Agents (45-60 min)
- Move agent files to `agent/` directory
- Update `mode: subagent` → `mode: primary`
- Update command references

### Phase 2: Organize Subagents (60-75 min)
- Create subdirectories
- Move agents to appropriate categories
- Update command references

### Phase 3: Update Documentation (60-90 min)
- Update ARCHITECTURE.md
- Update README.md
- Update BUILD_COMPLETE.md

### Phase 4: Validation (30-45 min)
- Verify file structure
- Check all references
- Test workflows
- Run validation script

**Total Time**: 3-4 hours

---

## Files Affected

- **Agent files**: 19 (6 moved, 13 reorganized)
- **Command files**: 9 (reference updates)
- **Documentation**: 3 (ARCHITECTURE.md, README.md, BUILD_COMPLETE.md)
- **Total**: ~30 files

---

## Reference Changes

### Primary Agent References

| Old Reference | New Reference |
|--------------|---------------|
| `@subagents/documenter` | `@documenter` |
| `@subagents/implementer` | `@implementer` |
| `@subagents/planner` | `@planner` |
| `@subagents/researcher` | `@researcher` |
| `@subagents/reviser` | `@reviser` |
| `@subagents/tester` | `@tester` |

### Subagent References (examples)

| Old Reference | New Reference |
|--------------|---------------|
| `@subagents/cruft-finder` | `@subagents/analysis/cruft-finder` |
| `@subagents/health-checker` | `@subagents/configuration/health-checker` |
| `@subagents/performance-profiler` | `@subagents/analysis/performance-profiler` |

---

## Risk Assessment

**Risk Level**: Low

**Why Low Risk**:
- No circular dependencies between agents
- Clean reference patterns
- Comprehensive testing plan
- Clear rollback procedure
- Well-defined agent boundaries

**Mitigation**:
- Thorough reference checking (grep-based)
- Validation script catches issues
- Test workflows before completion
- Rollback plan documented

---

## Next Steps

1. **Review this plan** - Ensure approach makes sense
2. **Execute phases sequentially** - Follow phase dependencies
3. **Run validation after each phase** - Catch issues early
4. **Test sample workflow** - Verify system still works
5. **Commit changes** - Document reorganization in git

---

## Questions to Consider

1. **Agent Discovery**: Does OpenCode have any hardcoded agent discovery that needs updating?
2. **External References**: Are there any external scripts or tools that reference agent paths?
3. **Caching**: Do we need to clear any cached agent references?
4. **README Files**: Should we add README.md to each subdirectory explaining its purpose?

---

## Success Metrics

- [ ] All 7 primary agents have `mode: primary`
- [ ] All 13 subagents organized into 4 subdirectories
- [ ] No old-style references remain
- [ ] All documentation updated
- [ ] Validation script passes 100%
- [ ] Sample workflow executes successfully
- [ ] Git commit created with clear message

---

## Full Plan

See `agent_reorganization_plan.md` for complete implementation details, testing procedures, and validation scripts.
