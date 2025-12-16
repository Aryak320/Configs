# Quick Start Guide

**Project**: Global Delegation Optimization  
**Total Effort**: 16 hours  
**Phases**: 10 phases

---

## Step-by-Step Instructions

### 1. Read the Overview

Start here: [OVERVIEW.md](OVERVIEW.md)

This gives you the complete picture of all phases and dependencies.

### 2. Create Backups (REQUIRED FIRST)

**Phase**: [phase-10-migration.md](phase-10-migration.md)  
**Time**: 1 hour  
**Priority**: CRITICAL

```bash
# Follow phase-10-migration.md to:
# - Create backup directories
# - Backup all 7 agents
# - Backup all 6 commands
# - Backup 2 documentation files
# - Create manifest and migration guide
```

**DO NOT SKIP THIS STEP**

### 3. Start with Researcher (Recommended)

**Phase**: [phase-01-researcher.md](phase-01-researcher.md)  
**Time**: 2 hours  
**Priority**: High

This validates the approach and establishes the pattern for remaining phases.

### 4. Continue with Remaining Phases

Follow the recommended order in OVERVIEW.md:

1. ✅ Phase 10 (Backups) - **DONE**
2. ✅ Phase 1 (Researcher) - **DONE**
3. Phase 2 (Implementer) - 3 hours
4. Phase 3 (Reviser) - 1.5 hours
5. Phase 4 (Tester) - 1 hour
6. Phase 5 (Documenter) - 0.5 hours
7. Phase 6 (Planner) - 0.5 hours
8. Phase 7 (Orchestrator) - 0.5 hours
9. Phase 8 (Documentation) - 2 hours
10. Phase 9 (Testing) - 3 hours

---

## Phase Workflow

For each phase:

1. **Open phase file** (e.g., `phase-01-researcher.md`)
2. **Read overview** and prerequisites
3. **Follow steps** in order
4. **Check validations** after each step
5. **Test changes** (if applicable)
6. **Create commit** with message from phase file
7. **Update OVERVIEW.md** (mark phase complete)
8. **Move to next phase**

---

## Tracking Progress

Update the status tables in OVERVIEW.md as you complete phases:

- `Not Started` → `In Progress` → `Complete` → `Tested`

---

## If Something Goes Wrong

1. **Check phase file** for troubleshooting section
2. **Review rollback procedure** in phase file
3. **Restore from backups** (created in Phase 10)
4. **Fix issues** and retry

---

## Getting Help

- **Full details**: `../global-delegation-optimization-plan-v2.md`
- **Research findings**: `../opencode_command_usage_research.md`
- **Summary**: `../DELEGATION_OPTIMIZATION_SUMMARY.md`

---

## Success Criteria

After all phases complete:

✅ All agents have critical instructions  
✅ All workflows show explicit task() syntax  
✅ All commands explain delegation behavior  
✅ Documentation is comprehensive  
✅ Tests validate delegation patterns  
✅ No breaking changes to user workflows

---

## Estimated Timeline

- **Week 1**: Phases 1-5 (Core agents) - 8 hours
- **Week 2**: Phases 6-8, 10 (Supporting) - 4 hours
- **Week 3**: Phase 9 (Testing) - 3 hours

**Total**: 16 hours over 3 weeks

---

**Ready to start?** → Begin with [phase-10-migration.md](phase-10-migration.md)
