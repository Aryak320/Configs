# OpenCode Primary Agents

This directory contains primary (orchestrator) agents that serve as user-facing entry points for complex workflows. Each primary agent delegates work to specialized sub-agents in the `subagents/` directory.

## Purpose

Primary agents provide:
- **User-facing interface** - Simple entry point for complex workflows
- **Request parsing** - Convert user input to structured contracts
- **Delegation logic** - Route work to appropriate sub-agents
- **Result streaming** - Stream sub-agent outputs back to user

## Available Agents

### research.md
**Category**: Research  
**Type**: Orchestrator  
**Dependencies**: research-coordinator

Orchestrates multi-topic research workflows:
1. Receives user research request
2. Delegates to `research-coordinator` sub-agent
3. Streams research progress and final report

**Usage**: User invokes with research topic → agent delegates → results streamed back

---

### lean.md
**Category**: Implementation  
**Type**: Orchestrator  
**Dependencies**: lean-coordinator

Orchestrates Lean 4 theorem proving workflows:
1. Receives user Lean implementation request (file paths, theorems)
2. Analyzes scope (file-based vs targeted, single vs batch)
3. Delegates to `lean-coordinator` sub-agent with structured contract
4. Streams proof results, summaries, and artifact paths

**Usage**: User invokes with Lean file and theorem targets → agent delegates → proof results streamed back

**Input Formats**:
- File-based: "Prove all theorems in file.lean"
- Targeted: "Prove add_comm and mul_assoc in file.lean"
- Batch: "Prove all theorems in src/*.lean"

**Output Artifacts**:
- Proof summaries in `.opencode/specs/NNN/summaries/`
- Debug logs in `.opencode/specs/NNN/debug/`
- Overview in `.opencode/specs/NNN/OVERVIEW.md`

---

## Agent Architecture

```
┌─────────────────────────────────────────┐
│ User Request                            │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│ Primary Agent (Orchestrator)            │
│ - Parse request                         │
│ - Create structured contract            │
│ - Validate inputs                       │
└──────────────────┬──────────────────────┘
                   │ Delegates via Task tool
                   ▼
┌─────────────────────────────────────────┐
│ Coordinator Sub-Agent                   │
│ - Break down into sub-tasks             │
│ - Invoke specialist sub-agents          │
│ - Aggregate results                     │
└──────────────────┬──────────────────────┘
                   │ Delegates via Task tool (parallel)
                   ▼
┌─────────────────────────────────────────┐
│ Specialist Sub-Agents (parallel)        │
│ - Execute single focused task           │
│ - Generate artifacts                    │
│ - Return structured results             │
└──────────────────┬──────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────┐
│ Results Aggregated & Streamed to User   │
└─────────────────────────────────────────┘
```

## Design Principles

### 1. Single Responsibility
Each primary agent handles **one workflow type** (research, implementation, debugging, etc.)

### 2. Minimal Logic
Primary agents focus on:
- Request parsing
- Input validation
- Delegation
- Result streaming

Complex logic delegated to sub-agents.

### 3. Structured Contracts
Communication uses YAML contracts with explicit fields:

```yaml
Input Contract (Primary → Coordinator):
  task_type: "prove_theorems"
  file_paths: ["/path/to/file.lean"]
  execution_mode: "file-based"
  max_attempts: 3
  output_dir: ".opencode/specs/NNN/"

Output Contract (Coordinator → Primary):
  COORDINATION_COMPLETE:
    success_count: 5
    failure_count: 0
    artifacts:
      overview: ".opencode/specs/NNN/OVERVIEW.md"
```

### 4. Error Isolation
Failures in sub-agents do NOT crash primary agent:
- Log errors
- Return partial results
- Suggest recovery steps

## Creating New Primary Agents

### Step 1: Identify Workflow
Determine if workflow needs orchestration:
- Multi-step process? → Yes, needs primary agent
- Single focused task? → No, use sub-agent directly

### Step 2: Define Contract
Specify input/output contracts:
- What does user provide?
- What structure does coordinator need?
- What results return to user?

### Step 3: Create Agent File
```markdown
You are the [Name] orchestrator. Your primary role is to [purpose].

## Core Responsibilities
1. Receive Request
2. Analyze Scope
3. Delegate Execution
4. Stream Results

## Workflow
[Detailed steps]

## Tools Required
- task (delegation)
- read (validation)
- bash (optional)
```

### Step 4: Register in agent-registry.json
```json
{
  "agent-name": {
    "type": "orchestrator",
    "category": "workflow-type",
    "description": "Brief description",
    "tools": ["Task", "Read"],
    "dependencies": ["coordinator-sub-agent"],
    "behavioral_file": ".opencode/agent/agent-name.md"
  }
}
```

## Best Practices

### ✅ DO
- Keep primary agents simple (parsing + delegation)
- Use structured YAML contracts
- Validate inputs before delegation
- Stream sub-agent outputs to user
- Handle sub-agent failures gracefully

### ❌ DON'T
- Implement complex logic in primary agents
- Perform actual work (delegate to specialists)
- Ignore sub-agent errors silently
- Use unstructured string contracts
- Block on sub-agent completion (stream results)

## Tools Used

Primary agents typically use:
- `task` - Delegate to sub-agents
- `read` - Validate file paths
- `bash` - Check project context (optional)

Primary agents do NOT use:
- `write` - Sub-agents create artifacts
- `edit` - Sub-agents modify files
- `webfetch` - Sub-agents do research

## Related Documentation

- [Sub-Agents](../subagents/README.md) - Coordinator and specialist sub-agents
- [Agent Registry](../agent-registry.json) - Agent metadata and metrics
- [Research Agent Example](research.md) - Complete research orchestrator
- [LEAN Agent Example](lean.md) - Complete Lean 4 orchestrator

## Navigation

- [← Parent Directory](../)
- [Sub-Agents →](../subagents/README.md)
- [Agent Registry →](../agent-registry.json)
