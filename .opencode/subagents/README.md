# OpenCode Sub-Agents

This directory contains sub-agents that perform specialized tasks as part of larger workflows orchestrated by primary agents in the `agent/` directory.

## Purpose

Sub-agents provide:
- **Specialized capabilities** - Focused expertise (research, proof generation, analysis)
- **Parallel execution** - Multiple sub-agents run concurrently
- **Result aggregation** - Coordinators collect and synthesize specialist outputs
- **Reusable components** - Same sub-agent used across multiple workflows

## Sub-Agent Types

### Coordinators
Orchestrate multiple specialist sub-agents in parallel:
- Break tasks into independent units
- Launch specialists via `task` tool
- Aggregate results from all specialists
- Generate summary artifacts

**Examples**: `research-coordinator`, `lean-coordinator`

### Specialists
Execute single focused task:
- Process one specific input
- Generate one artifact (report, proof summary)
- Return structured result signal
- Operate independently (no sub-agent dependencies)

**Examples**: `research-specialist`, `lean-proof-specialist`

## Available Sub-Agents

### research-coordinator.md
**Type**: Coordinator  
**Category**: Research  
**Invoked By**: research (primary agent)

Manages multi-topic research workflows:
1. Initializes project directory (`.opencode/specs/NNN_topic/`)
2. Decomposes request into 1-5 research sub-topics
3. Launches `research-specialist` for each sub-topic (parallel)
4. Aggregates specialist reports into `OVERVIEW.md`
5. Returns executive summary to primary agent

**Tools**: Task, Read, Write, Bash

---

### research-specialist.md
**Type**: Specialist  
**Category**: Research  
**Invoked By**: research-coordinator

Conducts research on a single sub-topic:
1. Reads assigned sub-topic file
2. Uses `webfetch` to gather information
3. Writes findings to sub-topic report file
4. Updates `OVERVIEW.md` with summary and link
5. Returns completion signal

**Tools**: Read, Write, WebFetch

---

### lean-coordinator.md
**Type**: Coordinator  
**Category**: Implementation  
**Invoked By**: lean (primary agent)

Manages Lean 4 theorem proving workflows:
1. Discovers theorems in Lean files (grep for `sorry` markers)
2. Creates theorem batch manifest
3. Launches `lean-proof-specialist` for each theorem (parallel)
4. Aggregates proof results (proven, partial, failed)
5. Generates `OVERVIEW.md` with results table
6. Returns completion signal with artifact paths

**Input Contract**:
```yaml
lean_file_paths: ["/path/to/file.lean"]
execution_mode: "file-based" | "targeted"
theorem_targets: []
max_attempts: 3
output_dir: ".opencode/specs/NNN/"
```

**Output Structure**:
```
.opencode/specs/NNN/
├── OVERVIEW.md
├── theorem_manifest.json
├── summaries/
│   ├── theorem1.md
│   └── theorem2.md
└── debug/
    └── failed_theorem_log.md
```

**Tools**: Task, Read, Write, Bash, Glob

---

### lean-proof-specialist.md
**Type**: Specialist  
**Category**: Implementation  
**Invoked By**: lean-coordinator

Completes a single Lean 4 theorem proof:
1. Extracts proof goal via `lean_goal` MCP tool
2. Searches for applicable theorems (local → external, budget-aware)
3. Generates candidate tactics based on goal pattern
4. Tests tactics via `lean_multi_attempt` MCP tool
5. Applies successful tactic via `edit` tool
6. Verifies proof compilation via `lean_build`
7. Creates proof summary artifact
8. Returns completion signal

**Search Strategy**:
- **Local first**: `lean_local_search` (no rate limit)
- **External fallback**: `lean_leansearch`, `lean_loogle` (rate limited: 3/30s combined)
- **Budget tracking**: Tracks external API usage, respects budget limit

**Proof Patterns**:
| Goal | Tactics |
|------|---------|
| `a + b = b + a` | `exact Nat.add_comm`, `rw [Nat.add_comm]` |
| `∀ x, P x` | `intro`, `intros` |
| `P ∧ Q` | `constructor` |

**Tools**: Read, Edit, Write, Bash (for MCP tool invocation via `uvx`)

**MCP Tools Used** (via bash/uvx):
- `lean_goal` - Extract proof goals
- `lean_local_search` - Local theorem search (unlimited)
- `lean_leansearch` - Natural language search (rate limited)
- `lean_loogle` - Type signature search (rate limited)
- `lean_multi_attempt` - Parallel tactic testing
- `lean_build` - Proof verification
- `lean_diagnostic_messages` - Error checking

---

## Sub-Agent Architecture

### Coordinator Pattern

```
┌──────────────────────────────────────┐
│ Coordinator Sub-Agent                │
├──────────────────────────────────────┤
│ 1. Receive structured contract      │
│ 2. Break into independent tasks     │
│ 3. Launch specialists (parallel)    │
│ 4. Aggregate results                │
│ 5. Generate overview artifact       │
│ 6. Return completion signal         │
└────────┬─────────────────────────────┘
         │ Delegates via Task tool (parallel)
         ▼
┌────────────────────────────────────────────────┐
│ Specialist 1   Specialist 2   Specialist 3    │
│ (independent)  (independent)  (independent)   │
└────────┬───────────────┬──────────────┬────────┘
         │               │              │
         └───────────────┴──────────────┘
                         │
                         ▼
         ┌───────────────────────────┐
         │ Aggregated Results        │
         └───────────────────────────┘
```

### Specialist Pattern

```
┌──────────────────────────────────────┐
│ Specialist Sub-Agent                 │
├──────────────────────────────────────┤
│ 1. Receive task contract            │
│ 2. Read assigned input file         │
│ 3. Execute specialized task          │
│ 4. Generate artifact (report, proof) │
│ 5. Return structured result          │
└──────────────────────────────────────┘
```

## Communication Contracts

### Coordinator Input (from Primary Agent)

```yaml
Input Contract:
  task_type: "research" | "prove_theorems"
  [task-specific fields]
  output_dir: ".opencode/specs/NNN/"
```

### Coordinator Output (to Primary Agent)

```yaml
Output Contract:
  COORDINATION_COMPLETE:
    success_count: 5
    failure_count: 0
    artifacts:
      overview: "path/to/OVERVIEW.md"
      [other artifacts]
```

### Specialist Input (from Coordinator)

```yaml
Input Contract:
  assigned_file: "path/to/subtopic.md"
  [specialist-specific parameters]
  output_dir: ".opencode/specs/NNN/"
```

### Specialist Output (to Coordinator)

```yaml
Output Contract:
  TASK_COMPLETE:
    status: "success" | "partial" | "failed"
    artifact_path: "path/to/result.md"
    [specialist-specific results]
```

## Design Principles

### 1. Independence
Specialists operate independently:
- No shared state between specialists
- No communication between specialists
- Coordinator ensures no conflicts (file locks, etc.)

### 2. Parallel Execution
Coordinators maximize parallelism:
- Launch all specialists simultaneously
- Use `task` tool for concurrent invocation
- Aggregate results after all complete

### 3. Structured Signals
Use YAML contracts for communication:
- Clear input expectations
- Explicit output format
- Type-safe parsing (JSON/YAML)

### 4. Error Isolation
Specialist failures don't cascade:
- Coordinator logs failures
- Continues processing remaining tasks
- Reports partial success

### 5. Artifact-Based Results
Results stored in files, not return values:
- Specialist writes artifact to disk
- Coordinator reads artifacts for aggregation
- Enables large outputs without token limits

## Creating New Sub-Agents

### Coordinator Sub-Agent Template

```markdown
You are the [Name] Coordinator. Your role is to [purpose].

## Input Contract
[YAML structure from primary agent]

## Workflow

### STEP 1: Initialize
[Setup project directory, manifests]

### STEP 2: Decompose
[Break into independent tasks]

### STEP 3: Delegate
[Launch specialists via task tool]

### STEP 4: Aggregate
[Collect specialist results]

### STEP 5: Finalize
[Generate overview, return signal]

## Tools Required
- task (delegation)
- read, write (artifacts)
- bash, glob (discovery)
```

### Specialist Sub-Agent Template

```markdown
You are a [Name] Specialist. Your purpose is to [single focused task].

## Input Contract
[YAML structure from coordinator]

## Execution Workflow

### STEP 1: Read Task
[Parse assigned input file]

### STEP 2: Execute
[Perform specialized work]

### STEP 3: Generate Artifact
[Write result to output file]

### STEP 4: Return Signal
[Structured completion signal]

## Tools Required
- read (input)
- write (output)
- [specialist-specific tools]
```

## Best Practices

### ✅ DO (Coordinators)
- Break tasks into smallest independent units
- Launch specialists in parallel (not sequential)
- Aggregate results into summary artifact
- Handle specialist failures gracefully
- Return structured completion signals

### ✅ DO (Specialists)
- Focus on single task
- Write results to assigned file
- Return structured output contract
- Log errors to debug directory
- Respect rate limits (budget tracking)

### ❌ DON'T
- Coordinate between specialists (coordinator's job)
- Block on sequential specialist execution (use parallel)
- Use unstructured return values (use YAML contracts)
- Ignore specialist failures silently (log and report)
- Share state between specialists (independence)

## Rate Limiting Best Practices

For specialists using external APIs (e.g., Lean MCP tools):

### Budget Tracking Pattern

```bash
# Initialize budget
BUDGET_USED=0
BUDGET_LIMIT=3

# Prioritize unlimited tools
local_result=$(unlimited_tool_query)

# Use rate-limited tools only if needed
if [ -z "$local_result" ] && [ "$BUDGET_USED" -lt "$BUDGET_LIMIT" ]; then
  external_result=$(rate_limited_tool_query)
  BUDGET_USED=$((BUDGET_USED + 1))
fi

# Report budget consumption
echo "Budget: $BUDGET_USED / $BUDGET_LIMIT"
```

### Search Strategy

1. **Try unlimited/local tools first** (e.g., `lean_local_search`)
2. **Fall back to rate-limited tools** only if no results
3. **Track budget consumption** across all rate-limited calls
4. **Stop when budget exhausted** (don't fail, continue with available data)
5. **Report budget usage** in output contract

## Related Documentation

- [Primary Agents](../agent/README.md) - Orchestrators that invoke sub-agents
- [Agent Registry](../agent-registry.json) - Agent metadata and metrics
- [LEAN Coordinator](lean-coordinator.md) - Example coordinator sub-agent
- [LEAN Proof Specialist](lean-proof-specialist.md) - Example specialist sub-agent

## Navigation

- [← Parent Directory](../)
- [Primary Agents →](../agent/README.md)
- [Agent Registry →](../agent-registry.json)
