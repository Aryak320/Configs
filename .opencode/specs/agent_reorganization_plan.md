# Agent Reorganization Implementation Plan

**Date**: 2025-12-15
**Feature**: Reorganize .opencode agent hierarchy - promote 6 agents to primary and organize remaining subagents into logical subdirectories
**Status**: [NOT STARTED]
**Estimated Hours**: 3-4 hours
**Standards File**: /home/benjamin/.config/STANDARDS.md
**Research Reports**: Comprehensive exploration completed (see research analysis above)

---

## Overview

This plan reorganizes the .opencode agent structure to:
1. Promote 6 core workflow agents (documenter, implementer, planner, researcher, reviser, tester) from subagent to primary status
2. Organize 13 remaining subagents into 4 logical subdirectories (research/, implementation/, analysis/, configuration/)
3. Update all references across commands, documentation, and agent files

**Current Structure**:
```
agent/
  neovim-orchestrator.md (primary)
  subagents/
    [19 agents, all mode: subagent]
```

**Target Structure**:
```
agent/
  neovim-orchestrator.md (primary)
  documenter.md (primary)
  implementer.md (primary)
  planner.md (primary)
  researcher.md (primary)
  reviser.md (primary)
  tester.md (primary)
  subagents/
    research/
      best-practices-researcher.md
      codebase-analyzer.md
      dependency-analyzer.md
      docs-fetcher.md
      refactor-finder.md
    implementation/
      code-generator.md
      code-modifier.md
    analysis/
      cruft-finder.md
      plugin-analyzer.md
      performance-profiler.md
    configuration/
      health-checker.md
      keybinding-optimizer.md
      lsp-configurator.md
```

---

## Dependencies

- **Wave 1**: Phases 1-2 can run in parallel (independent file operations)
- **Wave 2**: Phase 3 depends on completion of Phases 1-2 (documentation references new structure)
- **Wave 3**: Phase 4 (validation) depends on all previous phases

---

## Phase 1: Promote 6 Agents to Primary Status

**Status**: [NOT STARTED]
**Estimated Time**: 45-60 minutes
**Wave**: 1
**Dependencies**: None

### Tasks

1. **Move agent files** from `agent/subagents/` to `agent/`:
   ```bash
   cd /home/benjamin/.config/.opencode/agent
   mv subagents/documenter.md .
   mv subagents/implementer.md .
   mv subagents/planner.md .
   mv subagents/researcher.md .
   mv subagents/reviser.md .
   mv subagents/tester.md .
   ```

2. **Update agent frontmatter** (6 files):
   - Change `mode: subagent` to `mode: primary` in:
     - agent/documenter.md
     - agent/implementer.md
     - agent/planner.md
     - agent/researcher.md
     - agent/reviser.md
     - agent/tester.md

3. **Update command references** (6 files):
   - command/update-docs.md (line 20): `@subagents/documenter` → `@documenter`
   - command/implement.md (line 21): `@subagents/implementer` → `@implementer`
   - command/plan.md (line 22): `@subagents/planner` → `@planner`
   - command/research.md (line 19): `@subagents/researcher` → `@researcher`
   - command/revise.md (line 22): `@subagents/reviser` → `@reviser`
   - command/test.md (line 21): `@subagents/tester` → `@tester`

### Success Criteria

- [ ] 6 agent files moved to `agent/` directory
- [ ] All 6 agents have `mode: primary` in frontmatter
- [ ] All 6 command files reference agents without `@subagents/` prefix
- [ ] No broken references (grep verification)

### Testing

```bash
# Verify files moved
ls -1 /home/benjamin/.config/.opencode/agent/*.md | grep -E "(documenter|implementer|planner|researcher|reviser|tester)"

# Verify mode changes
grep "mode: primary" /home/benjamin/.config/.opencode/agent/{documenter,implementer,planner,researcher,reviser,tester}.md

# Verify command references updated
grep -E "@(documenter|implementer|planner|researcher|reviser|tester)" /home/benjamin/.config/.opencode/command/*.md
```

---

## Phase 2: Organize 13 Remaining Subagents into Subdirectories

**Status**: [NOT STARTED]
**Estimated Time**: 60-75 minutes
**Wave**: 1
**Dependencies**: None (can run parallel with Phase 1)

### Tasks

1. **Create subdirectory structure**:
   ```bash
   cd /home/benjamin/.config/.opencode/agent/subagents
   mkdir -p research implementation analysis configuration
   ```

2. **Move research subagents** (5 files):
   ```bash
   mv best-practices-researcher.md research/
   mv codebase-analyzer.md research/
   mv dependency-analyzer.md research/
   mv docs-fetcher.md research/
   mv refactor-finder.md research/
   ```

3. **Move implementation subagents** (2 files):
   ```bash
   mv code-generator.md implementation/
   mv code-modifier.md implementation/
   ```

4. **Move analysis subagents** (3 files):
   ```bash
   mv cruft-finder.md analysis/
   mv plugin-analyzer.md analysis/
   mv performance-profiler.md analysis/
   ```

5. **Move configuration subagents** (3 files):
   ```bash
   mv health-checker.md configuration/
   mv keybinding-optimizer.md configuration/
   mv lsp-configurator.md configuration/
   ```

6. **Update command references** (3 files):
   - command/remove-cruft.md (line 16): `@subagents/cruft-finder` → `@subagents/analysis/cruft-finder`
   - command/health-check.md (line 16): `@subagents/health-checker` → `@subagents/configuration/health-checker`
   - command/optimize-performance.md (line 16): `@subagents/performance-profiler` → `@subagents/analysis/performance-profiler`

### Success Criteria

- [ ] 4 subdirectories created under `agent/subagents/`
- [ ] 5 agents in `subagents/research/`
- [ ] 2 agents in `subagents/implementation/`
- [ ] 3 agents in `subagents/analysis/`
- [ ] 3 agents in `subagents/configuration/`
- [ ] 3 command files updated with new paths
- [ ] No files remaining in `agent/subagents/` root (except subdirectories)

### Testing

```bash
# Verify subdirectories created
ls -d /home/benjamin/.config/.opencode/agent/subagents/*/

# Verify file counts
ls -1 /home/benjamin/.config/.opencode/agent/subagents/research/*.md | wc -l  # Should be 5
ls -1 /home/benjamin/.config/.opencode/agent/subagents/implementation/*.md | wc -l  # Should be 2
ls -1 /home/benjamin/.config/.opencode/agent/subagents/analysis/*.md | wc -l  # Should be 3
ls -1 /home/benjamin/.config/.opencode/agent/subagents/configuration/*.md | wc -l  # Should be 3

# Verify no files in root
ls -1 /home/benjamin/.config/.opencode/agent/subagents/*.md 2>&1 | grep "No such file"

# Verify command references
grep "@subagents/analysis/cruft-finder" /home/benjamin/.config/.opencode/command/remove-cruft.md
grep "@subagents/configuration/health-checker" /home/benjamin/.config/.opencode/command/health-check.md
grep "@subagents/analysis/performance-profiler" /home/benjamin/.config/.opencode/command/optimize-performance.md
```

---

## Phase 3: Update Documentation

**Status**: [NOT STARTED]
**Estimated Time**: 60-90 minutes
**Wave**: 2
**Dependencies**: Phases 1 and 2 must be complete

### Tasks

#### 3.1 Update ARCHITECTURE.md

**File**: `/home/benjamin/.config/.opencode/ARCHITECTURE.md`

1. **Update agent hierarchy diagram** (lines 20-28):
   ```
   User Request
       ↓
   Orchestrator (neovim-orchestrator.md)
       ↓
   Primary Agents (researcher, planner, reviser, implementer, documenter, tester)
       ↓
   Specialized Subagents (organized by category)
   ```

2. **Update Primary Agent Layer section** (lines 51-132):
   - Add sections for documenter and tester agents
   - Update file paths from `agent/subagents/` to `agent/`
   - Clarify that these 6 agents are now primary

3. **Reorganize Subagent Layer section** (lines 134-206):
   - Create subsections for each category:
     - Research Subagents (research/)
     - Implementation Subagents (implementation/)
     - Analysis Subagents (analysis/)
     - Configuration Subagents (configuration/)
   - Update file paths to include subdirectory
   - Group agents by category with descriptions

4. **Update references throughout**:
   - Search for `agent/subagents/` and update to appropriate paths
   - Ensure consistency in agent categorization

#### 3.2 Update README.md

**File**: `/home/benjamin/.config/.opencode/README.md`

1. **Update Architecture section** (lines 44-76):
   - List 7 primary agents (orchestrator + 6 promoted)
   - Reorganize subagent lists by category
   - Update component descriptions

2. **Update Directory Structure** (lines 80-105):
   ```
   .opencode/
     agent/
       neovim-orchestrator.md
       documenter.md
       implementer.md
       planner.md
       researcher.md
       reviser.md
       tester.md
       subagents/
         research/
         implementation/
         analysis/
         configuration/
   ```

3. **Update agent descriptions**:
   - Clarify primary vs subagent roles
   - Add brief descriptions of subdirectory purposes

#### 3.3 Update BUILD_COMPLETE.md

**File**: `/home/benjamin/.config/.opencode/BUILD_COMPLETE.md`

1. **Update Pre-existing Components section** (lines 119-123):
   - Move 6 agents to "Primary Agents" category
   - Update file counts

2. **Update Created Components section** (lines 18-40):
   - Reorganize subagents by subdirectory
   - Update file counts per category
   - Add subdirectory descriptions

3. **Update Directory Structure diagram** (lines 130-152):
   - Show new agent organization
   - Include subdirectory structure

### Success Criteria

- [ ] ARCHITECTURE.md reflects new hierarchy with 7 primary agents
- [ ] ARCHITECTURE.md organizes subagents into 4 categories
- [ ] README.md directory structure shows new organization
- [ ] README.md lists all agents in correct categories
- [ ] BUILD_COMPLETE.md component counts are accurate
- [ ] All file paths in documentation are correct
- [ ] No references to old paths remain

### Testing

```bash
# Verify no old references remain
grep -r "agent/subagents/documenter" /home/benjamin/.config/.opencode/ && echo "ERROR: Old reference found" || echo "PASS"
grep -r "agent/subagents/implementer" /home/benjamin/.config/.opencode/ && echo "ERROR: Old reference found" || echo "PASS"
grep -r "agent/subagents/planner" /home/benjamin/.config/.opencode/ && echo "ERROR: Old reference found" || echo "PASS"
grep -r "agent/subagents/researcher" /home/benjamin/.config/.opencode/ && echo "ERROR: Old reference found" || echo "PASS"
grep -r "agent/subagents/reviser" /home/benjamin/.config/.opencode/ && echo "ERROR: Old reference found" || echo "PASS"
grep -r "agent/subagents/tester" /home/benjamin/.config/.opencode/ && echo "ERROR: Old reference found" || echo "PASS"

# Verify new references exist
grep -r "@documenter" /home/benjamin/.config/.opencode/command/
grep -r "@implementer" /home/benjamin/.config/.opencode/command/
grep -r "@subagents/research/" /home/benjamin/.config/.opencode/
grep -r "@subagents/analysis/" /home/benjamin/.config/.opencode/command/
```

---

## Phase 4: Validation and Testing

**Status**: [NOT STARTED]
**Estimated Time**: 30-45 minutes
**Wave**: 3
**Dependencies**: All previous phases complete

### Tasks

1. **Verify file structure**:
   ```bash
   # Check primary agents
   ls -1 /home/benjamin/.config/.opencode/agent/*.md | wc -l  # Should be 7
   
   # Check subagent organization
   find /home/benjamin/.config/.opencode/agent/subagents -name "*.md" | wc -l  # Should be 13
   ```

2. **Verify all references**:
   ```bash
   # Search for any remaining old-style references
   grep -r "@subagents/documenter\|@subagents/implementer\|@subagents/planner\|@subagents/researcher\|@subagents/reviser\|@subagents/tester" /home/benjamin/.config/.opencode/
   
   # Should return no results (exit code 1)
   ```

3. **Verify agent frontmatter**:
   ```bash
   # Check primary agents have mode: primary
   for agent in documenter implementer planner researcher reviser tester; do
     grep "mode: primary" /home/benjamin/.config/.opencode/agent/$agent.md || echo "ERROR: $agent not primary"
   done
   
   # Check subagents still have mode: subagent
   find /home/benjamin/.config/.opencode/agent/subagents -name "*.md" -exec grep -L "mode: subagent" {} \;
   # Should return no results
   ```

4. **Test command invocations** (manual verification):
   - Verify commands can still reference agents correctly
   - Check that OpenCode agent discovery works with new paths
   - Test a sample workflow (e.g., /research → /plan → /implement)

5. **Documentation consistency check**:
   ```bash
   # Verify documentation mentions correct agent counts
   grep "7 primary agents\|six primary agents" /home/benjamin/.config/.opencode/README.md
   grep "13 subagents\|thirteen subagents" /home/benjamin/.config/.opencode/README.md
   ```

### Success Criteria

- [ ] All file structure checks pass
- [ ] No old-style references found
- [ ] All primary agents have `mode: primary`
- [ ] All subagents have `mode: subagent`
- [ ] Commands can invoke agents correctly
- [ ] Documentation is consistent and accurate
- [ ] Sample workflow executes successfully

### Testing

Run comprehensive validation script:

```bash
#!/bin/bash
# Comprehensive validation script

echo "=== Agent Reorganization Validation ==="
echo ""

# Test 1: File counts
echo "Test 1: File counts"
PRIMARY_COUNT=$(ls -1 /home/benjamin/.config/.opencode/agent/*.md 2>/dev/null | wc -l)
SUBAGENT_COUNT=$(find /home/benjamin/.config/.opencode/agent/subagents -name "*.md" 2>/dev/null | wc -l)

if [ "$PRIMARY_COUNT" -eq 7 ]; then
  echo "✓ Primary agents: $PRIMARY_COUNT (expected 7)"
else
  echo "✗ Primary agents: $PRIMARY_COUNT (expected 7)"
fi

if [ "$SUBAGENT_COUNT" -eq 13 ]; then
  echo "✓ Subagents: $SUBAGENT_COUNT (expected 13)"
else
  echo "✗ Subagents: $SUBAGENT_COUNT (expected 13)"
fi

echo ""

# Test 2: Subdirectory organization
echo "Test 2: Subdirectory organization"
RESEARCH_COUNT=$(ls -1 /home/benjamin/.config/.opencode/agent/subagents/research/*.md 2>/dev/null | wc -l)
IMPL_COUNT=$(ls -1 /home/benjamin/.config/.opencode/agent/subagents/implementation/*.md 2>/dev/null | wc -l)
ANALYSIS_COUNT=$(ls -1 /home/benjamin/.config/.opencode/agent/subagents/analysis/*.md 2>/dev/null | wc -l)
CONFIG_COUNT=$(ls -1 /home/benjamin/.config/.opencode/agent/subagents/configuration/*.md 2>/dev/null | wc -l)

[ "$RESEARCH_COUNT" -eq 5 ] && echo "✓ Research: $RESEARCH_COUNT" || echo "✗ Research: $RESEARCH_COUNT (expected 5)"
[ "$IMPL_COUNT" -eq 2 ] && echo "✓ Implementation: $IMPL_COUNT" || echo "✗ Implementation: $IMPL_COUNT (expected 2)"
[ "$ANALYSIS_COUNT" -eq 3 ] && echo "✓ Analysis: $ANALYSIS_COUNT" || echo "✗ Analysis: $ANALYSIS_COUNT (expected 3)"
[ "$CONFIG_COUNT" -eq 3 ] && echo "✓ Configuration: $CONFIG_COUNT" || echo "✗ Configuration: $CONFIG_COUNT (expected 3)"

echo ""

# Test 3: Mode declarations
echo "Test 3: Mode declarations"
PRIMARY_MODE_COUNT=0
for agent in neovim-orchestrator documenter implementer planner researcher reviser tester; do
  if grep -q "mode: primary" /home/benjamin/.config/.opencode/agent/$agent.md 2>/dev/null; then
    PRIMARY_MODE_COUNT=$((PRIMARY_MODE_COUNT + 1))
  else
    echo "✗ $agent missing 'mode: primary'"
  fi
done

if [ "$PRIMARY_MODE_COUNT" -eq 7 ]; then
  echo "✓ All 7 primary agents have 'mode: primary'"
else
  echo "✗ Only $PRIMARY_MODE_COUNT/7 primary agents have 'mode: primary'"
fi

echo ""

# Test 4: Old references
echo "Test 4: Checking for old references"
OLD_REFS=$(grep -r "@subagents/documenter\|@subagents/implementer\|@subagents/planner\|@subagents/researcher\|@subagents/reviser\|@subagents/tester" /home/benjamin/.config/.opencode/ 2>/dev/null | wc -l)

if [ "$OLD_REFS" -eq 0 ]; then
  echo "✓ No old-style references found"
else
  echo "✗ Found $OLD_REFS old-style references"
  grep -r "@subagents/documenter\|@subagents/implementer\|@subagents/planner\|@subagents/researcher\|@subagents/reviser\|@subagents/tester" /home/benjamin/.config/.opencode/ 2>/dev/null
fi

echo ""

# Test 5: New references
echo "Test 5: Verifying new references"
NEW_REFS=0
grep -q "@documenter" /home/benjamin/.config/.opencode/command/update-docs.md 2>/dev/null && NEW_REFS=$((NEW_REFS + 1))
grep -q "@implementer" /home/benjamin/.config/.opencode/command/implement.md 2>/dev/null && NEW_REFS=$((NEW_REFS + 1))
grep -q "@planner" /home/benjamin/.config/.opencode/command/plan.md 2>/dev/null && NEW_REFS=$((NEW_REFS + 1))
grep -q "@researcher" /home/benjamin/.config/.opencode/command/research.md 2>/dev/null && NEW_REFS=$((NEW_REFS + 1))
grep -q "@reviser" /home/benjamin/.config/.opencode/command/revise.md 2>/dev/null && NEW_REFS=$((NEW_REFS + 1))
grep -q "@tester" /home/benjamin/.config/.opencode/command/test.md 2>/dev/null && NEW_REFS=$((NEW_REFS + 1))

if [ "$NEW_REFS" -eq 6 ]; then
  echo "✓ All 6 command files use new references"
else
  echo "✗ Only $NEW_REFS/6 command files use new references"
fi

echo ""
echo "=== Validation Complete ==="
```

---

## Rollback Plan

If issues are discovered after implementation:

1. **Rollback Phase 1** (Promote agents):
   ```bash
   cd /home/benjamin/.config/.opencode/agent
   mv documenter.md subagents/
   mv implementer.md subagents/
   mv planner.md subagents/
   mv researcher.md subagents/
   mv reviser.md subagents/
   mv tester.md subagents/
   
   # Revert mode changes in each file
   # Revert command references
   ```

2. **Rollback Phase 2** (Organize subagents):
   ```bash
   cd /home/benjamin/.config/.opencode/agent/subagents
   mv research/*.md .
   mv implementation/*.md .
   mv analysis/*.md .
   mv configuration/*.md .
   rmdir research implementation analysis configuration
   
   # Revert command references
   ```

3. **Rollback Phase 3** (Documentation):
   ```bash
   git checkout ARCHITECTURE.md README.md BUILD_COMPLETE.md
   ```

---

## Post-Implementation Tasks

1. **Create README.md files** for each subdirectory:
   - `agent/subagents/research/README.md` - Describe research subagents
   - `agent/subagents/implementation/README.md` - Describe implementation subagents
   - `agent/subagents/analysis/README.md` - Describe analysis subagents
   - `agent/subagents/configuration/README.md` - Describe configuration subagents

2. **Update agent/README.md** (if it exists):
   - Document primary vs subagent distinction
   - Explain subdirectory organization
   - Provide usage examples

3. **Git commit**:
   ```bash
   git add -A
   git commit -m "refactor: reorganize agent hierarchy

   - Promote 6 core agents to primary status (documenter, implementer, planner, researcher, reviser, tester)
   - Organize 13 remaining subagents into logical subdirectories (research, implementation, analysis, configuration)
   - Update all references in commands and documentation
   - Improve agent discoverability and hierarchy clarity"
   ```

---

## Risk Assessment

**Low Risk**:
- Clean separation between agents (no circular dependencies)
- Well-defined reference patterns (`@subagents/` prefix)
- Comprehensive testing plan
- Clear rollback procedure

**Potential Issues**:
- Agent discovery mechanism may need updates (check OpenCode internals)
- Any external scripts or tools referencing agent paths
- Cached agent references in running processes

**Mitigation**:
- Thorough grep-based reference checking
- Comprehensive validation script
- Test sample workflows before declaring complete
- Document new structure clearly

---

## Summary

This reorganization improves the .opencode agent architecture by:

1. **Clarifying agent hierarchy**: Primary agents (7) vs subagents (13)
2. **Improving discoverability**: Logical subdirectory organization
3. **Maintaining consistency**: All references updated systematically
4. **Preserving functionality**: No breaking changes to agent behavior

**Total Files Affected**: ~30 files
- 6 agent files promoted
- 13 agent files reorganized
- 9 command files updated
- 3 documentation files updated

**Estimated Total Time**: 3-4 hours
**Complexity**: Medium (file reorganization + reference updates)
**Risk Level**: Low (clean structure, comprehensive testing)
