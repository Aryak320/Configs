# Phase 10: Migration and Backups

**Effort**: 1 hour  
**Priority**: High (MUST DO FIRST)  
**Status**: Not Started  
**Dependencies**: None - This is the first phase

---

## Overview

Create comprehensive backups of all files that will be modified, and prepare migration infrastructure.

**Critical**: This phase MUST be completed before any other phase.

---

## Step 1: Create Backup Directory (5 min)

### Action

Create backup directory structure:

```bash
mkdir -p /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent
mkdir -p /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command
mkdir -p /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs
```

### Validation
- [ ] Directories created successfully
- [ ] Paths are correct

---

## Step 2: Backup All Agents (15 min)

### Action

Backup all agent files:

```bash
# Backup primary agents
cp /home/benjamin/.config/.opencode/agent/researcher.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/

cp /home/benjamin/.config/.opencode/agent/implementer.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/

cp /home/benjamin/.config/.opencode/agent/reviser.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/

cp /home/benjamin/.config/.opencode/agent/tester.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/

cp /home/benjamin/.config/.opencode/agent/documenter.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/

cp /home/benjamin/.config/.opencode/agent/planner.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/

cp /home/benjamin/.config/.opencode/agent/orchestrator.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/
```

### Validation
- [ ] All 7 agent files backed up
- [ ] File sizes match originals
- [ ] Backup files are readable

---

## Step 3: Backup All Commands (15 min)

### Action

Backup all command files:

```bash
# Backup workflow commands
cp /home/benjamin/.config/.opencode/command/research.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/

cp /home/benjamin/.config/.opencode/command/implement.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/

cp /home/benjamin/.config/.opencode/command/revise.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/

cp /home/benjamin/.config/.opencode/command/test.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/

cp /home/benjamin/.config/.opencode/command/update-docs.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/

cp /home/benjamin/.config/.opencode/command/plan.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/
```

### Validation
- [ ] All 6 command files backed up
- [ ] File sizes match originals
- [ ] Backup files are readable

---

## Step 4: Backup Documentation (10 min)

### Action

Backup documentation files:

```bash
# Backup system documentation
cp /home/benjamin/.config/.opencode/ARCHITECTURE.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs/

cp /home/benjamin/.config/.opencode/README.md \
   /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs/
```

### Validation
- [ ] ARCHITECTURE.md backed up
- [ ] README.md backed up
- [ ] File sizes match originals

---

## Step 5: Create Backup Manifest (10 min)

### Action

Create a manifest file documenting all backups:

```bash
cat > /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/MANIFEST.md << 'EOF'
# Backup Manifest

**Date**: $(date +%Y-%m-%d)
**Purpose**: Pre-delegation optimization backups
**Project**: Global delegation optimization v2.0

## Backed Up Files

### Agents (7 files)
- researcher.md
- implementer.md
- reviser.md
- tester.md
- documenter.md
- planner.md
- orchestrator.md

### Commands (6 files)
- research.md
- implement.md
- revise.md
- test.md
- update-docs.md
- plan.md

### Documentation (2 files)
- ARCHITECTURE.md
- README.md

## Restoration

To restore all files:

\`\`\`bash
# Restore agents
cp -r /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/* \
      /home/benjamin/.config/.opencode/agent/

# Restore commands
cp -r /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/* \
      /home/benjamin/.config/.opencode/command/

# Restore documentation
cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs/ARCHITECTURE.md \
   /home/benjamin/.config/.opencode/

cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs/README.md \
   /home/benjamin/.config/.opencode/
\`\`\`

## Verification

\`\`\`bash
# Count backed up files
find /home/benjamin/.config/.opencode/backups/pre-delegation-optimization -type f | wc -l
# Should be 16 files (7 agents + 6 commands + 2 docs + 1 manifest)
\`\`\`
EOF
```

### Validation
- [ ] Manifest created
- [ ] Manifest is readable
- [ ] Restoration commands are correct

---

## Step 6: Verify Backups (10 min)

### Action

Verify all backups are complete and valid:

```bash
# Count files
echo "Agents backed up:"
ls -1 /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/ | wc -l
# Should be 7

echo "Commands backed up:"
ls -1 /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command/ | wc -l
# Should be 6

echo "Docs backed up:"
ls -1 /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs/ | wc -l
# Should be 2

# Verify file integrity (compare sizes)
echo "Verifying file sizes..."
for file in researcher implementer reviser tester documenter planner orchestrator; do
  original="/home/benjamin/.config/.opencode/agent/${file}.md"
  backup="/home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent/${file}.md"
  
  if [ -f "$original" ] && [ -f "$backup" ]; then
    orig_size=$(wc -c < "$original")
    back_size=$(wc -c < "$backup")
    
    if [ "$orig_size" -eq "$back_size" ]; then
      echo "✓ ${file}.md: OK"
    else
      echo "✗ ${file}.md: SIZE MISMATCH"
    fi
  else
    echo "✗ ${file}.md: FILE MISSING"
  fi
done
```

### Validation
- [ ] All file counts correct (7 agents, 6 commands, 2 docs)
- [ ] All file sizes match originals
- [ ] No errors reported

---

## Step 7: Create Migration Guide (10 min)

### Action

Create comprehensive migration guide:

```bash
cat > /home/benjamin/.config/.opencode/MIGRATION_GUIDE.md << 'EOF'
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

\`\`\`bash
/research "topic"
/plan overview.md
/implement plan.md
\`\`\`

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

\`\`\`bash
# Restore from backups
cp -r /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/agent \
      /home/benjamin/.config/.opencode/

cp -r /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/command \
      /home/benjamin/.config/.opencode/

cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs/ARCHITECTURE.md \
   /home/benjamin/.config/.opencode/

cp /home/benjamin/.config/.opencode/backups/pre-delegation-optimization/docs/README.md \
   /home/benjamin/.config/.opencode/
\`\`\`

## Verification

### Check Delegation Patterns

\`\`\`bash
# Verify task tool usage in agents
grep -r "task(" .opencode/agent/*.md | wc -l
# Should be > 0 for coordinator agents

# Verify critical instructions sections
grep -r "critical_instructions" .opencode/agent/*.md | wc -l
# Should be 5 (one per coordinator agent)
\`\`\`

### Test Commands

\`\`\`bash
# Test research command
/research "test delegation pattern"

# Verify researcher uses task tool (check logs)
grep "task(" .opencode/logs/session_*.log
\`\`\`

## Support

- **Full plan**: .opencode/specs/global-delegation-optimization-plan-v2.md
- **Research**: .opencode/specs/opencode_command_usage_research.md
- **Phase plans**: .opencode/specs/delegation-optimization/

---

**Last Updated**: 2025-12-15
EOF
```

### Validation
- [ ] Migration guide created
- [ ] Guide is comprehensive
- [ ] Rollback procedure documented

---

## Commit

### Message
```
chore(backups): create pre-delegation optimization backups

- Backup all 7 agent files
- Backup all 6 command files
- Backup 2 documentation files
- Create backup manifest
- Create migration guide

Phase 10 of 10: Backups and migration preparation
MUST BE COMPLETED FIRST before any other phases
```

### Files to Commit
- `.opencode/backups/pre-delegation-optimization/` (entire directory)
- `.opencode/MIGRATION_GUIDE.md`

---

## Rollback

Not applicable - this phase creates the backups used for rollback.

---

## Checklist

- [ ] Step 1: Backup directory created
- [ ] Step 2: All agents backed up (7 files)
- [ ] Step 3: All commands backed up (6 files)
- [ ] Step 4: Documentation backed up (2 files)
- [ ] Step 5: Backup manifest created
- [ ] Step 6: Backups verified (file counts and sizes)
- [ ] Step 7: Migration guide created
- [ ] Git commit created
- [ ] Phase marked complete in OVERVIEW.md

---

## Next Phase

After completing this phase, proceed to:
- **Phase 1**: Researcher Agent Updates (2 hours)

---

**Status**: Not Started  
**Last Updated**: 2025-12-15  
**CRITICAL**: This phase MUST be completed before any other phase
