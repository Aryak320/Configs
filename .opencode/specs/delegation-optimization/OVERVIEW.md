# Global Delegation Optimization - Implementation Overview

**Project**: System-wide delegation enforcement and context window efficiency  
**Status**: Ready for Implementation  
**Total Effort**: 16 hours  
**Phases**: 10 phases across 3 weeks

---

## Quick Navigation

- **Phase Plans**: See individual phase files in this directory
- **Full Plan**: `../global-delegation-optimization-plan-v2.md`
- **Research**: `../opencode_command_usage_research.md`
- **Summary**: `../DELEGATION_OPTIMIZATION_SUMMARY.md`

---

## Phase Structure

### Week 1: Core Agents (8 hours)

| Phase | File | Agent/Command | Effort | Priority | Status |
|-------|------|---------------|--------|----------|--------|
| 1 | [phase-01-researcher.md](phase-01-researcher.md) | researcher.md + /research | 2h | High | Not Started |
| 2 | [phase-02-implementer.md](phase-02-implementer.md) | implementer.md + /implement | 3h | Critical | Not Started |
| 3 | [phase-03-reviser.md](phase-03-reviser.md) | reviser.md + /revise | 1.5h | High | Not Started |
| 4 | [phase-04-tester.md](phase-04-tester.md) | tester.md + /test | 1h | Medium | Not Started |
| 5 | [phase-05-documenter.md](phase-05-documenter.md) | documenter.md + /update-docs | 0.5h | Medium | Not Started |

### Week 2: Supporting Updates (4 hours)

| Phase | File | Component | Effort | Priority | Status |
|-------|------|-----------|--------|----------|--------|
| 6 | [phase-06-planner.md](phase-06-planner.md) | planner.md + /plan | 0.5h | Low | Not Started |
| 7 | [phase-07-orchestrator.md](phase-07-orchestrator.md) | orchestrator.md | 0.5h | Low | Not Started |
| 8 | [phase-08-documentation.md](phase-08-documentation.md) | ARCHITECTURE.md, README.md, guides | 2h | Medium | Not Started |
| 10 | [phase-10-migration.md](phase-10-migration.md) | Backups, migration guide | 1h | High | Not Started |

### Week 3: Testing and Validation (4 hours)

| Phase | File | Test Suite | Effort | Priority | Status |
|-------|------|------------|--------|----------|--------|
| 9 | [phase-09-testing.md](phase-09-testing.md) | All test suites + validation | 3h | High | Not Started |

---

## Dependencies

```
Phase 10 (Backups) → Must complete FIRST
  ↓
Phase 1 (Researcher) → Independent
Phase 2 (Implementer) → Independent
Phase 3 (Reviser) → Independent
Phase 4 (Tester) → Independent
Phase 5 (Documenter) → Independent
Phase 6 (Planner) → Independent
Phase 7 (Orchestrator) → Independent
  ↓
Phase 8 (Documentation) → Depends on Phases 1-7
  ↓
Phase 9 (Testing) → Depends on Phases 1-8
```

**Recommended Order**:
1. Phase 10 (Backups) - **MUST DO FIRST**
2. Phase 1 (Researcher) - High priority, validates approach
3. Phase 2 (Implementer) - Critical, most complex
4. Phases 3-7 (Remaining agents) - Can be done in any order
5. Phase 8 (Documentation) - After all agents updated
6. Phase 9 (Testing) - Final validation

---

## Success Criteria

### Per-Phase Criteria

Each phase must meet:
- ✅ All files modified as specified
- ✅ Critical instructions sections added (where applicable)
- ✅ Explicit task() examples in workflows
- ✅ Delegation behavior sections in commands
- ✅ Git commit created with descriptive message
- ✅ No breaking changes to existing functionality

### Overall Success Metrics

**Primary**:
- 100% delegation rate (all work via task tool)
- 95%+ context reduction (coordinators <5,000 tokens)
- 4x+ parallel speedup (5 concurrent tasks)
- Graceful error handling (no crashes)

**Secondary**:
- No code quality regression
- No user workflow changes (backward compatible)
- Complete documentation

---

## Implementation Workflow

### For Each Phase

1. **Read phase plan** (`phase-XX-name.md`)
2. **Review checklist** in phase plan
3. **Execute steps** in order
4. **Test changes** (if applicable)
5. **Commit** with message from phase plan
6. **Update this OVERVIEW** (mark phase complete)
7. **Move to next phase**

### Tracking Progress

Update the status column in the tables above:
- `Not Started` → `In Progress` → `Complete` → `Tested`

### Rollback

If issues arise in any phase:
1. Check phase plan for rollback procedure
2. Restore from backups (created in Phase 10)
3. Review and fix issues
4. Retry phase

---

## Quick Start

### Step 1: Create Backups (Phase 10 First!)

```bash
# Execute Phase 10 first to create backups
# See phase-10-migration.md for details
```

### Step 2: Start with Researcher (Phase 1)

```bash
# Execute Phase 1 to validate approach
# See phase-01-researcher.md for details
```

### Step 3: Continue with Remaining Phases

Follow the recommended order above.

---

## Files Modified by This Project

### Agents (7 files)
- `.opencode/agent/researcher.md`
- `.opencode/agent/implementer.md`
- `.opencode/agent/reviser.md`
- `.opencode/agent/tester.md`
- `.opencode/agent/documenter.md`
- `.opencode/agent/planner.md`
- `.opencode/agent/orchestrator.md`

### Commands (6 files)
- `.opencode/command/research.md`
- `.opencode/command/implement.md`
- `.opencode/command/revise.md`
- `.opencode/command/test.md`
- `.opencode/command/update-docs.md`
- `.opencode/command/plan.md`

### Documentation (5 files)
- `.opencode/ARCHITECTURE.md` (updated)
- `.opencode/README.md` (updated)
- `.opencode/DELEGATION_BEST_PRACTICES.md` (new)
- `.opencode/MIGRATION_GUIDE.md` (new)
- `.opencode/specs/delegation-optimization/OVERVIEW.md` (this file)

### Testing (4 files - new)
- `.opencode/tests/delegation/test_researcher_delegation.sh`
- `.opencode/tests/delegation/test_implementer_delegation.sh`
- `.opencode/tests/delegation/test_reviser_delegation.sh`
- `.opencode/tests/delegation/test_context_efficiency.sh`

### Validation Scripts (3 files - new)
- `.opencode/scripts/check-task-tool-usage.sh`
- `.opencode/scripts/measure-context-window.sh`
- `.opencode/scripts/verify-parallel-execution.sh`

**Total**: 25 files (18 modified, 7 new)

---

## Support

### Questions?

- **Full details**: See `../global-delegation-optimization-plan-v2.md`
- **Research findings**: See `../opencode_command_usage_research.md`
- **Quick summary**: See `../DELEGATION_OPTIMIZATION_SUMMARY.md`

### Issues?

- Check phase plan for troubleshooting
- Review rollback procedure
- Consult full plan for detailed context

---

**Last Updated**: 2025-12-15  
**Version**: 1.0  
**Status**: Ready for Implementation
