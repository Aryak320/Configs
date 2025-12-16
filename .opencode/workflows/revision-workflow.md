# Revision Workflow

**Agent**: Reviser
**Trigger**: `/revise` command with plan path and revision instructions
**Purpose**: Update existing implementation plan with new requirements or changes

---

## Workflow Steps

### 1. Read Existing Plan

**Actions**:
- Read current plan version (v1, v2, etc.)
- Understand existing phases and structure
- Note current plan status (not started, in progress, completed)
- Check for any blockers or issues

---

### 2. Analyze Revision Request

**Actions**:
- Parse revision prompt for specific changes
- Identify type of revision:
  - Add new phases
  - Modify existing phases
  - Remove phases
  - Change dependencies/order
  - Update based on new information

---

### 3. Conduct Additional Research (If Needed)

**Actions**:
- Determine if new research is required
- If yes:
  - Invoke relevant research subagents
  - Create new research reports
  - Link to project research directory
  - Update references in new plan version

**When Research Needed**:
- New features not covered in original research
- Technology/approach changes
- New constraints or requirements
- Discovered unknowns during implementation

---

### 4. Create New Plan Version

**Actions**:
- Increment version number (v1 → v2, v2 → v3, etc.)
- Preserve old version(s) for history
- Update plan with requested changes
- Maintain consistent structure
- Update metadata

**Versioning**:
```
plans/
  implementation_v1.md   (preserved)
  implementation_v2.md   (new version)
```

---

### 5. Update Plan Content

**Changes May Include**:

#### Adding Phases
```markdown
### Wave 3 (New)

#### Phase 6: Performance Benchmarking
- **Dependencies**: Phase 1, 2, 3, 4, 5
- **Complexity**: Low
- **Tasks**:
  1. Run startup time benchmarks
  2. Compare against baseline
  3. Document improvements
```

#### Modifying Phases
- Update task lists
- Change complexity estimates
- Adjust time estimates
- Modify validation criteria

#### Removing Phases
- Remove entire phase section
- Update dependent phase references
- Adjust wave organization

#### Reordering Phases
- Reorganize waves
- Update dependencies
- Maintain logical flow

---

### 6. Update Metadata

**Actions**:
- Set version to new number
- Update "Based On" to include new research if any
- Add revision notes
- Update estimated duration
- Maintain status tracking

**Metadata Updates**:
```markdown
**Version**: v2
**Status**: [NOT STARTED] or [IN PROGRESS]
**Previous Version**: v1
**Revised**: YYYY-MM-DD
**Revision Reason**: {Why plan was revised}
**New Research**: {Links to new research reports if any}
```

---

### 7. Update TODO.md (If Needed)

**Actions**:
- Update project entry with new version
- Note revision in description
- Keep status current

**Example**:
```markdown
## Not Started

- [ ] 001_lazy_loading_optimization: Optimize plugin lazy-loading (REVISED v2)
  - Plan: .opencode/specs/001_lazy_loading_optimization/plans/implementation_v2.md
  - Changes: Added performance benchmarking phase
```

---

### 8. Commit to Git

**Actions**:
- Stage new plan version
- Stage new research reports (if any)
- Stage updated TODO.md (if changed)
- Preserve old versions
- Create commit

**Commit Format**:
```
plan: revise {project_name} to v{N}

- Revision reason: {reason}
- Changes: {summary of changes}
- New research: {list if any}
- Previous version: v{N-1} (preserved)
```

---

### 9. Return Summary

**Actions**:
- Provide user with new plan version path
- Summarize changes made
- Link to new research if any
- Note preserved versions
- Suggest next steps

**Output Format**:
```
✅ Plan Revised: {Project Name}

New Version: .opencode/specs/{NNN_project_name}/plans/implementation_v{N}.md
Previous Version: implementation_v{N-1}.md (preserved)

Changes:
- {Change 1}
- {Change 2}
- {Change 3}

New Research (if any):
- {Report 1}
- {Report 2}

Next Steps:
/implement .opencode/specs/{NNN_project_name}/plans/implementation_v{N}.md

Commit: {hash}
```

---

## Revision Scenarios

### Scenario 1: Add New Phase

**Trigger**: User discovers missing functionality

**Action**:
- Add new phase to appropriate wave
- Update dependencies
- Adjust total phase count
- Update time estimates

---

### Scenario 2: Implementation Blocker

**Trigger**: Phase cannot be completed as planned

**Action**:
- Research alternative approaches
- Revise blocked phase
- Possibly split into multiple phases
- Update dependencies

---

### Scenario 3: New Requirements

**Trigger**: User wants additional features

**Action**:
- Conduct research on new requirements
- Add phases for new features
- Organize into new or existing waves
- Update plan scope

---

### Scenario 4: Simplify Plan

**Trigger**: Plan too complex or time-consuming

**Action**:
- Remove or consolidate phases
- Simplify tasks
- Reduce scope
- Update estimates

---

## Error Handling

### Plan Not Found

**Action**:
- Return error to user
- Verify plan path
- Cannot proceed without existing plan

### Plan Already Completed

**Action**:
- Warn user
- Allow revision anyway (for future re-implementation)
- Note in metadata

### Invalid Revision Request

**Action**:
- Ask for clarification
- Provide suggestions
- Use best judgment for interpretation

---

## Version Management

### Preservation Strategy

- **Always** preserve old versions
- Never overwrite existing plans
- Maintain version history
- Allow rollback to previous versions

### Version Naming

- v1, v2, v3, etc.
- No decimals (not v1.1, just v2)
- Sequential numbering

---

## State Updates

**state.json** updated with:
```json
{
  "status": "planning",
  "plans": [
    {
      "version": "v1",
      "path": "plans/implementation_v1.md",
      "status": "superseded"
    },
    {
      "version": "v2",
      "path": "plans/implementation_v2.md",
      "status": "not_started",
      "created": "timestamp"
    }
  ]
}
```

---

## Success Criteria

- New plan version created
- Old version(s) preserved
- Changes properly integrated
- New research linked (if any)
- Metadata updated
- Committed to git
- State files updated
- User informed of changes

---

## Time Estimate

- Simple revision (minor changes): 2-5 minutes
- Medium revision (new phases): 5-10 minutes
- Complex revision (new research + phases): 10-20 minutes

Time depends on:
- Extent of changes
- Need for additional research
- Complexity of new requirements
- Number of dependencies affected
