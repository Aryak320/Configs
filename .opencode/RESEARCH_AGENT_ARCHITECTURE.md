# OpenCode Research Agent: Hierarchical Architecture

**Version**: 2.0.0  
**Last Updated**: 2025-12-12  
**Status**: Production-Ready

---

## Overview

The OpenCode research agent implements a **three-tier hierarchical coordination pattern** for multi-topic research workflows, achieving:

- **95-96% context reduction** via metadata-only passing
- **75% time savings** via parallel specialist execution  
- **Partial success mode** with ≥50% threshold handling
- **Hard barrier enforcement** preventing coordinator bypass
- **Comprehensive error logging** to errors.jsonl

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│ Tier 1: Primary Agent (research.md)                        │
│ - Parse user request, determine complexity (1-4)           │
│ - Pre-calculate topic directory and report paths           │
│ - Invoke coordinator in planning-only mode                 │
│ - Validate specialist outputs (hard barrier)               │
│ - Extract metadata from YAML frontmatter                   │
│ - Synthesize OVERVIEW.md using metadata                    │
│ - Generate console summary with metrics                    │
└─────────────────┬───────────────────────────────────────────┘
                  │ Task tool delegation
                  v
┌─────────────────────────────────────────────────────────────┐
│ Tier 2: Coordinator (research-coordinator.md)              │
│ - Decompose request into 2-5 focused sub-topics            │
│ - Calculate report paths for each topic                    │
│ - Create .invocation-plan.txt (hard barrier proof)         │
│ - Return invocation metadata (NOT full content)            │
│ - Planning-only mode (NO specialist invocation)            │
└─────────────────┬───────────────────────────────────────────┘
                  │ Returns invocation plan
                  v
┌─────────────────────────────────────────────────────────────┐
│ Primary Agent Invokes Specialists (Parallel)               │
└─────────────────┬───────────────────────────────────────────┘
                  │ Task tool delegation (3-4x parallel)
                  v
┌─────────────────────────────────────────────────────────────┐
│ Tier 3: Specialists (research-specialist.md)               │
│ - Conduct research on single topic                         │
│ - Create report at pre-calculated path                     │
│ - Include YAML frontmatter (findings_count, etc.)          │
│ - Return REPORT_CREATED signal                             │
└─────────────────────────────────────────────────────────────┘
```

## Three-Tier Responsibilities

### Tier 1: Primary Agent (`research.md`)

**Core Responsibilities**:
1. **Argument Capture**: Parse user request, determine complexity
2. **Path Pre-Calculation**: Generate topic directory, pre-calculate report paths
3. **Coordinator Invocation**: Delegate to research-coordinator (planning-only mode)
4. **Specialist Invocation**: Invoke research-specialist for each topic (parallel)
5. **Hard Barrier Validation**: Verify all reports exist, calculate success rate
6. **Metadata Extraction**: Extract YAML frontmatter (NOT full content)
7. **OVERVIEW.md Synthesis**: Generate overview using metadata summaries
8. **Console Summary**: Display 4-section summary with performance metrics
9. **Error Logging**: Log all errors to errors.jsonl with full context

**Does NOT Do**:
- ✗ Decompose topics (delegates to coordinator)
- ✗ Create research reports (delegates to specialists)
- ✗ Read full report content (extracts metadata only)

### Tier 2: Coordinator (`research-coordinator.md`)

**Core Responsibilities**:
1. **Input Validation**: Validate report_dir, topic_path exist
2. **Topic Decomposition**: Break request into 2-5 focused sub-topics
3. **Path Calculation**: Generate report paths with topic slugs
4. **Invocation Plan File**: Create .invocation-plan.txt (hard barrier proof)
5. **Metadata Return**: Return invocations array (topics + paths)

**Planning-Only Mode**:
- ✓ Creates invocation plan
- ✗ Does NOT invoke specialists
- ✗ Does NOT create OVERVIEW.md
- ✗ Does NOT aggregate results

**Rationale**: Primary agent retains control over specialist invocation for hard barrier enforcement.

### Tier 3: Specialist (`research-specialist.md`)

**Core Responsibilities**:
1. **Input Validation**: Verify research_topic, report_path provided
2. **File Creation**: Create report at EXACT pre-calculated path
3. **Research Execution**: Codebase search (Glob/Grep) + web research (WebFetch)
4. **Metadata Compliance**: Include YAML frontmatter with counts
5. **Self-Validation**: Verify required sections before return
6. **Completion Signal**: Return `REPORT_CREATED: /absolute/path`

**Does NOT Do**:
- ✗ Calculate output paths (receives from coordinator)
- ✗ Update OVERVIEW.md (primary agent handles synthesis)
- ✗ Coordinate with other specialists

## Key Patterns

### Pattern 1: Path Pre-Calculation (Hard Barrier)

**Implementation**:
```
Primary Agent (STEP 2):
  1. Generate topic_slug from request
  2. Increment .opencode/specs/.counter
  3. Create topic directory: specs/NNN_topic_slug/
  4. Pre-calculate report paths: reports/001_topic.md, 002_topic.md, etc.

Coordinator (STEP 2.5):
  5. Rename placeholder paths with actual topic slugs
  6. Create .invocation-plan.txt with path mappings

Specialist (STEP 2):
  7. Create report at EXACT path provided
```

**Benefits**:
- Enforces hard barrier (coordinator cannot bypass specialist invocation)
- Enables validation before proceeding (primary agent checks .invocation-plan.txt exists)
- Prevents path calculation errors (paths validated before specialist invocation)

### Pattern 2: Metadata Extraction (95% Context Reduction)

**Implementation**:
```
Specialist (STEP 4):
  1. Count findings: grep "^- " under "## Findings" section
  2. Count recommendations: grep "^- " under "## Recommendations" section
  3. Update YAML frontmatter with counts

Primary Agent (STEP 6):
  4. Read first 20 lines of each report (YAML frontmatter only)
  5. Extract: topic, findings_count, recommendations_count
  6. Build metadata object (110 tokens per report)
  7. Aggregate metadata (NOT full content)
```

**Context Reduction Calculation**:
```
Baseline (reading 3 full reports): 3 × 2,500 = 7,500 tokens
Hierarchical (metadata only): 3 × 110 = 330 tokens
Reduction: (7,500 - 330) / 7,500 = 95.6%
```

### Pattern 3: Partial Success Mode (≥50% Threshold)

**Implementation**:
```
Primary Agent (STEP 5):
  1. Validate each report exists at pre-calculated path
  2. Calculate: SUCCESS_RATE = (SUCCESSFUL / TOTAL) × 100
  3. Apply threshold:
     - <50%: Exit with error, log to errors.jsonl
     - 50-99%: Continue with warning, log partial success
     - 100%: Continue without warning
  4. Include failed topics in OVERVIEW.md if partial success
```

**Example** (75% success):
```
WARNING: Partial research success - 3/4 reports created (75% success)
Failed topics: ["Project Structure Best Practices"]
Proceeding with 3 available reports...
```

### Pattern 4: Error Logging

**Implementation**:
```
Primary Agent (INITIALIZATION):
  1. Set WORKFLOW_ID = "research_" + nanosecond_timestamp
  2. Set ERROR_LOG_PATH = ".opencode/errors.jsonl"

On Any Error:
  3. Build error_entry JSON:
     {
       "timestamp": ISO_8601_timestamp,
       "workflow_id": WORKFLOW_ID,
       "command": "research-mode",
       "error_type": error_type,
       "message": error_message,
       "details": error_details
     }
  4. Append JSON line to errors.jsonl
```

**Error Types**:
- `validation_error`: Input validation, output verification failures
- `agent_error`: Coordinator/specialist execution failures
- `parse_error`: Output parsing failures
- `file_error`: File system operation failures
- `execution_error`: General execution failures

## Signal Specifications

### Coordinator → Primary Agent

```yaml
RESEARCH_COORDINATOR_COMPLETE: SUCCESS
coordinator_type: research
topics_planned: 3
invocation_plan_path: /abs/path/.invocation-plan.txt
context_usage_percent: 8

INVOCATION_PLAN_READY: 3
invocations: [
  {"topic": "Topic 1", "report_path": "/abs/path/001_topic1.md"},
  {"topic": "Topic 2", "report_path": "/abs/path/002_topic2.md"},
  {"topic": "Topic 3", "report_path": "/abs/path/003_topic3.md"}
]
```

### Specialist → Primary Agent

```
REPORT_CREATED: /abs/path/to/report.md
```

### Error Signals (Any Agent → Parent)

```
ERROR_CONTEXT: {"error_type":"validation_error","message":"Missing report_path","details":{...}}

TASK_ERROR: validation_error - Missing report_path field in input contract
```

## YAML Frontmatter Schema

**Research Report Frontmatter**:
```yaml
---
report_type: research
topic: "Topic description"
findings_count: 12
recommendations_count: 5
created_date: 2025-12-12
status: complete
---
```

**Required Fields**:
- `report_type`: Always "research"
- `topic`: Topic researched (string)
- `findings_count`: Number of findings (integer)
- `recommendations_count`: Number of recommendations (integer)
- `created_date`: Date created (YYYY-MM-DD)
- `status`: "in_progress" or "complete"

## Performance Metrics

### Context Reduction

| Reports | Baseline (Full Content) | Hierarchical (Metadata) | Reduction |
|---------|------------------------|-------------------------|-----------|
| 2       | 5,000 tokens           | 220 tokens              | 95.6%     |
| 3       | 7,500 tokens           | 330 tokens              | 95.6%     |
| 4       | 10,000 tokens          | 440 tokens              | 95.6%     |

### Time Savings (Parallel Execution)

| Reports | Sequential | Parallel | Savings |
|---------|-----------|----------|---------|
| 2       | 60s       | 30s      | 50%     |
| 3       | 90s       | 30s      | 67%     |
| 4       | 120s      | 30s      | 75%     |

**Assumptions**: 30 seconds per specialist, all specialists run simultaneously in parallel mode.

### Iteration Capacity

```
Context Budget: 200,000 tokens (Sonnet 3.5)

Baseline (reading full reports):
  3 reports × 2,500 tokens = 7,500 tokens per iteration
  Iterations: 200,000 / 7,500 = 26 iterations

Hierarchical (metadata only):
  3 reports × 110 tokens = 330 tokens per iteration
  Iterations: 200,000 / 330 = 606 iterations

Iteration Capacity Increase: 606 / 26 = 23.3×
```

## Workflow Example

**User Request**: "Research Lean 4 proof automation techniques"

**STEP 1: Argument Capture**
- Complexity detected: 3 (moderate scope)
- Topic count: 3 topics

**STEP 2: Path Pre-Calculation**
- Topic slug: `lean_proof_automation`
- Counter: 042
- Topic dir: `.opencode/specs/042_lean_proof_automation/`
- Report paths:
  - `reports/001_topic.md`
  - `reports/002_topic.md`
  - `reports/003_topic.md`

**STEP 3: Coordinator Invocation**
- Coordinator decomposes into:
  1. "Lean 4 Tactic Libraries"
  2. "Custom Tactic Development"
  3. "Mathlib Automation Strategies"
- Renames paths with topic slugs
- Creates `.invocation-plan.txt`
- Returns invocations array

**STEP 4: Specialist Invocation (Parallel)**
- 3 specialists invoked simultaneously
- Each creates report at pre-calculated path
- Each includes YAML frontmatter with counts
- Each returns `REPORT_CREATED` signal

**STEP 5: Validation**
- All 3 reports exist
- Success rate: 100%
- Proceed to metadata extraction

**STEP 6: Metadata Extraction**
- Extract frontmatter from each report
- Build metadata: 3 × 110 = 330 tokens
- Aggregate: 25 findings, 12 recommendations

**STEP 7: OVERVIEW.md Synthesis**
- Create OVERVIEW.md with executive summary
- List all reports with metadata
- Include directory structure

**STEP 8: Console Summary**
```
═══════════════════════════════════════════════════════════════
📊 RESEARCH COMPLETE
═══════════════════════════════════════════════════════════════

## Summary
Research Request: Research Lean 4 proof automation techniques
Status: SUCCESS (100%)
Topics Completed: 3/3
Total Findings: 25
Total Recommendations: 12

## Research Topics
  ✓ Lean 4 Tactic Libraries - 8 findings, 4 recommendations
  ✓ Custom Tactic Development - 10 findings, 5 recommendations
  ✓ Mathlib Automation Strategies - 7 findings, 3 recommendations

## Artifacts
📁 Project Directory: /home/benjamin/.config/.opencode/specs/042_lean_proof_automation
📄 Overview: OVERVIEW.md
📋 Reports: 3 files in reports/
📝 Invocation Plan: .invocation-plan.txt

## Performance Metrics
⚡ Parallel Execution: 3 specialists running simultaneously
📉 Context Reduction: 95.6% (7,500 → 330 tokens)
⏱️  Time Savings: ~67% vs sequential execution

═══════════════════════════════════════════════════════════════
```

## Troubleshooting

### Issue: Coordinator Returns Error

**Symptom**: `TASK_ERROR: validation_error - Missing report_dir`

**Cause**: Primary agent didn't create topic directory before coordinator invocation

**Fix**: Verify STEP 2 creates `[TOPIC_DIR]/reports/` directory before STEP 3

### Issue: Specialists Don't Create Reports

**Symptom**: Hard barrier validation fails, all reports missing

**Cause**: Specialists not receiving correct `report_path` in input contract

**Fix**: Check invocations array parsing in STEP 4, verify paths are absolute

### Issue: Metadata Extraction Fails

**Symptom**: OVERVIEW.md missing findings/recommendations counts

**Cause**: YAML frontmatter missing or malformed in reports

**Fix**: Verify specialists create frontmatter in STEP 2 before research

### Issue: Partial Success Not Handling Correctly

**Symptom**: Workflow exits with error even though ≥50% reports created

**Cause**: Threshold logic incorrect in STEP 5

**Fix**: Verify: `if SUCCESS_RATE < 50` (not `<=`)

## Migration from v1.0.0

**Changes Required**:
1. Update `research.md` to include all 8 steps
2. Update `research-coordinator.md` to planning-only mode
3. Update `research-specialist.md` to include YAML frontmatter
4. Create `.opencode/errors.jsonl` for error logging
5. Update agent-registry.json with new capabilities

**Backward Compatibility**: None (v2.0.0 is breaking change)

## Related Documentation

- [OpenCode README](.opencode/README.md) - OpenCode overview
- [Migration Guide](.opencode/MIGRATION_GUIDE.md) - Migrating other agents
- [Agent Registry](.opencode/agent-registry.json) - Agent metadata

---

**Maintained By**: OpenCode Team  
**Contact**: See README.md for support
