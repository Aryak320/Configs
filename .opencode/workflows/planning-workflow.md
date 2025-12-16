# Planning Workflow

**Agent**: Planner
**Trigger**: `/plan` command with OVERVIEW.md path
**Purpose**: Create phased implementation plan from research findings

---

## Workflow Steps

### 1. Read Research

**Actions**:
- Read OVERVIEW.md at provided path
- Extract key findings and recommendations
- Understand research context
- Identify implementation scope

**Note**: Planner reads OVERVIEW.md which contains summaries, not full detailed reports. This preserves context efficiency.

---

### 2. Analyze Requirements

**Actions**:
- Parse planning prompt for specific instructions
- Identify goals and constraints
- Determine complexity level
- Estimate time requirements
- Check STANDARDS.md for compliance requirements

---

### 3. Break into Phases

**Actions**:
- Divide work into logical phases
- Each phase should be:
  - Self-contained
  - Testable
  - Committable
  - 1-4 hours of work

**Phase Structure**:
```markdown
#### Phase N: {Phase Name}
- **Dependencies**: {List of prerequisite phases}
- **Complexity**: Low/Medium/High
- **Estimated Time**: X hours
- **Tasks**:
  1. {Specific task}
  2. {Specific task}
- **Validation**: {How to verify completion}
```

---

### 4. Organize into Waves

**Actions**:
- Group independent phases into waves
- Phases within a wave can execute in parallel
- Sequential waves enforce dependencies

**Wave Organization**:
- Wave 1: All phases with no dependencies
- Wave 2: Phases depending on Wave 1
- Wave 3: Phases depending on Wave 2
- etc.

**Example**:
```
Wave 1 (Parallel):
  Phase 1: Add lazy-loading to telescope (no deps)
  Phase 2: Add lazy-loading to nvim-tree (no deps)

Wave 2 (Parallel):
  Phase 3: Update keybindings (depends on Phase 1, 2)
  Phase 4: Update docs (depends on Phase 1, 2)
```

---

### 5. Create Implementation Plan

**Actions**:
- Write implementation_v1.md in project plans/ directory
- Include all phases with full details
- Add testing strategy
- Include rollback plan
- Add metadata (version, status, timestamps)

**Plan Template**:
```markdown
# Implementation Plan: {Project Name}

**Version**: v1
**Status**: [NOT STARTED]
**Created**: YYYY-MM-DD
**Based On**: Research OVERVIEW at {path}

## Overview
{What will be implemented}

## Goals
- {Goal 1}
- {Goal 2}

## Phases

### Wave 1
{Phase definitions}

### Wave 2
{Phase definitions}

## Testing Strategy
{Testing approach}

## Rollback Plan
{How to undo if needed}

## Metadata
- Total Phases: {N}
- Total Waves: {N}
- Estimated Duration: {X} hours
```

---

### 6. Update TODO.md

**Actions**:
- Add project to "Not Started" section
- Include project name and plan path
- Format: `- [ ] {project_name}: {brief description}`

**Example**:
```markdown
## Not Started

- [ ] 001_lazy_loading_optimization: Optimize plugin lazy-loading for 150ms startup improvement
  - Plan: .opencode/specs/001_lazy_loading_optimization/plans/implementation_v1.md
```

---

### 7. Commit to Git

**Actions**:
- Stage implementation_v1.md and TODO.md
- Create commit with conventional format
- Update state.json

**Commit Format**:
```
plan: create {project_name} implementation plan

- {N} phases across {M} waves
- Estimated duration: {X} hours
- Key phases: {highlight main phases}
```

---

### 8. Return Summary

**Actions**:
- Provide user with plan path
- Summarize plan structure
- Highlight key phases
- Suggest next step (implementation)
- Return commit hash

**Output Format**:
```
✅ Plan Created: {Project Name}

Plan: .opencode/specs/{NNN_project_name}/plans/implementation_v1.md

Plan Structure:
- Total Phases: {N}
- Total Waves: {M}
- Estimated Duration: {X} hours

{Wave summaries}

Next Steps:
/implement .opencode/specs/{NNN_project_name}/plans/implementation_v1.md

Commit: {hash}
```

---

## Phase Design Principles

### Good Phase Characteristics

- **Atomic**: Complete, self-contained unit of work
- **Testable**: Clear validation criteria
- **Reversible**: Can be undone via git
- **Documented**: Includes what and why
- **Estimated**: Realistic time estimate (1-4 hours)

### Phase Dependencies

- **None**: Can run in Wave 1
- **Single**: Depends on one phase (Wave N+1)
- **Multiple**: Depends on multiple phases (Wave N+1)
- **Circular**: Not allowed, must be broken

---

## Wave Organization Strategy

### Maximize Parallelism

- Put as many phases as possible in early waves
- Only sequential when dependencies require it
- Typical distribution: Wave 1 has 40-60% of phases

### Balance Wave Sizes

- Avoid waves with single phase (unless necessary)
- Prefer 2-4 phases per wave for efficiency
- Last wave often has documentation/cleanup

---

## Error Handling

### Missing OVERVIEW.md

**Action**:
- Return error to user
- Suggest running research first
- Cannot proceed without research

### Invalid Planning Prompt

**Action**:
- Use research recommendations as fallback
- Create reasonable default plan
- Note assumption in plan

### Circular Dependencies

**Action**:
- Detect during phase organization
- Break circular dependencies
- Document in plan notes

---

## Success Criteria

- Valid implementation_v1.md created
- All phases have clear tasks and validation
- Dependencies properly organized into waves
- TODO.md updated
- Plan committed to git
- State files updated

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
      "status": "not_started",
      "created": "timestamp"
    }
  ]
}
```

---

## Time Estimate

- Simple plan (1-2 phases): 1-2 minutes
- Medium plan (3-5 phases): 2-4 minutes
- Complex plan (6+ phases): 5-10 minutes

Planning time scales with:
- Number of phases
- Complexity of tasks
- Dependency complexity
- Testing requirements
