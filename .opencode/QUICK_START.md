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
/implement .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md
```

---

### 3. Implement the Plan

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

### 4. Revise Plan (Optional)

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
/implement .opencode/specs/001_lazy_loading_optimization/plans/implementation_v2.md
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

---

### Step 3: Create Plan

```
/plan .opencode/specs/002_rust_lsp_performance/reports/OVERVIEW.md "Focus on rust-analyzer optimization and incremental compilation"
```

---

### Step 4: Review Plan

Open and review the plan:
```
cat .opencode/specs/002_rust_lsp_performance/plans/implementation_v1.md
```

If plan looks good, proceed. If not, revise:
```
/revise .opencode/specs/002_rust_lsp_performance/plans/implementation_v1.md "Add caching configuration phase"
```

---

### Step 5: Implement

```
/implement .opencode/specs/002_rust_lsp_performance/plans/implementation_v1.md
```

---

### Step 6: Verify

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

### Step 7: Document

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

### 2. Review Before Implementing

Always review the generated plan before implementing:
```
cat .opencode/specs/NNN_project/plans/implementation_v1.md
```

Revise if needed.

### 3. Use Descriptive Research Prompts

Good:
```
/research "Optimize telescope.nvim lazy-loading and keybinding organization"
```

Not as good:
```
/research "telescope stuff"
```

### 4. Check TODO Regularly

```
/todo
```

Keeps you aware of what's in progress and what's pending.

### 5. Run Health Checks After Major Changes

```
/health-check
```

Catches issues early.

### 6. Use Performance Profiling

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
git reset --hard HEAD~1  # Revert last commit
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
