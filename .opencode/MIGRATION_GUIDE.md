# Migration Guide: Hierarchical Agent Architecture

**Purpose**: Step-by-step guide for migrating OpenCode agents to hierarchical coordination pattern with 95%+ context reduction.

**Applies To**: All OpenCode agents that could benefit from multi-task coordination (lean, debug, analysis, etc.)

**Reference Implementation**: Research agent (v2.0.0)

---

## When to Use Hierarchical Architecture

### Use Hierarchical Pattern When:

✅ **Multi-task workflows** with 3+ parallel tasks  
✅ **Large outputs** (>10,000 tokens total per iteration)  
✅ **Context reduction critical** (need 10+ iterations)  
✅ **Parallel execution beneficial** (40-60% time savings)  
✅ **Clear task decomposition** (topics, phases, test suites, etc.)

### Keep Flat Pattern When:

❌ Single-task workflows  
❌ Small outputs (<5,000 tokens total)  
❌ Sequential dependencies (no parallelization)  
❌ Simple coordination (no decomposition needed)

---

## Migration Steps

### Step 1: Analyze Current Agent

**Questions to Answer**:
1. How many tasks does the agent coordinate? (If ≥3, proceed)
2. What is the total token count per iteration? (If ≥10,000, proceed)
3. Can tasks run in parallel? (If yes, major benefit)
4. Is task decomposition clear? (If yes, proceed)

**Example Analysis** (Research Agent):
- Tasks: 1-5 research topics (≥3 in most cases) ✓
- Token count: 3 topics × 2,500 = 7,500 tokens ✓
- Parallel: Yes, topics independent ✓
- Decomposition: Clear (one specialist per topic) ✓
- **Decision**: Migrate to hierarchical ✓

### Step 2: Design Three-Tier Structure

**Define Tier Responsibilities**:

| Tier | Role | Agent File | Responsibilities |
|------|------|-----------|------------------|
| **Tier 1** | Primary Agent | `agent/[name].md` | Parse request, pre-calculate paths, invoke coordinator, validate outputs, generate summaries |
| **Tier 2** | Coordinator | `subagents/[name]-coordinator.md` | Decompose tasks, create invocation plan, return metadata |
| **Tier 3** | Specialist | `subagents/[name]-specialist.md` | Execute single task, create artifact, return signal |

**Research Agent Example**:
- **Tier 1**: `agent/research.md` - Parse research request, determine complexity, invoke coordinator
- **Tier 2**: `subagents/research-coordinator.md` - Decompose into 2-5 topics, return invocations
- **Tier 3**: `subagents/research-specialist.md` - Research one topic, create report

### Step 3: Choose Coordinator Mode

**Two Modes Available**:

#### Mode 1: Planning-Only (Recommended for Most Cases)

**How It Works**:
```
Primary Agent → Coordinator (creates invocation plan, returns metadata)
Primary Agent → Specialists (invokes based on plan, parallel)
Primary Agent ← Specialists (validates outputs, aggregates metadata)
```

**Benefits**:
- Primary agent retains control over specialist invocation
- Easier hard barrier enforcement
- Better debugging (explicit Task invocations in primary agent)
- Lower context consumption in coordinator (5-10%)

**Use When**:
- Primary agent needs explicit control over specialist invocation
- Hard barrier enforcement is critical
- Debugging visibility is important

**Example**: Research agent (research-coordinator returns invocations, primary agent invokes specialists)

#### Mode 2: Supervisor (Use for Complex Coordination)

**How It Works**:
```
Primary Agent → Coordinator (full supervision)
Coordinator → Specialists (coordinator invokes, manages, aggregates)
Coordinator → Primary Agent (returns brief summary)
```

**Benefits**:
- Coordinator handles all specialist management
- Wave-based parallel execution (dependency analysis)
- Brief summary format (96% context reduction)

**Use When**:
- Complex wave-based coordination needed
- Dependency analysis required
- Coordinator-level orchestration simplifies primary agent

**Example**: Claude Code's implementer-coordinator (manages wave-based phase execution)

**Recommendation for OpenCode**: Start with **Planning-Only Mode** for simplicity.

### Step 4: Enhance Specialist Agent

**Add to Specialist** (`subagents/[name]-specialist.md`):

#### 4.1: Input Validation (STEP 1)

```markdown
## STEP 1: Receive and Verify Input Contract

**MANDATORY INPUT VERIFICATION**: You will receive:
- `task_description`: The specific task to execute (string)
- `output_path`: Absolute path where artifact must be created (string)
- `topic_path`: Absolute path to parent topic directory (string)

**Input Validation**:
If output_path is missing:
  ERROR_CONTEXT: {"error_type":"validation_error","message":"Missing output_path"}
  TASK_ERROR: validation_error - Missing output_path field
  Exit with error
```

#### 4.2: YAML Frontmatter (STEP 4)

```markdown
## STEP 4: Finalize Artifact with Metadata

**Update YAML Frontmatter**:
```yaml
---
artifact_type: [research/implementation/test/debug]
topic: "[task description]"
items_count: [count of items completed]
created_date: [YYYY-MM-DD]
status: complete
---
```

**Required Fields**:
- `artifact_type`: Type of artifact created
- `topic`: Task description
- `items_count`: Numeric count (findings, tasks, tests, etc.)
- `created_date`: Date created
- `status`: "in_progress" or "complete"
```

#### 4.3: Completion Signal (STEP 6)

```markdown
## STEP 6: Return Completion Signal

**RETURN ONLY**:
```
ARTIFACT_CREATED: [absolute path to artifact file from output_path]
```

**Example**:
```
ARTIFACT_CREATED: /home/benjamin/.config/.opencode/specs/042_topic/reports/001_report.md
```
```

#### 4.4: Error Handling

```markdown
**Error Handling Protocol**:

If input validation fails:
  ERROR_CONTEXT: {"error_type":"validation_error","message":"[error]","details":{...}}
  TASK_ERROR: validation_error - [error description]

If file creation fails:
  ERROR_CONTEXT: {"error_type":"file_error","message":"Cannot create file","details":{"path":"[path]"}}
  TASK_ERROR: file_error - Cannot create file at [path]

If task execution fails:
  ERROR_CONTEXT: {"error_type":"execution_error","message":"Task failed","details":{"reason":"[reason]"}}
  TASK_ERROR: execution_error - Task execution failed: [reason]
```

### Step 5: Create/Enhance Coordinator Agent

**Create** `subagents/[name]-coordinator.md`:

#### 5.1: Input Validation (STEP 1)

```markdown
## STEP 1: Validate Input Contract

**MANDATORY INPUT VERIFICATION**:
- `request`: The user's request (string)
- `complexity`: Complexity level 1-4 (integer)
- `output_dir`: Absolute path to output directory (string)
- `topic_path`: Absolute path to topic directory (string)

**Input Validation**:
If output_dir missing:
  ERROR_CONTEXT: {"error_type":"validation_error","message":"Missing output_dir"}
  TASK_ERROR: validation_error - Missing output_dir field
  Exit with error

If output_dir does not exist:
  ERROR_CONTEXT: {"error_type":"file_error","message":"Output directory missing","details":{"path":"[output_dir]"}}
  TASK_ERROR: file_error - Output directory missing: [output_dir]
  Exit with error
```

#### 5.2: Task Decomposition (STEP 2)

```markdown
## STEP 2: Task Decomposition

**Complexity-Based Task Count**:
- Complexity 1-2: 2 tasks
- Complexity 3: 3 tasks
- Complexity 4: 4 tasks

**Decompose Request** into [task_count] focused sub-tasks.

**Example**:
Request: "Research Lean 4 proof automation"
Complexity: 3
Tasks:
  1. "Lean 4 Tactic Libraries"
  2. "Custom Tactic Development"
  3. "Mathlib Automation"
```

#### 5.3: Invocation Plan File (STEP 3)

```markdown
## STEP 3: Create Invocation Plan File

**EXECUTE NOW**: Use Write tool to create invocation plan.

**Invocation Plan Path**: `[topic_path]/.invocation-plan.txt`

**Content**:
```
[Agent Type] Coordination Plan
Generated: [timestamp]
Request: [request]
Complexity: [complexity]

Expected Invocations: [task_count]

Task Assignments:
[0] [tasks[0]] -> [output_paths[0]]
[1] [tasks[1]] -> [output_paths[1]]
...

Status: PLAN_COMPLETE
```
```

#### 5.4: Return Metadata (STEP 4)

```markdown
## STEP 4: Return Invocation Metadata

**RETURN FORMAT**:
```
[AGENT_TYPE]_COORDINATOR_COMPLETE: SUCCESS
coordinator_type: [agent_type]
tasks_planned: [task_count]
invocation_plan_path: [absolute path to .invocation-plan.txt]
context_usage_percent: 8

INVOCATION_PLAN_READY: [task_count]
invocations: [
  {"task": "[tasks[0]]", "output_path": "[output_paths[0]]"},
  {"task": "[tasks[1]]", "output_path": "[output_paths[1]]"},
  ...
]
```

**Example**:
```
RESEARCH_COORDINATOR_COMPLETE: SUCCESS
coordinator_type: research
tasks_planned: 3
invocation_plan_path: /home/benjamin/.config/.opencode/specs/042_topic/.invocation-plan.txt
context_usage_percent: 8

INVOCATION_PLAN_READY: 3
invocations: [
  {"task": "Topic 1", "output_path": "/path/001_topic1.md"},
  {"task": "Topic 2", "output_path": "/path/002_topic2.md"},
  {"task": "Topic 3", "output_path": "/path/003_topic3.md"}
]
```
```

### Step 6: Overhaul Primary Agent

**Update** `agent/[name].md`:

#### 6.1: Argument Capture (STEP 1)

```markdown
## STEP 1: Argument Capture and Complexity Detection

**Parse User Request**:
Extract the request from user's message.

**Determine Complexity** (1-4):
Analyze request scope:
- Complexity 1-2: Simple (2 tasks)
- Complexity 3: Moderate (3 tasks)
- Complexity 4: Comprehensive (4 tasks)

**Set Variables**:
- REQUEST: Full user request
- COMPLEXITY: Integer 1-4
- TASK_COUNT: 2, 3, or 4
```

#### 6.2: Path Pre-Calculation (STEP 2)

```markdown
## STEP 2: Path Pre-Calculation (Hard Barrier Pattern)

**Generate Topic Slug**:
- Convert request to snake_case
- Lowercase, max 30 chars
- Remove special characters

**Increment Counter**:
1. Read `.opencode/specs/.counter`
2. Increment by 1
3. Write back to `.opencode/specs/.counter`
4. Format as 3 digits (001, 002, etc.)

**Create Topic Directory**:
TOPIC_DIR = /home/benjamin/.config/.opencode/specs/[NNN]_[slug]
Create: [TOPIC_DIR]/outputs/

**Pre-Calculate Output Paths**:
For i in range(0, TASK_COUNT):
  output_number = (i + 1) formatted as 3 digits
  output_path = [TOPIC_DIR]/outputs/[output_number]_task.md
  OUTPUT_PATHS.append(output_path)
```

#### 6.3: Coordinator Invocation (STEP 3)

```markdown
## STEP 3: Invoke Coordinator (Planning-Only)

**EXECUTE NOW**: USE the task tool to invoke coordinator.

Task {
  subagent_type: "general-purpose"
  description: "Decompose request and create invocation plan"
  prompt: |
    Read and follow: /home/benjamin/.config/.opencode/subagents/[name]-coordinator.md
    
    **Input Contract**:
    - request: "[REQUEST]"
    - complexity: [COMPLEXITY]
    - output_dir: [TOPIC_DIR]/outputs
    - topic_path: [TOPIC_DIR]
}

**Parse Coordinator Output**:
Extract:
- tasks_planned
- invocation_plan_path
- invocations array

**Error Handling**:
If output contains "TASK_ERROR:":
  Parse error signal
  Log to errors.jsonl
  Display error to user
  Exit workflow
```

#### 6.4: Specialist Invocation (STEP 4)

```markdown
## STEP 4: Invoke Specialists (Parallel)

**EXECUTE NOW**: USE the task tool to invoke ALL specialists IN PARALLEL.

For EACH invocation in invocations array:

Task {
  subagent_type: "general-purpose"
  description: "Execute [task from invocation]"
  prompt: |
    Read and follow: /home/benjamin/.config/.opencode/subagents/[name]-specialist.md
    
    **Input Contract**:
    - task_description: "[task from invocation]"
    - output_path: [output_path from invocation]
    - topic_path: [TOPIC_DIR]
}

**Critical**: All Task invocations in SAME message block (parallel execution).
```

#### 6.5: Hard Barrier Validation (STEP 5)

```markdown
## STEP 5: Hard Barrier Validation

**Validate Each Output Exists**:
For each output_path in invocations array:
  If file exists: Add to SUCCESSFUL_OUTPUTS
  If missing: Add to FAILED_OUTPUTS

**Calculate Success Rate**:
SUCCESS_RATE = (SUCCESSFUL_COUNT / TOTAL_COUNT) × 100

**Apply Threshold**:
If SUCCESS_RATE < 50%:
  Log error to errors.jsonl
  Display: "ERROR: <50% threshold"
  Exit with error

Else if SUCCESS_RATE < 100%:
  Log warning to errors.jsonl
  Display: "WARNING: Partial success ([SUCCESS_RATE]%)"
  Continue

Else:
  Display: "SUCCESS: All tasks complete"
  Continue
```

#### 6.6: Metadata Extraction (STEP 6)

```markdown
## STEP 6: Metadata Extraction (Context Reduction)

**For EACH successful output**:
1. Read first 20 lines (YAML frontmatter only)
2. Extract: topic, items_count, created_date, status
3. Build metadata object (110 tokens)

**Aggregate Metadata**:
METADATA_ARRAY = []
TOTAL_ITEMS = 0

For each successful output:
  metadata = extract_metadata(output_path)
  METADATA_ARRAY.append(metadata)
  TOTAL_ITEMS += metadata.items_count

**Context Reduction**:
Baseline: [SUCCESSFUL_COUNT] × 2,500 = [BASELINE] tokens
Hierarchical: [SUCCESSFUL_COUNT] × 110 = [METADATA_TOKENS] tokens
Reduction: ([BASELINE] - [METADATA_TOKENS]) / [BASELINE] × 100%
```

#### 6.7: Summary Synthesis (STEP 7)

```markdown
## STEP 7: OVERVIEW.md Synthesis (Metadata-Based)

**EXECUTE NOW**: Use Write tool to create OVERVIEW.md.

**Template**:
```markdown
# [Agent Type] Overview: [REQUEST]

**Date**: [YYYY-MM-DD]
**Tasks Completed**: [SUCCESSFUL_COUNT]/[TOTAL_COUNT] ([SUCCESS_RATE]%)
**Total Items**: [TOTAL_ITEMS]

## Executive Summary
[3-5 sentence summary based on metadata]

## Task Results
For each task in METADATA_ARRAY:
### [topic]
- **Items**: [items_count]
- **Output**: [relative link to output file]

[If FAILED_OUTPUTS not empty]:
## Failed Tasks
- [Failed task 1]
- [Failed task 2]
```
```

#### 6.8: Console Summary (STEP 8)

```markdown
## STEP 8: Console Summary Generation

**Display Summary** (4-section format):
```
═══════════════════════════════════════════════════════════════
📊 [AGENT TYPE] COMPLETE
═══════════════════════════════════════════════════════════════

## Summary
Request: [REQUEST]
Status: [SUCCESS/PARTIAL SUCCESS] ([SUCCESS_RATE]%)
Tasks Completed: [SUCCESSFUL_COUNT]/[TOTAL_COUNT]
Total Items: [TOTAL_ITEMS]

## Task Results
✓ [task 1] - [items_count] items
✓ [task 2] - [items_count] items
[If failures]:
✗ [failed task]

## Artifacts
📁 Project Directory: [TOPIC_DIR]
📄 Overview: [TOPIC_DIR]/OVERVIEW.md
📋 Outputs: [SUCCESSFUL_COUNT] files in outputs/
📝 Invocation Plan: [TOPIC_DIR]/.invocation-plan.txt

## Performance Metrics
⚡ Parallel Execution: [TOTAL_COUNT] specialists simultaneously
📉 Context Reduction: [REDUCTION_PERCENT]%
⏱️  Time Savings: ~[TIME_SAVINGS]% vs sequential

═══════════════════════════════════════════════════════════════
```
```

### Step 7: Add Error Logging

**Create/Update** `.opencode/errors.jsonl`:

#### 7.1: Initialize Error Logging (Primary Agent)

```markdown
## INITIALIZATION: Error Logging Setup

**Set Workflow Metadata**:
WORKFLOW_ID = "[agent_type]_" + [nanosecond_timestamp]
COMMAND_NAME = "[agent-mode]"
ERROR_LOG_PATH = "/home/benjamin/.config/.opencode/errors.jsonl"

**Error Logging Function**:
log_error(error_type, error_message, error_details):
  error_entry = {
    "timestamp": [ISO 8601],
    "workflow_id": WORKFLOW_ID,
    "command": COMMAND_NAME,
    "error_type": error_type,
    "message": error_message,
    "details": error_details
  }
  Append JSON line to ERROR_LOG_PATH
```

#### 7.2: Log Errors Throughout Workflow

**Coordinator Errors**:
```
If coordinator returns TASK_ERROR:
  log_error(
    error_type=ERROR_TYPE,
    error_message="Coordinator failed: " + ERROR_MESSAGE,
    error_details=ERROR_CONTEXT
  )
```

**Specialist Errors**:
```
If specialist returns TASK_ERROR:
  log_error(
    error_type=ERROR_TYPE,
    error_message="Specialist failed: [task]",
    error_details={"task": [task], "output_path": [path], "error_context": ERROR_CONTEXT}
  )
```

**Validation Errors**:
```
If SUCCESS_RATE < 50%:
  log_error(
    error_type="validation_error",
    error_message="Validation failed: <50% threshold",
    error_details={"total": TOTAL, "successful": SUCCESSFUL, "failed_tasks": [list]}
  )
```

### Step 8: Test Migration

**Test Checklist**:
- [ ] Path pre-calculation works (topic directory created)
- [ ] Coordinator invocation succeeds (invocation plan created)
- [ ] Specialist invocations parallel (all tasks run simultaneously)
- [ ] Hard barrier validation works (catches missing outputs)
- [ ] Metadata extraction works (YAML frontmatter parsed)
- [ ] OVERVIEW.md synthesis works (metadata-based)
- [ ] Console summary displays correctly
- [ ] Error logging works (errors.jsonl populated)
- [ ] Partial success mode works (50%, 75% scenarios)

**Test Scenarios**:
1. **100% Success**: All tasks complete successfully
2. **Partial Success (75%)**: 3/4 tasks succeed
3. **Partial Success (50%)**: 2/4 tasks succeed (should warn, continue)
4. **Critical Failure (25%)**: 1/4 tasks succeed (should error, exit)
5. **Coordinator Failure**: Coordinator returns TASK_ERROR
6. **Specialist Failure**: One specialist returns TASK_ERROR

---

## Expected Benefits

### Context Reduction

| Tasks | Baseline | Hierarchical | Reduction |
|-------|----------|-------------|-----------|
| 2     | 5,000    | 220         | 95.6%     |
| 3     | 7,500    | 330         | 95.6%     |
| 4     | 10,000   | 440         | 95.6%     |

### Time Savings

| Tasks | Sequential | Parallel | Savings |
|-------|-----------|----------|---------|
| 2     | 60s       | 30s      | 50%     |
| 3     | 90s       | 30s      | 67%     |
| 4     | 120s      | 30s      | 75%     |

### Iteration Capacity

```
Context Budget: 200,000 tokens

Before (3 tasks, full content):
  7,500 tokens/iteration
  26 iterations max

After (3 tasks, metadata):
  330 tokens/iteration
  606 iterations max

Increase: 23.3×
```

---

## Common Issues and Solutions

### Issue: Specialist Outputs Missing

**Symptom**: Hard barrier validation fails, outputs don't exist

**Causes**:
1. Specialist didn't receive correct `output_path`
2. Specialist failed silently
3. Output path pre-calculation incorrect

**Fix**:
- Verify invocations array parsing (STEP 4)
- Check specialist receives absolute paths
- Validate output directory exists before specialist invocation

### Issue: Metadata Extraction Fails

**Symptom**: OVERVIEW.md missing counts, metadata incomplete

**Causes**:
1. YAML frontmatter missing in specialist outputs
2. Frontmatter format incorrect
3. Primary agent reading full files instead of first 20 lines

**Fix**:
- Verify specialist creates frontmatter in STEP 4
- Check frontmatter format matches schema
- Update primary agent to read only first 20 lines

### Issue: Partial Success Mode Not Working

**Symptom**: Workflow exits even with ≥50% success

**Causes**:
1. Threshold logic incorrect (`<=` instead of `<`)
2. Success rate calculation wrong
3. Validation step missing

**Fix**:
- Verify: `if SUCCESS_RATE < 50` (NOT `<= 50`)
- Check: `SUCCESS_RATE = (SUCCESSFUL / TOTAL) * 100`
- Add validation step after specialist invocations

---

## Reference Implementations

### Research Agent (OpenCode)
- **Primary**: `.opencode/agent/research.md`
- **Coordinator**: `.opencode/subagents/research-coordinator.md`
- **Specialist**: `.opencode/subagents/research-specialist.md`
- **Architecture Doc**: `.opencode/RESEARCH_AGENT_ARCHITECTURE.md`

### Claude Code Agents (Reference)
- **research-coordinator**: `.claude/agents/research-coordinator.md`
- **implementer-coordinator**: `.claude/agents/implementer-coordinator.md`
- **Three-Tier Pattern**: `.claude/docs/concepts/three-tier-coordination-pattern.md`
- **Hierarchical Examples**: `.claude/docs/concepts/hierarchical-agents-examples.md`

---

## Next Steps After Migration

1. **Update agent-registry.json** with new capabilities
2. **Create architecture documentation** (like RESEARCH_AGENT_ARCHITECTURE.md)
3. **Add integration tests** for hierarchical patterns
4. **Measure performance gains** (context reduction, time savings)
5. **Document migration** in changelog

---

**Maintained By**: OpenCode Team  
**Last Updated**: 2025-12-12  
**Version**: 1.0.0
