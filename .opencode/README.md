# OpenCode Custom Agents

This directory contains custom agent implementations for OpenCode, extending its capabilities with specialized workflows.

## Purpose

OpenCode agents provide:
- **Specialized workflows** - Domain-specific automation (research, theorem proving, analysis)
- **Hierarchical delegation** - Primary agents → Coordinators → Specialists
- **Parallel execution** - Multiple specialists running concurrently
- **Artifact generation** - Structured outputs (reports, summaries, debug logs)

## Directory Structure

```
.opencode/
├── agent/                       # Primary agents (user-facing orchestrators)
│   ├── lean.md                 # LEAN theorem proving orchestrator
│   ├── research.md             # Research workflow orchestrator
│   └── README.md               # Primary agents documentation
│
├── subagents/                   # Sub-agents (coordinators and specialists)
│   ├── lean-coordinator.md     # Multi-theorem batch coordinator
│   ├── lean-proof-specialist.md # Single theorem prover
│   ├── research-coordinator.md  # Multi-topic research coordinator
│   ├── research-specialist.md   # Single topic researcher
│   └── README.md               # Sub-agents documentation
│
├── specs/                       # Generated artifacts (per invocation)
│   └── NNN_topic_slug/
│       ├── OVERVIEW.md         # Results summary
│       ├── summaries/          # Per-task outputs
│       └── debug/              # Error logs
│
├── agent-registry.json          # Agent metadata and metrics
│
├── LEAN_QUICK_START.md         # LEAN agent quick reference
├── LEAN_AGENT_SETUP.md         # LEAN agent architecture guide
├── CLAUDE_CODE_VS_OPENCODE.md  # Comparison with Claude Code
└── README.md                   # This file
```

## Available Agents

### 1. Research Agent (v2.0.0 - Hierarchical)
**Primary**: `agent/research.md`  
**Coordinator**: `subagents/research-coordinator.md`  
**Specialist**: `subagents/research-specialist.md`

**Purpose**: Multi-topic research workflows with parallel web research and 95%+ context reduction

**Key Features**:
- **95-96% Context Reduction**: Metadata-only passing (330 tokens vs 7,500 baseline)
- **75% Time Savings**: Parallel specialist execution (3 topics in 30s vs 90s)
- **Partial Success Mode**: Continues with ≥50% success rate
- **Hard Barrier Enforcement**: Pre-calculated paths prevent coordinator bypass
- **Error Logging**: All errors logged to `.opencode/errors.jsonl`

**Usage**:
```
User: "Research Lean 4 proof automation techniques"
```

**Output**: 
- `.opencode/specs/042_lean_proof_automation/OVERVIEW.md` - Executive summary with metadata
- `.opencode/specs/042_lean_proof_automation/reports/` - Individual research reports with YAML frontmatter
- `.opencode/specs/042_lean_proof_automation/.invocation-plan.txt` - Coordination metadata

**Architecture**: See [RESEARCH_AGENT_ARCHITECTURE.md](RESEARCH_AGENT_ARCHITECTURE.md) for complete documentation

---

### 2. LEAN Agent
**Primary**: `agent/lean.md`  
**Coordinator**: `subagents/lean-coordinator.md`  
**Specialist**: `subagents/lean-proof-specialist.md`

**Purpose**: Lean 4 theorem proving with parallel proof execution

**Usage**:
```
User: "Prove all theorems in file.lean"
```

**Output**: `.opencode/specs/NNN_lean_proofs/OVERVIEW.md` with theorem results table and proof summaries

**Quick Start**: See [LEAN_QUICK_START.md](LEAN_QUICK_START.md)

---

## Agent Architecture

### Three-Tier Hierarchy

```
┌─────────────────────────────────────────┐
│ Primary Agent (Orchestrator)            │
│ - User-facing entry point               │
│ - Parse requests                        │
│ - Create contracts                      │
│ - Delegate to coordinator               │
└──────────────────┬──────────────────────┘
                   │ Task tool
                   ▼
┌─────────────────────────────────────────┐
│ Coordinator Sub-Agent                   │
│ - Break into sub-tasks                  │
│ - Launch specialists (parallel)         │
│ - Aggregate results                     │
│ - Generate OVERVIEW.md                  │
└──────────────────┬──────────────────────┘
                   │ Task tool (parallel)
                   ▼
┌─────────────────────────────────────────┐
│ Specialist Sub-Agents                   │
│ - Execute single focused task           │
│ - Generate artifact (report, summary)   │
│ - Return structured result              │
└─────────────────────────────────────────┘
```

### Communication Pattern

Agents communicate via structured YAML contracts:

```yaml
# Primary → Coordinator
Input Contract:
  task_type: "prove_theorems"
  file_paths: ["/path/to/file.lean"]
  execution_mode: "file-based"
  output_dir: ".opencode/specs/NNN/"

# Coordinator → Specialist
Input Contract:
  assigned_task: "prove add_comm"
  task_file: "/path/to/file.lean"
  output_dir: ".opencode/specs/NNN/"

# Specialist → Coordinator
Output Contract:
  TASK_COMPLETE:
    status: "success"
    artifact_path: ".opencode/specs/NNN/summaries/add_comm.md"

# Coordinator → Primary
Output Contract:
  COORDINATION_COMPLETE:
    success_count: 5
    artifacts:
      overview: ".opencode/specs/NNN/OVERVIEW.md"
```

## Key Features

### 1. Parallel Execution
Coordinators launch multiple specialists simultaneously:
- **Research**: 1-5 topic specialists in parallel
- **LEAN**: N theorem specialists in parallel (N = theorem count)
- **Speedup**: 2-5× faster than sequential execution

### 2. Artifact-Based Results
Results stored as files, not in-memory:
- **OVERVIEW.md**: Executive summary with links
- **summaries/**: Per-task detailed outputs
- **debug/**: Error logs and failed attempt analysis

### 3. Error Isolation
Specialist failures don't cascade:
- Failed specialist logs to debug directory
- Coordinator continues processing other specialists
- Partial success reported (e.g., "4/5 theorems proven")

### 4. Structured Contracts
Type-safe communication via YAML:
- Explicit input expectations
- Clear output format
- Validated by coordinators

## Getting Started

### Using Research Agent

```
User: "Research Lean 4 tactic libraries"

OpenCode invokes: research agent
  ↓ delegates to research-coordinator
  ↓ launches research-specialist × N topics
  ↓ generates OVERVIEW.md

Output: .opencode/specs/042_lean_tactics/OVERVIEW.md
```

### Using LEAN Agent

**Prerequisites**:
```bash
pip install lean-lsp-mcp
```

**Usage**:
```
User: "Prove all theorems in ProofChecker/Truth.lean"

OpenCode invokes: lean agent
  ↓ delegates to lean-coordinator
  ↓ discovers theorems (grep for sorry)
  ↓ launches lean-proof-specialist × N theorems
  ↓ aggregates results, generates OVERVIEW.md

Output: .opencode/specs/043_truth_proofs/OVERVIEW.md
```

**See**: [LEAN Quick Start Guide](LEAN_QUICK_START.md)

## Documentation

### Quick References
- [LEAN Quick Start](LEAN_QUICK_START.md) - Fast reference for LEAN agent usage
- [Agent Registry](agent-registry.json) - Agent metadata and metrics

### Architecture Guides
- [LEAN Agent Setup](LEAN_AGENT_SETUP.md) - Complete LEAN agent architecture
- [Primary Agents](agent/README.md) - Orchestrator patterns
- [Sub-Agents](subagents/README.md) - Coordinator and specialist patterns

### Comparisons
- [Claude Code vs OpenCode](CLAUDE_CODE_VS_OPENCODE.md) - Architecture comparison

## Creating Custom Agents

### Step 1: Identify Workflow
Does the workflow need multi-step coordination?
- **Yes**: Create primary + coordinator + specialist
- **No**: Create standalone specialist

### Step 2: Design Contracts
Define input/output contracts for each tier:
```yaml
# Example: Custom agent for code review
Primary Input:
  file_paths: ["/path/to/file1.py", "/path/to/file2.py"]
  review_scope: "security" | "performance" | "style"

Coordinator Input:
  file_paths: [...]
  review_scope: "..."

Specialist Input:
  file_path: "/path/to/file1.py"
  review_scope: "security"

Specialist Output:
  REVIEW_COMPLETE:
    issues_found: 3
    report_path: ".opencode/specs/NNN/reviews/file1_security.md"
```

### Step 3: Create Agent Files

**Primary** (`agent/code-review.md`):
```markdown
You are the Code Review orchestrator. Your role is to coordinate code review workflows.

1. Receive Request: Accept file paths and review scope
2. Delegate: Invoke code-review-coordinator
3. Stream Results: Stream review results to user
```

**Coordinator** (`subagents/code-review-coordinator.md`):
```markdown
You are the Code Review Coordinator. Your role is to manage multi-file reviews.

1. Initialize: Create specs/NNN_code_review/ directory
2. Decompose: One specialist per file
3. Delegate: Launch specialists in parallel
4. Aggregate: Generate OVERVIEW.md with all issues
5. Return: Completion signal to primary
```

**Specialist** (`subagents/code-review-specialist.md`):
```markdown
You are a Code Review Specialist. Your purpose is to review a single file.

1. Read Task: Assigned file and review scope
2. Execute: Analyze file for issues
3. Generate: Write review report to summaries/
4. Return: Completion signal with issue count
```

### Step 4: Register Agent

Update `agent-registry.json`:
```json
{
  "code-review": {
    "type": "orchestrator",
    "category": "analysis",
    "description": "Multi-file code review orchestrator",
    "tools": ["Task", "Read"],
    "dependencies": ["code-review-coordinator"],
    "behavioral_file": ".opencode/agent/code-review.md"
  }
}
```

## Best Practices

### ✅ DO
- Use three-tier hierarchy for multi-task workflows
- Launch specialists in parallel (not sequential)
- Generate OVERVIEW.md with links to artifacts
- Use structured YAML contracts
- Isolate errors (specialist failures don't cascade)
- Return explicit completion signals

### ❌ DON'T
- Implement complex logic in primary agents (delegate to coordinator)
- Block on sequential specialist execution (parallelize)
- Return large outputs in memory (write to files)
- Use unstructured string contracts (use YAML)
- Ignore specialist failures silently (log to debug/)

## Troubleshooting

### Agent Not Found

**Symptom**: OpenCode says "agent not found"

**Check**:
1. Agent file exists: `ls .opencode/agent/lean.md`
2. Registered: `jq '.agents.lean' .opencode/agent-registry.json`
3. Path correct in registry: `"behavioral_file": ".opencode/agent/lean.md"`

---

### Coordinator Doesn't Launch Specialists

**Symptom**: Coordinator runs but doesn't invoke specialists

**Check**:
1. Coordinator uses `task` tool correctly
2. Specialist files exist in `subagents/`
3. Input contracts have correct structure (YAML)

---

### Artifacts Not Generated

**Symptom**: No OVERVIEW.md or summaries created

**Check**:
1. Coordinator has `write` tool access
2. Output directory path is absolute
3. Specialist completion signals include `artifact_path`

---

## Performance Metrics

### Research Agent (5 topics)
**Sequential**: ~150 seconds (30s per topic)  
**Parallel**: ~45 seconds (all topics simultaneously)  
**Speedup**: 3.3× faster

### LEAN Agent (10 theorems)
**Sequential**: ~150 seconds (15s per theorem)  
**Parallel**: ~45 seconds (all theorems simultaneously)  
**Speedup**: 3.3× faster

### LEAN Agent (20 theorems)
**Sequential**: ~300 seconds  
**Parallel**: ~60 seconds  
**Speedup**: 5× faster

## Related Documentation

### External Resources
- [OpenCode Documentation](https://opencode.ai/docs)
- [MCP Protocol](https://modelcontextprotocol.io/)
- [Lean 4 Manual](https://lean-lang.org/documentation/)

### Internal Resources
- [Claude Code Agents](.claude/agents/README.md) - Reference Claude Code agents
- [Claude Code Commands](.claude/commands/README.md) - Reference Claude Code commands
- [OpenCode Configuration](OpenCode.md) - OpenCode project settings

## Navigation

- [← Parent Directory](../)
- [Primary Agents →](agent/README.md)
- [Sub-Agents →](subagents/README.md)
- [LEAN Quick Start →](LEAN_QUICK_START.md)
- [LEAN Setup Guide →](LEAN_AGENT_SETUP.md)

---

**Last Updated**: 2025-12-12  
**Agent Count**: 2 primary agents (research, lean)  
**Sub-Agent Count**: 4 sub-agents (2 coordinators, 2 specialists)  
**Version**: 1.0.0
