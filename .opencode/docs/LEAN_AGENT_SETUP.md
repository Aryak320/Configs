# LEAN Agent Setup for OpenCode

This document explains the LEAN implementation agent architecture created for OpenCode, adapted from Claude Code's `lean-implementer.md`.

## What Was Created

### 1. Primary Agent: `agent/lean.md`
**Role**: User-facing orchestrator  
**Purpose**: Entry point for LEAN theorem proving requests

**Responsibilities**:
- Parse user request (file paths, theorem names, execution mode)
- Create structured YAML contract for coordinator
- Delegate to `lean-coordinator` sub-agent
- Stream results back to user

**Tools**: Task, Read, Bash

---

### 2. Coordinator Sub-Agent: `subagents/lean-coordinator.md`
**Role**: Workflow coordinator  
**Purpose**: Manage multi-theorem proving workflows

**Responsibilities**:
- Discover theorems (grep for `sorry` markers or match theorem names)
- Create theorem batch manifest
- Launch `lean-proof-specialist` for each theorem (parallel)
- Aggregate proof results (proven, partial, failed)
- Generate `OVERVIEW.md` summary
- Return completion signal to primary agent

**Tools**: Task, Read, Write, Bash, Glob

---

### 3. Specialist Sub-Agent: `subagents/lean-proof-specialist.md`
**Role**: Single theorem prover  
**Purpose**: Complete one Lean 4 proof

**Responsibilities**:
- Extract proof goal via `lean_goal` MCP tool
- Search for applicable theorems (local-first, budget-aware)
- Generate candidate tactics
- Test tactics via `lean_multi_attempt`
- Apply successful tactic via `edit` tool
- Verify proof compilation
- Create proof summary artifact
- Track search budget consumption

**Tools**: Read, Edit, Write, Bash (for MCP invocation)

---

### 4. Agent Registry Update: `agent-registry.json`
Added `lean` agent entry with metadata:
- Type: orchestrator
- Category: implementation
- Dependencies: lean-coordinator
- Tools: Task, Read, Bash

---

### 5. Documentation
- `agent/README.md` - Primary agents overview
- `subagents/README.md` - Sub-agents overview and patterns

---

## Architecture Comparison

### Claude Code (Original)
```
/lean-implement (command)
    ↓
lean-implementer (agent)
    ↓ (executes proof workflow directly)
Single-agent architecture
```

### OpenCode (Adapted)
```
User invokes "lean" agent
    ↓
lean (primary orchestrator)
    ↓ delegates via Task tool
lean-coordinator (sub-agent)
    ↓ launches specialists in parallel
lean-proof-specialist (sub-agent) × N theorems
    ↓ generates artifacts
Results aggregated → streamed to user
```

---

## Key Adaptations for OpenCode

### 1. Three-Tier Delegation
**Claude Code**: Single agent handles everything  
**OpenCode**: Primary → Coordinator → Specialist (enables parallelism)

### 2. Structured Contracts
**Claude Code**: Inline parameters  
**OpenCode**: YAML contracts for type-safe communication

### 3. Parallel Execution
**Claude Code**: Sequential theorem proving  
**OpenCode**: Coordinator launches specialists in parallel

### 4. Artifact-Based Results
**Claude Code**: Progress markers in plan files  
**OpenCode**: File artifacts (summaries, debug logs, OVERVIEW.md)

### 5. Budget Tracking
**Claude Code**: Rate limit handling  
**OpenCode**: Explicit budget parameter in contracts, consumption tracking

### 6. Search Strategy
**Both**: Local-first (unlimited) → External (rate-limited)  
**OpenCode**: Budget parameter passed through contracts

---

## How to Use

### Basic Invocation

In OpenCode, invoke the `lean` primary agent directly:

```
User: "I need to prove theorems in ProofChecker/Truth.lean"

OpenCode invokes: lean agent
↓
lean agent delegates to: lean-coordinator
↓
lean-coordinator launches: lean-proof-specialist for each theorem
↓
Results streamed back to user
```

### Input Formats

**File-based** (all sorry markers):
```
"Prove all theorems in /path/to/file.lean"
```

**Targeted** (specific theorems):
```
"Prove add_comm and mul_assoc in /path/to/file.lean"
```

**Batch** (multiple files):
```
"Prove all theorems in src/*.lean"
```

### Output Artifacts

All artifacts stored in `.opencode/specs/NNN_topic_slug/`:

```
.opencode/specs/042_lean_proofs/
├── OVERVIEW.md              # Coordinator summary
│   ├── Executive summary
│   ├── Results table
│   ├── Artifact links
│   └── Mathlib theorems used
├── theorem_manifest.json    # Theorem tracking
├── summaries/
│   ├── add_comm.md         # Per-theorem proof summaries
│   ├── mul_assoc.md
│   └── zero_add.md
└── debug/
    └── failed_theorem.md    # Debug logs for failures
```

---

## MCP Tool Integration

### Required MCP Server

The `lean-proof-specialist` uses the `lean-lsp-mcp` server:

```bash
# Install
pip install lean-lsp-mcp

# Test
uvx --from lean-lsp-mcp lean-goal --help
```

### MCP Tools Used

**Core LSP** (always available):
- `lean_goal` - Extract proof goals at specific positions
- `lean_build` - Compile Lean project
- `lean_diagnostic_messages` - Check for errors/warnings
- `lean_multi_attempt` - Test multiple tactics in parallel

**Search Tools** (rate limited: 3 requests/30s combined):
- `lean_local_search` - Local ripgrep search (**no rate limit, preferred**)
- `lean_leansearch` - Natural language theorem search (rate limited)
- `lean_loogle` - Type signature search (rate limited)
- `lean_state_search` - Goal-based applicable theorem search (rate limited)

### Search Budget Management

The specialist tracks external search API usage:

```yaml
Input Contract:
  rate_limit_budget: 3  # Max external API calls allowed

Specialist Execution:
  1. Try lean_local_search (unlimited)
  2. If no results and budget > 0:
     - Try lean_leansearch (budget -= 1)
  3. If no results and budget > 0:
     - Try lean_loogle (budget -= 1)

Output Contract:
  budget_used: 2  # Actual consumption
```

---

## Differences from Claude Code lean-implementer

### What's Preserved

✅ **Core proof workflow**: Goal extraction → Search → Tactics → Verification  
✅ **Search strategy**: Local-first → External fallback  
✅ **Tactic patterns**: Same goal-to-tactic mapping table  
✅ **MCP tool usage**: Same `lean-lsp-mcp` tools  
✅ **Budget tracking**: Rate limit awareness  
✅ **Lean style guide**: Same style compliance rules

### What's Different

🔄 **Architecture**: Single agent → Three-tier (Primary → Coordinator → Specialist)  
🔄 **Parallelism**: Sequential → Parallel theorem proving  
🔄 **Contracts**: Inline parameters → YAML contracts  
🔄 **Artifacts**: Plan file markers → File-based summaries  
🔄 **Progress tracking**: Checkbox utils → OVERVIEW.md generation  
🔄 **Multi-file processing**: Single implementer → Coordinator batching

### What's Removed

❌ **Plan integration**: No plan file markers (OpenCode doesn't use plan files)  
❌ **Wave execution**: No phase dependencies (single-tier parallel instead)  
❌ **Continuation context**: No context exhaustion handling (OpenCode manages differently)  
❌ **Progress markers**: No `[IN PROGRESS]` / `[COMPLETE]` markers  
❌ **Claude Code libraries**: No dependency on `.claude/lib/` utilities

### What's Added

➕ **Primary orchestrator**: User-facing delegation layer  
➕ **Coordinator**: Multi-theorem batch coordination  
➕ **Artifact structure**: Organized output directory with OVERVIEW.md  
➕ **Parallel launches**: Task tool invocations for all theorems simultaneously  
➕ **Manifest tracking**: JSON tracking file for theorem batch state

---

## Best Practices for OpenCode LEAN Agent

### 1. Budget Management
- Default budget: 3 external searches per specialist
- Coordinator can adjust per-specialist budget based on complexity
- Always try local search first (unlimited)

### 2. Parallel Efficiency
- Coordinator launches all specialists at once
- No dependencies between theorem proofs (independence assumption)
- Faster than sequential proving for batch workloads

### 3. Error Isolation
- Specialist failure doesn't stop other specialists
- Failed theorems logged to debug directory
- Coordinator reports partial success (X/Y theorems proven)

### 4. Artifact Organization
- One summary per proven theorem
- One debug log per failed theorem
- OVERVIEW.md aggregates all results

### 5. Lean Style Compliance
- Follow Lean 4 conventions in all generated code
- Max 100 chars per line
- 2-space indentation
- Snake_case naming for theorems/functions
- PascalCase for types

---

## Testing the Agent

### 1. Simple Test (Single Theorem)

```lean
-- Test file: test.lean
theorem add_comm (a b : Nat) : a + b = b + a := by
  sorry
```

Invoke lean agent:
```
"Prove add_comm in test.lean"
```

Expected output:
- Proof completed with `exact Nat.add_comm a b`
- Summary in `.opencode/specs/NNN/summaries/add_comm.md`
- OVERVIEW.md shows 1/1 proven

### 2. Batch Test (Multiple Theorems)

```lean
-- Test file: batch.lean
theorem add_comm (a b : Nat) : a + b = b + a := by sorry
theorem mul_comm (a b : Nat) : a * b = b * a := by sorry
theorem add_assoc (a b c : Nat) : (a + b) + c = a + (b + c) := by sorry
```

Invoke lean agent:
```
"Prove all theorems in batch.lean"
```

Expected output:
- 3 specialists launched in parallel
- 3 summaries generated
- OVERVIEW.md shows 3/3 proven with results table

### 3. Rate Limit Test

Artificially low budget to test fallback:

```yaml
rate_limit_budget: 0  # Force local-only search
```

Expected behavior:
- Only `lean_local_search` used
- No external API calls
- Proofs succeed if theorems found locally

---

## Troubleshooting

### MCP Server Not Found

**Error**: `lean-lsp-mcp server not available`

**Fix**:
```bash
pip install lean-lsp-mcp
uvx --from lean-lsp-mcp lean-goal --help
```

### Rate Limit Exceeded

**Error**: `rate limit exceeded` in specialist log

**Fix**: Coordinator should increase `rate_limit_budget` or use local-only mode

### Theorem Discovery Fails

**Error**: No theorems found in file

**Causes**:
- No `sorry` markers (file-based mode)
- Theorem names don't match (targeted mode)
- File path incorrect

**Fix**: Validate file path and execution mode

### Proof Verification Fails

**Error**: `lean_build` shows errors after applying tactic

**Causes**:
- Tactic incorrect for goal type
- Mathlib theorem not imported
- Type mismatch

**Fix**: Specialist logs diagnostic errors to debug directory, check debug log for details

---

## Future Enhancements

### Potential Improvements

1. **Context-aware tactic generation**
   - Analyze local proofs for patterns
   - Suggest tactics based on similar theorem structures

2. **Incremental proving**
   - Resume partial proofs across invocations
   - Track `sorry` markers at sub-goal level

3. **Mathlib dependency analysis**
   - Auto-detect required imports
   - Suggest missing `import` statements

4. **Proof quality metrics**
   - Measure proof conciseness
   - Suggest simplifications (e.g., `ring` instead of manual `rw` chains)

5. **Interactive mode**
   - Stream tactic attempts in real-time
   - Allow user to guide proof strategy mid-execution

---

## References

### Claude Code Source
- `.claude/agents/lean-implementer.md` - Original single-agent implementation

### OpenCode Patterns
- `.opencode/agent/research.md` - Research orchestrator pattern
- `.opencode/subagents/research-coordinator.md` - Coordinator pattern
- `.opencode/subagents/research-specialist.md` - Specialist pattern

### Documentation
- `agent/README.md` - Primary agents overview
- `subagents/README.md` - Sub-agents patterns and best practices
- `agent-registry.json` - Agent metadata registry

### External Dependencies
- [lean-lsp-mcp](https://github.com/Seasawher/lean-lsp-mcp) - MCP server for Lean 4 LSP
- [Lean 4 Documentation](https://lean-lang.org/documentation/) - Lean language reference
- [Mathlib4 Docs](https://leanprover-community.github.io/mathlib4_docs/) - Mathlib theorem search

---

**Last Updated**: 2025-12-12  
**Author**: Adapted from Claude Code lean-implementer by Benjamin  
**OpenCode Version**: 1.0.0
