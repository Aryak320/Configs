# Delegation Optimization Migration Guide

**Version**: 2.0  
**Date**: 2025-12-15  
**Status**: Ready for Implementation

---

## Overview

This guide documents the migration process for the global delegation optimization project.

## Changes Made

### Agent Updates (7 agents)

**Coordinator Agents** (5):
- researcher.md - Added critical instructions + task() examples
- implementer.md - Added critical instructions + task() examples
- reviser.md - Added conditional delegation pattern
- tester.md - Added critical instructions + task() examples
- documenter.md - Added critical instructions + task() examples

**Specialist Agent** (1):
- planner.md - Added note explaining no delegation

**Orchestrator** (1):
- orchestrator.md - Added delegation architecture overview

### Command Updates (6 commands)

- research.md - Added delegation behavior section
- implement.md - Added delegation behavior section
- revise.md - Added delegation behavior section
- test.md - Added delegation behavior section
- update-docs.md - Added delegation behavior section
- plan.md - Added note explaining no delegation

### Documentation Updates (3 files)

- ARCHITECTURE.md - Added delegation patterns section
- README.md - Added delegation overview
- DELEGATION_BEST_PRACTICES.md - New file (best practices guide)

## User Impact

### No Breaking Changes

All changes are **backward compatible**:
- Command syntax unchanged
- Command behavior unchanged
- Output format unchanged
- Workflow unchanged

### What Changed (Internal)

- Agents now have explicit delegation instructions
- Task tool usage is enforced
- Context window efficiency improved
- Delegation patterns documented

## For Users

**No action required**. Commands work exactly as before:

```bash
/research "topic"
/plan overview.md
/implement plan.md
```

## For Developers

### Creating New Agents

Use templates from DELEGATION_BEST_PRACTICES.md:
- Coordinator pattern (delegates to subagents)
- Specialist pattern (no delegation)
- Conditional delegation pattern (sometimes delegates)

### Modifying Existing Agents

1. Check if agent is coordinator or specialist
2. If coordinator: Ensure task tool usage is explicit
3. If specialist: Add note explaining why no delegation
4. Update workflows with task() examples

## Rollback Procedure

If issues arise:

```bash
# Restore from backups
cp -r /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/* \
      /home/benjamin/.config/.opencode/agent/

cp -r /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/* \
      /home/benjamin/.config/.opencode/command/

cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs/ARCHITECTURE.md \
   /home/benjamin/.config/.opencode/

cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs/README.md \
   /home/benjamin/.config/.opencode/
```

## Verification

### Check Delegation Patterns

```bash
# Verify task tool usage in agents
grep -r "task(" .opencode/agent/*.md | wc -l
# Should be > 0 for coordinator agents

# Verify critical instructions sections
grep -r "critical_instructions" .opencode/agent/*.md | wc -l
# Should be 5 (one per coordinator agent)
```

### Test Commands

```bash
# Test research command
/research "test delegation pattern"

# Verify researcher uses task tool (check logs)
grep "task(" .opencode/logs/session_*.log
```

## Support

- **Full plan**: .opencode/specs/global-delegation-optimization-plan-v2.md
- **Research**: .opencode/specs/opencode_command_usage_research.md
- **Phase plans**: .opencode/specs/delegation-optimization/

---

**Last Updated**: 2025-12-15
