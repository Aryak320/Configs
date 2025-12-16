# Phase 2: Implementer Agent Updates

**Effort**: 3 hours  
**Priority**: Critical  
**Status**: Not Started  
**Dependencies**: Phase 10 (Backups)

---

## Overview

Update the implementer agent with critical instructions, tool usage documentation, and explicit task() examples for wave-based parallel execution.

**Files Modified**:
- `.opencode/agent/implementer.md`
- `.opencode/command/implement.md`

**Changes**:
1. Add critical instructions section (mandatory delegation)
2. Add tool usage documentation
3. Update ExecutePhase stage with explicit task() examples
4. Update Subagent Coordination section
5. Add delegation examples section
6. Update /implement command with delegation behavior

---

## Prerequisites

- [ ] Phase 10 (Backups) completed
- [ ] Backups exist at `.opencode/backups/pre-delegation-optimization/`

---

## Steps

### Step 1: Add Critical Instructions (45 min)

**File**: `.opencode/agent/implementer.md`  
**Location**: After line 42 (after "## Core Responsibilities"), before `<implementation_workflow>`

See full plan lines 469-629 for complete critical instructions and tool usage sections.

**Key sections**:
- Mandatory delegation instruction
- Delegation workflow instruction
- Parallel execution instruction
- Tool usage for all tools (task, read, write, edit, bash)

### Step 2: Update ExecutePhase Stage (1 hour)

**File**: `.opencode/agent/implementer.md`  
**Location**: Lines 131-173 (Stage 5: ExecutePhase)

See full plan lines 636-774 for complete updated ExecutePhase stage.

**Key changes**:
- Add explicit task() invocations for code generation
- Add explicit task() invocations for code modification
- Add explicit task() invocations for testing
- Add explicit task() invocations for documentation
- Include validation steps

### Step 3: Update Subagent Coordination (45 min)

**File**: `.opencode/agent/implementer.md`  
**Location**: Lines 334-385

See full plan lines 781-891 for complete updated subagent coordination section.

**Key changes**:
- Add subagent paths
- Add invocation examples
- Show parallel execution pattern
- Include error handling details

### Step 4: Add Delegation Examples (30 min)

**File**: `.opencode/agent/implementer.md`  
**Location**: After subagent_coordination section (after line 385)

See full plan lines 988-1097 for complete delegation examples.

**Examples to include**:
1. Single phase code generation
2. Single phase code modification
3. Wave with 3 parallel phases

### Step 5: Update /implement Command (30 min)

**File**: `.opencode/command/implement.md`  
**Location**: After `<instructions>` section (after line 34)

See full plan lines 1109-1186 for complete delegation behavior section.

---

## Testing

### Manual Test
1. Read updated implementer.md
2. Verify critical instructions are prominent
3. Check task() examples are concrete
4. Confirm delegation examples are clear

---

## Commit

### Message
```
feat(agents): add delegation enforcement to implementer agent

- Add critical instructions section with mandatory delegation
- Add tool usage documentation for all tools
- Update ExecutePhase stage with explicit task() examples
- Update Subagent Coordination with paths and examples
- Add delegation examples showing wave-based execution
- Update /implement command with delegation behavior explanation

Phase 2 of 10: Implementer agent delegation optimization
Affects: implementer.md, implement.md
```

---

## Checklist

- [ ] Step 1: Critical instructions added
- [ ] Step 2: ExecutePhase stage updated
- [ ] Step 3: Subagent Coordination updated
- [ ] Step 4: Delegation examples added
- [ ] Step 5: /implement command updated
- [ ] All validations passed
- [ ] Changes tested
- [ ] Git commit created
- [ ] Phase marked complete in OVERVIEW.md

---

## Next Phase

**Phase 3**: Reviser Agent Updates (1.5 hours)

---

**Status**: Not Started  
**Last Updated**: 2025-12-15  
**Note**: See full plan (lines 469-1186) for complete implementation details
