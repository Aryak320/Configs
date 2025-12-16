# Agent Reorganization - Implementation Checklist

Quick reference checklist for executing the reorganization plan.

---

## Pre-Implementation

- [ ] Review full plan: `agent_reorganization_plan.md`
- [ ] Review summary: `agent_reorganization_summary.md`
- [ ] Review diagrams: `agent_reorganization_diagram.md`
- [ ] Backup current state: `git commit -am "backup: pre-reorganization state"`
- [ ] Create working branch: `git checkout -b refactor/agent-reorganization`

---

## Phase 1: Promote 6 Agents to Primary (45-60 min)

### File Operations
- [ ] Move `subagents/documenter.md` → `documenter.md`
- [ ] Move `subagents/implementer.md` → `implementer.md`
- [ ] Move `subagents/planner.md` → `planner.md`
- [ ] Move `subagents/researcher.md` → `researcher.md`
- [ ] Move `subagents/reviser.md` → `reviser.md`
- [ ] Move `subagents/tester.md` → `tester.md`

### Frontmatter Updates
- [ ] Update `documenter.md`: `mode: subagent` → `mode: primary`
- [ ] Update `implementer.md`: `mode: subagent` → `mode: primary`
- [ ] Update `planner.md`: `mode: subagent` → `mode: primary`
- [ ] Update `researcher.md`: `mode: subagent` → `mode: primary`
- [ ] Update `reviser.md`: `mode: subagent` → `mode: primary`
- [ ] Update `tester.md`: `mode: subagent` → `mode: primary`

### Command Reference Updates
- [ ] Update `command/update-docs.md`: `@subagents/documenter` → `@documenter`
- [ ] Update `command/implement.md`: `@subagents/implementer` → `@implementer`
- [ ] Update `command/plan.md`: `@subagents/planner` → `@planner`
- [ ] Update `command/research.md`: `@subagents/researcher` → `@researcher`
- [ ] Update `command/revise.md`: `@subagents/reviser` → `@reviser`
- [ ] Update `command/test.md`: `@subagents/tester` → `@tester`

### Validation
- [ ] Verify 6 files moved: `ls -1 agent/*.md | wc -l` (should be 7)
- [ ] Verify mode changes: `grep "mode: primary" agent/{documenter,implementer,planner,researcher,reviser,tester}.md`
- [ ] Verify command updates: `grep -E "@(documenter|implementer|planner|researcher|reviser|tester)" command/*.md`
- [ ] No old references: `grep "@subagents/documenter" . -r` (should be empty)

---

## Phase 2: Organize 13 Subagents (60-75 min)

### Create Subdirectories
- [ ] Create `agent/subagents/research/`
- [ ] Create `agent/subagents/implementation/`
- [ ] Create `agent/subagents/analysis/`
- [ ] Create `agent/subagents/configuration/`

### Move Research Subagents (5)
- [ ] Move `best-practices-researcher.md` → `research/`
- [ ] Move `codebase-analyzer.md` → `research/`
- [ ] Move `dependency-analyzer.md` → `research/`
- [ ] Move `docs-fetcher.md` → `research/`
- [ ] Move `refactor-finder.md` → `research/`

### Move Implementation Subagents (2)
- [ ] Move `code-generator.md` → `implementation/`
- [ ] Move `code-modifier.md` → `implementation/`

### Move Analysis Subagents (3)
- [ ] Move `cruft-finder.md` → `analysis/`
- [ ] Move `plugin-analyzer.md` → `analysis/`
- [ ] Move `performance-profiler.md` → `analysis/`

### Move Configuration Subagents (3)
- [ ] Move `health-checker.md` → `configuration/`
- [ ] Move `keybinding-optimizer.md` → `configuration/`
- [ ] Move `lsp-configurator.md` → `configuration/`

### Command Reference Updates
- [ ] Update `command/remove-cruft.md`: `@subagents/cruft-finder` → `@subagents/analysis/cruft-finder`
- [ ] Update `command/health-check.md`: `@subagents/health-checker` → `@subagents/configuration/health-checker`
- [ ] Update `command/optimize-performance.md`: `@subagents/performance-profiler` → `@subagents/analysis/performance-profiler`

### Validation
- [ ] Verify subdirectories: `ls -d agent/subagents/*/`
- [ ] Verify counts: `ls -1 agent/subagents/research/*.md | wc -l` (should be 5)
- [ ] Verify counts: `ls -1 agent/subagents/implementation/*.md | wc -l` (should be 2)
- [ ] Verify counts: `ls -1 agent/subagents/analysis/*.md | wc -l` (should be 3)
- [ ] Verify counts: `ls -1 agent/subagents/configuration/*.md | wc -l` (should be 3)
- [ ] No files in root: `ls -1 agent/subagents/*.md 2>&1 | grep "No such file"`
- [ ] Verify command updates: `grep "@subagents/analysis/cruft-finder" command/remove-cruft.md`

---

## Phase 3: Update Documentation (60-90 min)

### ARCHITECTURE.md
- [ ] Update agent hierarchy diagram (lines 20-28)
- [ ] Update Primary Agent Layer section (lines 51-132)
- [ ] Reorganize Subagent Layer section (lines 134-206)
- [ ] Update all `agent/subagents/` references

### README.md
- [ ] Update Architecture section (lines 44-76)
- [ ] Update Directory Structure (lines 80-105)
- [ ] Update agent lists and descriptions

### BUILD_COMPLETE.md
- [ ] Update Pre-existing Components section (lines 119-123)
- [ ] Update Created Components section (lines 18-40)
- [ ] Update Directory Structure diagram (lines 130-152)

### Validation
- [ ] No old references: `grep "agent/subagents/documenter" . -r` (should be empty)
- [ ] No old references: `grep "agent/subagents/implementer" . -r` (should be empty)
- [ ] Verify new structure documented: `grep "7 primary agents" README.md`
- [ ] Verify subdirectories documented: `grep "research/" README.md`

---

## Phase 4: Validation and Testing (30-45 min)

### File Structure Validation
- [ ] Primary agent count: `ls -1 agent/*.md | wc -l` (should be 7)
- [ ] Subagent count: `find agent/subagents -name "*.md" | wc -l` (should be 13)
- [ ] Research count: `ls -1 agent/subagents/research/*.md | wc -l` (should be 5)
- [ ] Implementation count: `ls -1 agent/subagents/implementation/*.md | wc -l` (should be 2)
- [ ] Analysis count: `ls -1 agent/subagents/analysis/*.md | wc -l` (should be 3)
- [ ] Configuration count: `ls -1 agent/subagents/configuration/*.md | wc -l` (should be 3)

### Reference Validation
- [ ] No old primary references: `grep -r "@subagents/documenter\|@subagents/implementer\|@subagents/planner\|@subagents/researcher\|@subagents/reviser\|@subagents/tester" .`
- [ ] New primary references exist: `grep "@documenter" command/update-docs.md`
- [ ] New subagent references exist: `grep "@subagents/analysis/cruft-finder" command/remove-cruft.md`

### Mode Validation
- [ ] All primary agents: `grep "mode: primary" agent/{orchestrator,documenter,implementer,planner,researcher,reviser,tester}.md`
- [ ] All subagents: `find agent/subagents -name "*.md" -exec grep -L "mode: subagent" {} \;` (should be empty)

### Run Validation Script
- [ ] Run comprehensive validation script (see plan Phase 4)
- [ ] All tests pass

### Manual Testing
- [ ] Test `/research` command (sample invocation)
- [ ] Test `/plan` command (sample invocation)
- [ ] Test `/implement` command (sample invocation)
- [ ] Verify agent discovery works with new paths

---

## Post-Implementation

### Create README Files
- [ ] Create `agent/subagents/research/README.md`
- [ ] Create `agent/subagents/implementation/README.md`
- [ ] Create `agent/subagents/analysis/README.md`
- [ ] Create `agent/subagents/configuration/README.md`
- [ ] Update `agent/README.md` (if exists)

### Git Commit
- [ ] Stage all changes: `git add -A`
- [ ] Review changes: `git status`
- [ ] Commit with message:
  ```
  refactor: reorganize agent hierarchy
  
  - Promote 6 core agents to primary status (documenter, implementer, planner, researcher, reviser, tester)
  - Organize 13 remaining subagents into logical subdirectories (research, implementation, analysis, configuration)
  - Update all references in commands and documentation
  - Improve agent discoverability and hierarchy clarity
  ```
- [ ] Verify commit: `git log -1 --stat`

### Merge and Cleanup
- [ ] Switch to main: `git checkout main`
- [ ] Merge branch: `git merge refactor/agent-reorganization`
- [ ] Delete branch: `git branch -d refactor/agent-reorganization`
- [ ] Tag release: `git tag -a v1.1.0 -m "Agent hierarchy reorganization"`

---

## Rollback (If Needed)

If issues are discovered:

- [ ] Checkout backup: `git checkout <backup-commit-hash>`
- [ ] Create rollback branch: `git checkout -b rollback/agent-reorganization`
- [ ] Or use rollback procedures in plan Phase 1-3

---

## Success Criteria

- [ ] All 7 primary agents have `mode: primary`
- [ ] All 13 subagents organized into 4 subdirectories
- [ ] No old-style references remain
- [ ] All documentation updated
- [ ] Validation script passes 100%
- [ ] Sample workflow executes successfully
- [ ] Git commit created with clear message
- [ ] README files created for subdirectories

---

## Time Tracking

- Phase 1 Start: ___________
- Phase 1 End: ___________
- Phase 2 Start: ___________
- Phase 2 End: ___________
- Phase 3 Start: ___________
- Phase 3 End: ___________
- Phase 4 Start: ___________
- Phase 4 End: ___________
- Total Time: ___________

**Estimated**: 3-4 hours
**Actual**: ___________
