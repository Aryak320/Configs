# Phase Summary Template

Template for phase-level summaries documenting completion of individual implementation phases.

## Usage

Use this template after completing each phase of an implementation plan. This provides granular tracking of progress and helps identify issues early. Phase summaries roll up into the final project summary.

## Template

```markdown
# Phase Summary: {Phase Name}

**Phase Number**: Phase {X}
**Date Completed**: YYYY-MM-DD
**Duration**: {X} hours
**Status**: [COMPLETE] / [PARTIAL] / [BLOCKED]
**Plan Reference**: {path/to/implementation-plan.md#phase-x}

## Phase Overview

### Objective
{What this phase aimed to accomplish}

### Dependencies
- {Dependency 1}: [SATISFIED] / [BLOCKED]
- {Dependency 2}: [SATISFIED] / [BLOCKED]

### Complexity
**Estimated**: {Low/Medium/High}
**Actual**: {Low/Medium/High}

### Time Tracking
- **Estimated Time**: {X} hours
- **Actual Time**: {Y} hours
- **Variance**: {+/-Z} hours ({+/-W}%)

## Tasks Completed

### Task 1: {Task Name}
- **Status**: [COMPLETE] / [PARTIAL] / [SKIPPED]
- **Time Spent**: {X} hours
- **Description**: {What was done}
- **Output**: {Files created/modified}
- **Validation**: {How success was verified}

### Task 2: {Task Name}
- **Status**: [COMPLETE] / [PARTIAL] / [SKIPPED]
- **Time Spent**: {X} hours
- **Description**: {What was done}
- **Output**: {Files created/modified}
- **Validation**: {How success was verified}

### Task 3: {Task Name}
- **Status**: [COMPLETE] / [PARTIAL] / [SKIPPED]
- **Time Spent**: {X} hours
- **Description**: {What was done}
- **Output**: {Files created/modified}
- **Validation**: {How success was verified}

## Deliverables

### Files Created
- `{path/to/file1.ext}`: {Purpose and key features}
- `{path/to/file2.ext}`: {Purpose and key features}

### Files Modified
- `{path/to/file1.ext}`: {Changes made}
- `{path/to/file2.ext}`: {Changes made}

### Tests Added
- `{path/to/test1.ext}`: {What it tests}
- `{path/to/test2.ext}`: {What it tests}

### Documentation Updated
- `{path/to/doc1.md}`: {What was documented}
- `{path/to/doc2.md}`: {What was documented}

## Issues Encountered

### Blockers
1. **{Blocker 1}**
   - **Description**: {What blocked progress}
   - **Resolution**: {How it was resolved or current status}
   - **Time Impact**: {+X} hours

2. **{Blocker 2}**
   - **Description**: {What blocked progress}
   - **Resolution**: {How it was resolved or current status}
   - **Time Impact**: {+X} hours

### Technical Issues
1. **{Issue 1}**
   - **Problem**: {Description of the issue}
   - **Root Cause**: {Why it occurred}
   - **Solution**: {How it was fixed}
   - **Prevention**: {How to avoid in future}

2. **{Issue 2}**
   - **Problem**: {Description}
   - **Root Cause**: {Why it occurred}
   - **Solution**: {How it was fixed}
   - **Prevention**: {How to avoid in future}

### Unexpected Challenges
- {Challenge 1 and how it was handled}
- {Challenge 2 and how it was handled}
- {Challenge 3 and how it was handled}

## Validation Results

### Test Results
- **Unit Tests**: {X}/{Y} passing ({Z}%)
- **Integration Tests**: {X}/{Y} passing ({Z}%)
- **Manual Tests**: {X}/{Y} passing ({Z}%)

### Quality Checks
- **Linter**: [PASS] / [FAIL] - {X} warnings
- **Type Checker**: [PASS] / [FAIL] - {X} errors
- **Code Review**: [APPROVED] / [CHANGES REQUESTED]

### Acceptance Criteria
- [ ] {Criterion 1}: {Status/Notes}
- [ ] {Criterion 2}: {Status/Notes}
- [ ] {Criterion 3}: {Status/Notes}

## Metrics

### Code Changes
- **Lines Added**: {X}
- **Lines Removed**: {Y}
- **Net Change**: {Z}
- **Files Changed**: {N}

### Performance Impact
- **Build Time**: {Before} → {After}
- **Test Time**: {Before} → {After}
- **{Custom Metric}**: {Before} → {After}

### Quality Metrics
- **Test Coverage**: {X}% (change: {+/-Y}%)
- **Complexity**: {Metric and change}
- **Documentation**: {X}% coverage

## Lessons Learned

### What Went Well
1. {Success 1 and why it worked}
2. {Success 2 and why it worked}
3. {Success 3 and why it worked}

### What Could Improve
1. {Area 1 and suggested improvement}
2. {Area 2 and suggested improvement}
3. {Area 3 and suggested improvement}

### Technical Notes
- {Note about implementation approach}
- {Note about technology/tool usage}
- {Note about architecture decision}

### Process Notes
- {Note about workflow efficiency}
- {Note about communication}
- {Note about planning accuracy}

## Next Steps

### Immediate Actions
1. {Action item with owner and deadline}
2. {Action item with owner and deadline}
3. {Action item with owner and deadline}

### Dependencies for Next Phase
- {Dependency 1}: [READY] / [PENDING]
- {Dependency 2}: [READY] / [PENDING]
- {Dependency 3}: [READY] / [PENDING]

### Risks and Concerns
- {Risk 1}: {Mitigation strategy}
- {Risk 2}: {Mitigation strategy}
- {Risk 3}: {Mitigation strategy}

### Recommendations
1. {Recommendation for next phase}
2. {Recommendation for next phase}
3. {Recommendation for next phase}

## Metadata

- **Phase**: {X} of {Y}
- **Wave**: {N}
- **Author**: {Name}
- **Reviewers**: {Names}
- **Related Phases**: Phase {A}, Phase {B}
- **Tags**: {tag1}, {tag2}, {tag3}
```

## Notes

- Complete this template immediately after finishing each phase
- Be specific about time spent and variance from estimates
- Document all issues encountered, even if resolved
- Include concrete metrics and validation results
- Keep lessons learned actionable for future phases
- Update next steps section to guide subsequent work
