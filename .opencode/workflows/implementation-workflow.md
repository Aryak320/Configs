# Implementation Workflow

**Agent**: Implementer
**Trigger**: `/implement` command with plan path
**Purpose**: Execute implementation plan with automated testing and git commits

---

## Workflow Steps

### 1. Read and Parse Plan

**Actions**:
- Read implementation plan at provided path
- Parse all phases and waves
- Extract dependencies
- Understand validation criteria
- Load NeoVim config path
- Load STANDARDS.md

---

### 2. Validate Prerequisites

**Actions**:
- Check plan status (should be NOT STARTED or IN PROGRESS)
- Verify NeoVim config exists
- Check git repository status
- Validate no uncommitted changes (or ask user)
- Ensure required tools available (nvim, git, etc.)

---

### 3. Update Plan Status

**Actions**:
- Change plan status from [NOT STARTED] to [IN PROGRESS]
- Update modification timestamp
- Commit status change to git

**Commit**:
```
chore: start implementation of {project_name}

Plan: {plan_path}
Status: IN PROGRESS
```

---

### 4. Execute Waves Sequentially

**For each wave**:
- Execute all phases within wave in parallel (up to max concurrency)
- Wait for wave completion before proceeding to next
- Handle errors at wave level

**Parallel Execution**:
- Phases without dependencies → parallel
- Max 5 concurrent operations
- Collect results as they complete

---

### 5. Execute Each Phase

**For each phase in wave**:

#### A. Invoke Implementation Subagents

Based on phase tasks, invoke appropriate subagents:

**code-generator**: For new files
- Create new Lua modules
- Generate plugin specs
- Create configurations

**code-modifier**: For changes
- Modify existing files
- Refactor code
- Update configurations

**documenter**: For documentation
- Update docs
- Generate examples
- Create README updates

#### B. Collect Subagent Results

- Receive brief summaries
- Collect file paths modified/created
- Note any issues or warnings

#### C. Run Tests

**Invoke tester subagent**:
- Run :checkhealth
- Test plugin functionality
- Validate LSP servers
- Check keybindings
- Measure performance
- Verify no errors

**Test Results**:
- PASS: Continue to commit
- FAIL: Stop, report error, rollback phase
- WARNING: Continue but note warnings

#### D. Commit Phase Completion

**If tests pass**:
- Stage all modified/created files
- Create commit for phase
- Update state.json
- Log completion

**Commit Format**:
```
{type}: {phase description}

- Task 1 completed
- Task 2 completed
- Tests: PASS
- Startup time: {before}ms → {after}ms (if applicable)

Phase {N}/{Total} of {project_name}
```

**Commit Types**:
- `feat`: New features
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `fix`: Bug fixes
- `docs`: Documentation

---

### 6. Handle Phase Errors

**If phase fails**:

#### Option 1: Retry
- Retry phase once
- Log retry attempt
- If retry succeeds, continue

#### Option 2: Skip
- Mark phase as failed in state
- Log error
- Continue with independent phases
- Report failure to user

#### Option 3: Abort
- For critical failures
- Rollback current phase
- Update plan status to [BLOCKED]
- Report blocker to user

---

### 7. Update TODO.md

**On successful completion**:
- Move project from current section to "Completed"
- Add completion date
- Note performance improvements or key changes

**Example**:
```markdown
## Completed

- [x] 001_lazy_loading_optimization: Optimize plugin lazy-loading
  - Completed: 2025-12-15
  - Result: Startup time improved 200ms → 120ms
  - Commits: 4 phases
```

---

### 8. Update Plan Status

**Actions**:
- Change status from [IN PROGRESS] to [COMPLETED]
- Update completion timestamp
- Commit status update

**Commit**:
```
chore: complete implementation of {project_name}

- All {N} phases completed
- Tests: All passed
- Commits: {N} created
- Status: COMPLETED
```

---

### 9. Return Summary

**Actions**:
- Summarize implementation results
- List all commits created
- Report test status
- Note performance changes
- Highlight any warnings or partial successes

**Output Format**:
```
✅ Implementation Complete: {Project Name}

Status: All phases completed successfully

{Wave-by-wave summary}

Wave 1 Results:
  ✓ Phase 1: {description} (commit: {hash})
  ✓ Phase 2: {description} (commit: {hash})

Wave 2 Results:
  ✓ Phase 3: {description} (commit: {hash})

Performance Impact:
  Startup time: {before}ms → {after}ms ({improvement}ms improvement)

Tests: All passed
Commits: {N} created
TODO.md: Moved to Completed

{Any warnings or notes}
```

---

## Parallel Phase Execution

### Within a Wave

**Strategy**:
- Launch all phases in wave simultaneously
- Each phase runs independently
- Collect results as phases complete
- Wait for all phases before proceeding to next wave

**Example Wave 1**:
```
Parallel:
  Phase 1: telescope lazy-loading (2 min)
  Phase 2: nvim-tree lazy-loading (1.5 min)
  
Total wave time: 2 min (max of phases)
```

---

## Error Recovery

### Phase Failure Types

**Test Failure**:
- Tests don't pass after implementation
- Rollback phase changes
- Log error
- Report to user with details

**Subagent Failure**:
- Subagent returns error
- Retry once
- If fails again, mark phase as blocked
- Continue with other phases if possible

**Git Failure**:
- Cannot commit changes
- Investigate git status
- Resolve conflicts
- Retry commit

---

### Rollback Strategy

**Per Phase**:
```bash
git reset --hard HEAD~1  # Undo last commit (phase)
```

**Entire Implementation**:
```bash
git reset --hard {pre-implementation-hash}
```

**Selective Rollback**:
```bash
git revert {commit-hash}  # Undo specific phase
```

---

## State Updates

**state.json** during implementation:

**Start**:
```json
{
  "status": "in_progress",
  "implementation": {
    "current_wave": 1,
    "current_phase": 1,
    "total_phases": 5,
    "completed_phases": [],
    "failed_phases": []
  }
}
```

**Progress**:
```json
{
  "implementation": {
    "current_wave": 2,
    "current_phase": 3,
    "completed_phases": [1, 2],
    "failed_phases": []
  },
  "commits": ["abc123", "def456"]
}
```

**Complete**:
```json
{
  "status": "completed",
  "implementation": {
    "completed_phases": [1, 2, 3, 4, 5],
    "failed_phases": []
  },
  "commits": ["abc123", "def456", "ghi789", "jkl012", "mno345"]
}
```

---

## Success Criteria

- All phases completed successfully
- All tests passed
- All changes committed
- TODO.md updated
- State files updated
- User informed of results
- No critical errors

---

## Partial Success Handling

**If some phases fail**:
- Complete as many phases as possible
- Report successes and failures separately
- Update state with both
- Leave plan status as [IN PROGRESS]
- Provide recovery suggestions

**Output**:
```
⚠️ Implementation Partially Complete: {Project Name}

Completed: {N} of {M} phases

Successful:
  ✓ Phase 1: {description}
  ✓ Phase 2: {description}

Failed:
  ✗ Phase 3: {description}
    Error: {error details}
    
Recovery Options:
1. Fix issue and re-run: /implement {plan_path}
2. Revise plan to skip failed phase
3. Manual intervention required

Commits: {N} created (successful phases only)
```

---

## Time Estimate

Depends entirely on plan:
- Simple plan (2-3 phases, 3-5 hours estimated): 10-30 min actual
- Medium plan (4-6 phases, 6-10 hours estimated): 30-60 min actual
- Complex plan (7+ phases, 10+ hours estimated): 1-2 hours actual

Actual time includes:
- Code generation/modification
- Testing (longest part usually)
- Git operations
- Subagent coordination

Note: Human "hours estimated" in plan refers to manual work. Agent execution is much faster due to automation and parallelism.
