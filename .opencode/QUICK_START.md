# Quick Start Guide

Get started with the NeoVim Configuration Management System.

---

## Prerequisites

- NeoVim installed and configured
- OpenCode CLI available
- Git repository initialized in `/home/benjamin/.config/nvim/`
- STANDARDS.md exists at `/home/benjamin/.config/STANDARDS.md`

---

## Basic Workflow

### 1. Research a Topic

Start with research to gather information before making changes.

```
/research "Optimize lazy.nvim plugin loading for faster startup times"
```

**What happens**:
- System creates project `001_lazy_loading_optimization/`
- Runs parallel research across multiple areas
- Generates `OVERVIEW.md` with findings
- Commits research to git

**Output**:
```
✅ Research Complete: lazy_loading_optimization

Project: .opencode/specs/001_lazy_loading_optimization/
Overview: .opencode/specs/001_lazy_loading_optimization/reports/OVERVIEW.md

Research Summary:
Analyzed current lazy.nvim configuration...
[Summary of findings]

Reports Generated (5):
1. Codebase Analysis - ...
2. Documentation Research - ...
3. Best Practices - ...
4. Dependency Analysis - ...
5. Refactoring Opportunities - ...

Next Steps:
/plan .opencode/specs/001_lazy_loading_optimization/reports/OVERVIEW.md
```

---

### 2. Create Implementation Plan

Use research findings to create a phased implementation plan.

```
/plan .opencode/specs/001_lazy_loading_optimization/reports/OVERVIEW.md "Create phased plan with Wave 1: quick wins, Wave 2: major refactors"
```

**What happens**:
- Planner reads OVERVIEW.md
- Creates phased implementation plan
- Organizes phases into waves for parallel execution
- Updates TODO.md
- Commits plan to git

**Output**:
```
✅ Plan Created: lazy_loading_optimization

Plan: .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md

Plan Structure:
- Total Phases: 4
- Total Waves: 2
- Estimated Duration: 4-6 hours

Wave 1 (Parallel):
  Phase 1: Add lazy-loading to telescope.nvim (1h)
  Phase 2: Add lazy-loading to nvim-tree (1h)

Wave 2 (Parallel):
  Phase 3: Optimize LSP lazy-loading (2h)
  Phase 4: Update documentation (1h)

Next Steps:
Review plan, then:
/approve project-001  (to approve and proceed)
/reject project-001 "reason"  (to cancel with reason)
```

---

### 3. Approve the Plan

Review the plan and approve it before implementation.

```
# Review the plan first
cat .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md

# If plan looks good, approve it
/approve project-001
```

**What happens**:
- Validates project exists and has plan
- Updates state.json with approval metadata
- Transitions phase from "planning" to "approved"
- Commits approval to git

**Output**:
```
✅ Project 001 (lazy_loading_optimization) approved
📄 Plan: specs/001_lazy_loading_optimization/plans/implementation_v1.md
▶️  Next: /implement specs/001_lazy_loading_optimization/plans/implementation_v1.md
```

**Alternative - Reject Plan**:
```
/reject project-001 "Plan complexity too high, needs simplification"
```

This cancels the project and documents the reason.

---

### 4. Implement the Plan

Execute the implementation plan with automated testing.

```
/implement .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md
```

**What happens**:
- Implementer reads plan
- Executes Wave 1 phases in parallel
- Tests each phase completion
- Commits each phase to git
- Executes Wave 2 phases
- Tests and commits
- Updates TODO.md to Completed

**Output**:
```
✅ Implementation Complete: lazy_loading_optimization

Status: All phases completed successfully

Wave 1 Results:
  ✓ Phase 1: telescope.nvim lazy-loading added (commit: abc123)
  ✓ Phase 2: nvim-tree lazy-loading added (commit: def456)

Wave 2 Results:
  ✓ Phase 3: LSP optimization complete (commit: ghi789)
  ✓ Phase 4: Documentation updated (commit: jkl012)

Performance Impact:
  Startup time: 200ms → 120ms (80ms improvement)

Tests: All passed
Commits: 4 created
TODO.md: Moved to Completed
```

---

### 5. Revise Plan (Optional)

If you need to modify the plan before or during implementation:

```
/revise .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md "Add performance benchmarking phase"
```

**What happens**:
- Reviser reads current plan
- Conducts additional research if needed
- Creates `implementation_v2.md`
- Preserves v1 for history
- Commits new version

**Output**:
```
✅ Plan Revised: lazy_loading_optimization

New Version: .opencode/specs/001_lazy_loading_optimization/plans/implementation_v2.md
Previous Version: implementation_v1.md (preserved)

Changes:
- Added Phase 5: Performance benchmarking and validation
- Updated Wave 2 to include benchmarking
- New research report: performance_benchmarking.md

Next Steps:
/approve project-001  (approve revised plan)
/implement .opencode/specs/001_lazy_loading_optimization/plans/implementation_v2.md
```

---

### 6. Rollback Changes (If Needed)

If implementation causes issues, rollback safely:

```
# Rollback last completed phase
/rollback last-phase

# Rollback specific commit
/rollback abc123

# Rollback entire project (requires confirmation)
/rollback project-001
```

**What happens**:
- Shows diff of changes to be reverted
- Requires user confirmation
- Executes git revert or reset
- Updates state.json
- Runs health checks
- Updates TODO.md (if project rollback)

**Output**:
```
Changes to be reverted:
- lua/plugins/telescope.lua (modified)
- README.md (modified)

Rollback Phase 4 changes? This will revert commit abc123. [y/N] y

✅ Rollback complete
- Reverted Phase 4 (commit abc123)
- Health check: OK
- State updated
```

---

## Quick-Win Workflow

For simple, low-risk improvements that don't need full planning.

### When to Use Quick-Implement

Use `/quick-implement` when:
- Research identifies "Quick Wins" section
- Changes are low-risk (max 3 files, 50 lines)
- Implementation is well-defined
- No architectural changes needed

### Example: Add Keybindings

```
# Research identifies quick win
/research "Add scrolling keybindings to opencode"

# Review quick wins in research report
cat .opencode/specs/003_opencode_scrolling/reports/OVERVIEW.md

# Execute first quick win
/quick-implement 1
```

**What happens**:
- Implementer extracts quick win from research
- Shows details and confirms with user
- Executes directly (no planning phase)
- Runs health checks
- Commits changes
- Returns in 2-3 minutes (vs 15-20 for full workflow)

**Output**:
```
Quick Win 1: Add scrolling keybindings
- Description: Add keybindings for scrolling opencode output
- Risk: Low
- Files: lua/plugins/opencode.lua

Execute? [y/N] y

✅ Quick Win 1 implemented successfully
- File modified: lua/plugins/opencode.lua
- Health checks: PASSED
- Commit: a1b2c3d
- Time: 2 minutes
```

### Quick-Implement Options

```
/quick-implement 1                    # Execute first quick win
/quick-implement "lazy-loading"       # Execute by name
/quick-implement all                  # Execute all quick wins
/quick-implement                      # List and choose
```

---

## Approval Workflow

Review and approve plans before implementation.

### Why Use Approval Gates?

- **Safety**: Prevents unwanted changes from executing
- **Review**: Ensures plan meets requirements
- **Documentation**: Records approval/rejection decisions
- **Control**: Explicit go/no-go decision point

### Approval Example

```
# Create plan
/plan .opencode/specs/001_optimization/reports/OVERVIEW.md

# Review plan
cat .opencode/specs/001_optimization/plans/implementation_v1.md

# Approve if good
/approve project-001

# Or reject if issues
/reject project-001 "Plan complexity too high, needs simplification"
```

### Approval States

**Planning** → **Approved** → **Implementation**
```
state.json:
{
  "phase": "planning",      # After /plan
  "status": "active"
}

↓ /approve

{
  "phase": "approved",      # Ready for /implement
  "status": "active",
  "approval": {
    "status": "approved",
    "date": "2025-12-16T10:30:00Z",
    "approved_by": "user"
  }
}
```

**Planning** → **Rejected** → **Cancelled**
```
state.json:
{
  "phase": "planning",
  "status": "active"
}

↓ /reject

{
  "phase": "rejected",
  "status": "cancelled",
  "approval": {
    "status": "rejected",
    "date": "2025-12-16T10:30:00Z",
    "rejected_by": "user",
    "reason": "Plan complexity too high"
  }
}
```

---

## Utility Commands

### Check Project Status

```
/todo
```

Shows all projects and their status (Not Started, In Progress, Completed).

---

### Health Check

```
/health-check
```

Runs `:checkhealth` and provides actionable fixes for any issues.

---

### Performance Optimization

```
/optimize-performance
```

Analyzes current configuration and suggests performance improvements.

**Typical Output**:
```
Performance Analysis:
- Startup time: 180ms
- Plugins: 47 total, 15 lazy-loaded

Optimization Opportunities:
1. Lazy-load telescope.nvim (est. 80ms improvement)
2. Lazy-load nvim-tree (est. 40ms improvement)
3. Optimize LSP server loading (est. 30ms improvement)

Total potential improvement: ~150ms

Next Steps:
/research "Implement lazy-loading for identified plugins"
```

---

### Remove Cruft

```
/remove-cruft
```

Identifies unused plugins, code, and configurations.

**Typical Output**:
```
Cruft Analysis:
- Unused plugins: 3 found
- Dead code: 7 unreferenced functions
- Duplicate configs: 2 found

Safe Removals (Low Risk):
1. Remove disabled plugin: nvim-autopairs
2. Delete unused utility function: format_json
3. Consolidate duplicate which-key config

Next Steps:
/plan "Clean up unused configurations based on cruft report"
```

---

### Run Tests

```
/test
```

Runs comprehensive tests on current configuration.

---

### Update Documentation

```
/update-docs
```

Generates/updates documentation for recent changes.

---

## Example: End-to-End Workflow

Let's say you want to improve LSP performance for Rust development.

### Step 1: Research

```
/research "Optimize LSP performance for Rust development in NeoVim"
```

Wait for research completion (1-2 minutes).

---

### Step 2: Review Research

Open and review the OVERVIEW.md:
```
cat .opencode/specs/002_rust_lsp_performance/reports/OVERVIEW.md
```

Look for "Quick Wins" section for simple improvements.

---

### Step 3: Execute Quick Wins (Optional)

If research identified quick wins:
```
/quick-implement 1
```

This executes the first quick win directly (no planning needed).

---

### Step 4: Create Plan

For complex changes:
```
/plan .opencode/specs/002_rust_lsp_performance/reports/OVERVIEW.md "Focus on rust-analyzer optimization and incremental compilation"
```

---

### Step 5: Review and Approve Plan

Open and review the plan:
```
cat .opencode/specs/002_rust_lsp_performance/plans/implementation_v1.md
```

If plan looks good, approve:
```
/approve project-002
```

If not, revise:
```
/revise .opencode/specs/002_rust_lsp_performance/plans/implementation_v1.md "Add caching configuration phase"
# Then approve the revised plan
/approve project-002
```

Or reject:
```
/reject project-002 "Scope too large, needs simplification"
```

---

### Step 6: Implement

```
/implement .opencode/specs/002_rust_lsp_performance/plans/implementation_v1.md
```

---

### Step 7: Verify

Test the changes:
```
# Open a Rust file
nvim test.rs

# Check LSP attachment
:LspInfo

# Test functionality
# (hover, go-to-definition, etc.)

# Check performance
nvim --startuptime startup.log
```

---

### Step 8: Rollback (If Issues)

If tests fail or issues arise:
```
/rollback last-phase
```

---

### Step 9: Document

If tests pass:
```
/update-docs
```

Done! Your Rust LSP is now optimized.

---

## Tips and Best Practices

### 1. Always Research First

Don't skip the research phase. It ensures you understand:
- Current state of your configuration
- Best practices from the community
- Potential pitfalls
- Optimization opportunities
- Quick wins for immediate improvements

### 2. Use Quick-Implement for Simple Changes

If research identifies quick wins:
```
/quick-implement 1
```

Benefits:
- 60-80% time savings vs full workflow
- No planning overhead
- Immediate visible improvements

### 3. Always Approve Plans Before Implementation

Review and approve plans:
```
cat .opencode/specs/NNN_project/plans/implementation_v1.md
/approve project-NNN
```

This prevents unwanted changes from executing.

### 4. Document Rejection Reasons

If rejecting a plan:
```
/reject project-NNN "Clear reason for rejection"
```

This helps future planning and avoids duplicate work.

### 5. Use Descriptive Research Prompts

Good:
```
/research "Optimize telescope.nvim lazy-loading and keybinding organization"
```

Not as good:
```
/research "telescope stuff"
```

### 6. Check TODO Regularly

```
/todo
```

Keeps you aware of what's in progress and what's pending.

### 7. Run Health Checks After Major Changes

```
/health-check
```

Catches issues early.

### 8. Use Rollback for Safe Recovery

If issues arise:
```
/rollback last-phase  # Revert last phase
/rollback abc123      # Revert specific commit
```

Always preview changes before confirming.

### 9. Use Performance Profiling

After performance-related changes:
```
nvim --startuptime startup.log
tail -20 startup.log
```

Verify improvements.

---

## Troubleshooting

### Issue: Research takes too long

**Cause**: Multiple research subagents running
**Solution**: This is normal, max 5 concurrent. Wait for completion.

---

### Issue: Implementation fails

**Check**:
1. `cat logs/errors.log` for error details
2. Git status to see what changed
3. Review test output

**Recovery**:
```bash
/rollback last-phase  # Safe rollback with confirmation
```

Then revise plan and try again.

---

### Issue: Tests fail after implementation

**Check**: 
```
/health-check
```

**Fix** issues identified, then:
```
/test
```

---

### Issue: Startup time didn't improve

**Analyze**:
```
nvim --startuptime startup.log
cat startup.log | sort -k2 -n | tail -20
```

Identify slow plugins and add to research:
```
/research "Further optimize {slow-plugin} lazy-loading"
```

---

## Next Steps

- Read `ARCHITECTURE.md` for system design details
- Review `context/` files for domain knowledge
- Explore `specs/` to see project structure
- Check `README.md` for comprehensive overview

---

## Getting Help

- Check `logs/errors.log` for error details
- Review agent definitions in `agent/`
- Consult context files in `context/`
- Run `/help` for command reference
