# LEAN Agent Quick Start Guide

Fast reference for using the LEAN theorem proving agent in OpenCode.

## Prerequisites

### 1. Install MCP Server

```bash
pip install lean-lsp-mcp
```

### 2. Verify Installation

```bash
uvx --from lean-lsp-mcp lean-goal --help
```

Expected output: Usage information for `lean-goal` tool

---

## Basic Usage

### Prove All Theorems in File

```
User: "Prove all theorems in /path/to/file.lean"
```

**What happens**:
1. LEAN agent discovers all `sorry` markers
2. Coordinator launches specialist for each theorem
3. Specialists prove theorems in parallel
4. Results aggregated in `.opencode/specs/NNN_lean_proofs/`

### Prove Specific Theorems

```
User: "Prove add_comm and mul_assoc in /path/to/file.lean"
```

**What happens**:
1. LEAN agent finds specified theorems by name
2. Coordinator launches specialists for just those theorems
3. Other `sorry` markers ignored

### Batch Processing

```
User: "Prove all theorems in src/ProofChecker/*.lean"
```

**What happens**:
1. LEAN agent discovers all Lean files matching pattern
2. Coordinator processes each file
3. Specialists work on all theorems across all files

---

## Output Structure

All artifacts saved to `.opencode/specs/NNN_topic_slug/`:

```
.opencode/specs/042_lean_proofs/
│
├── OVERVIEW.md                  # ← Start here for results summary
│   ├── Executive summary
│   ├── Theorem results table
│   ├── Mathlib theorems used
│   └── Links to all artifacts
│
├── theorem_manifest.json        # Batch tracking (internal)
│
├── summaries/                   # ← Successful proof details
│   ├── add_comm.md
│   │   ├── Goal & hypotheses
│   │   ├── Solution tactics
│   │   ├── Mathlib references
│   │   └── Search tool usage
│   ├── mul_assoc.md
│   └── zero_add.md
│
└── debug/                       # ← Failed proof analysis
    ├── failed_theorem_1.md
    │   ├── Attempted tactics
    │   ├── Error messages
    │   ├── Goal structure
    │   └── Suggestions
    └── partial_theorem_2.md
```

---

## Understanding Results

### OVERVIEW.md Format

```markdown
# LEAN Implementation: Prove Basic Arithmetic

## Executive Summary
Processed 5 theorems in Truth.lean:
- **Proven**: 4 theorems (80%)
- **Partial**: 1 theorem (20%)
- **Failed**: 0 theorems

## Theorem Results

| Theorem | Status | Tactics | Attempts | Budget |
|---------|--------|---------|----------|--------|
| add_comm | COMPLETE | exact | 1/3 | 0/3 |
| mul_comm | COMPLETE | ring | 1/3 | 1/3 |
| add_assoc | COMPLETE | exact | 1/3 | 0/3 |
| zero_add | PARTIAL | intro | 3/3 | 3/3 |
| mul_zero | COMPLETE | simp | 2/3 | 2/3 |

## Mathlib Theorems Used
- `Nat.add_comm` - [Link]
- `Nat.mul_comm` - [Link]
- ...
```

### Status Values

| Status | Meaning |
|--------|---------|
| **COMPLETE** | Proof fully verified, no `sorry` remaining |
| **PARTIAL** | Some progress made, but proof incomplete |
| **FAILED** | No successful tactics found after max attempts |

### Budget Column

`X/Y` format where:
- **X** = External searches used (lean_leansearch, lean_loogle)
- **Y** = Budget limit (default: 3 per theorem)

**Example**: `2/3` means 2 external searches used, 1 remaining

---

## Common Workflows

### 1. Prove Single Theorem

**Scenario**: You have one `sorry` marker to fix

```
User: "Prove theorem_name in file.lean"
```

**Expected time**: 10-30 seconds  
**Output**: 1 proof summary

---

### 2. Complete Entire File

**Scenario**: File has multiple `sorry` markers

```
User: "Prove all theorems in file.lean"
```

**Expected time**: N × 15 seconds (N = theorem count, parallel)  
**Output**: N proof summaries + 1 overview

---

### 3. Fix Failed Proofs

**Scenario**: Some theorems failed, need retry

**Step 1**: Check `OVERVIEW.md` for failed/partial theorems
**Step 2**: Read debug logs in `debug/` directory
**Step 3**: Retry with specific theorem:

```
User: "Prove failed_theorem_name in file.lean"
```

---

### 4. Verify Existing Proofs

**Scenario**: Check if file has any remaining `sorry` markers

```
User: "Check for unproven theorems in file.lean"
```

**What happens**:
- Agent scans file for `sorry` markers
- If none found: Reports "All theorems proven"
- If found: Lists unproven theorems

---

## Search Strategy

### Local-First Approach

**Step 1**: Local search (unlimited)
```
lean_local_search "theorem name"
```
- Fast ripgrep through project files
- No rate limits
- Searches local definitions and imported Mathlib

**Step 2**: External search (budget-aware)

Only if local search fails:
```
lean_leansearch "natural language description"
lean_loogle "Type → Type → Type"
```
- Rate limited: 3 requests/30s combined
- Budget tracked per theorem
- Falls back to local if budget exhausted

---

## Tactic Patterns

Common goal patterns and generated tactics:

### Commutativity
```lean
-- Goal: a + b = b + a
-- Tactics: exact Nat.add_comm a b, rw [Nat.add_comm]
```

### Associativity
```lean
-- Goal: (a + b) + c = a + (b + c)
-- Tactics: exact Nat.add_assoc, ring
```

### Universal Quantification
```lean
-- Goal: ∀ x, P x
-- Tactics: intro x, intros
```

### Conjunction
```lean
-- Goal: P ∧ Q
-- Tactics: constructor
```

### Disjunction
```lean
-- Goal: P ∨ Q
-- Tactics: left, right
```

### Equality
```lean
-- Goal: x = y
-- Tactics: rfl, simp, ring
```

---

## Troubleshooting

### "MCP server not available"

**Cause**: `lean-lsp-mcp` not installed

**Fix**:
```bash
pip install lean-lsp-mcp
uvx --from lean-lsp-mcp lean-goal --help
```

---

### "No theorems found"

**Cause**: File has no `sorry` markers or theorem names don't match

**Fix**:
- Check file has `sorry` markers: `grep -n sorry file.lean`
- Verify theorem names exact match
- Use file-based mode: "Prove all theorems in file.lean"

---

### "Rate limit exceeded"

**Cause**: Too many external searches in 30-second window

**Fix**: Wait 30 seconds, or increase budget in next invocation

**Prevention**: Agent automatically falls back to local search when budget exhausted

---

### "Proof verification failed"

**Cause**: Applied tactic has errors

**Check**: 
1. Read debug log: `.opencode/specs/NNN/debug/theorem_name.md`
2. Look for diagnostic errors
3. Check if Mathlib imports missing

**Fix**: Add required imports to Lean file, retry

---

### "Partial proof (subgoals remaining)"

**Cause**: Tactic succeeded but didn't complete proof

**Check**:
1. Read proof summary: `.opencode/specs/NNN/summaries/theorem_name.md`
2. Look for "Remaining subgoals" section
3. Identify what's left to prove

**Fix**: 
- Add manual tactics for remaining subgoals
- Or provide hint to agent: "Prove X using tactic Y"

---

## Advanced Usage

### Custom Budget

For complex theorems needing more external searches:

```
User: "Prove complex_theorem in file.lean with budget 5"
```

**Effect**: Specialist gets 5 external search requests instead of default 3

---

### Debug Mode

Get detailed logging of proof attempts:

```
User: "Prove theorem_name in file.lean with debug logging"
```

**Effect**: All tactic attempts logged to debug directory, even successful ones

---

### Mathlib Discovery

Find theorems before proving:

```
User: "Search Mathlib for theorems about list concatenation"
```

**Returns**: List of relevant Mathlib theorems without applying them

---

## Performance Tips

### 1. Batch Similar Theorems

Group theorems by type for better Mathlib reuse:

```
User: "Prove all addition theorems in arithmetic.lean"
```

**Benefit**: Later theorems may find needed theorems from earlier proofs

---

### 2. Start with Simple Theorems

Prove basic lemmas first, use them for complex theorems:

```
User: "Prove helper_lemma_1 and helper_lemma_2 first, then main_theorem"
```

**Benefit**: Local search finds your helper lemmas for main theorem

---

### 3. Provide Context

Mention relevant Mathlib modules:

```
User: "Prove list_theorem in file.lean (use Mathlib.Data.List)"
```

**Benefit**: Specialist focuses search on specific Mathlib area

---

## File Organization

### Project Structure

```
my-lean-project/
├── ProofChecker/
│   ├── Truth.lean          # Source files with sorry markers
│   ├── Modal.lean
│   └── Syntax.lean
│
├── .opencode/
│   └── specs/
│       └── 042_lean_proofs/
│           ├── OVERVIEW.md         # Results summary
│           ├── summaries/          # Successful proofs
│           └── debug/              # Failed attempts
│
└── lakefile.lean          # Lean project config
```

### Recommended Workflow

1. **Write theorem signatures** with `sorry` placeholders
2. **Invoke LEAN agent** to prove all at once
3. **Review OVERVIEW.md** for results
4. **Read proof summaries** to understand tactics
5. **Fix failed proofs** manually or retry with hints
6. **Commit proven theorems** to version control

---

## Integration with Lean Workflow

### Before Proving

```bash
# Ensure project builds
lake build

# Check for syntax errors
lake build --verbose
```

### After Proving

```bash
# Verify all proofs compile
lake build

# Run tests (if any)
lake test

# Commit changes
git add ProofChecker/
git commit -m "Prove arithmetic theorems via LEAN agent"
```

---

## Examples

### Example 1: Simple Arithmetic

**Input**:
```lean
theorem add_comm (a b : Nat) : a + b = b + a := by
  sorry
```

**Command**: "Prove add_comm in arithmetic.lean"

**Output** (OVERVIEW.md):
```markdown
## Theorem Results
| Theorem | Status | Tactics | Attempts |
|---------|--------|---------|----------|
| add_comm | COMPLETE | exact | 1/3 |

Mathlib: Nat.add_comm
```

---

### Example 2: Multiple Theorems

**Input**:
```lean
theorem add_comm (a b : Nat) : a + b = b + a := by sorry
theorem mul_comm (a b : Nat) : a * b = b * a := by sorry
theorem add_assoc (a b c : Nat) : (a + b) + c = a + (b + c) := by sorry
```

**Command**: "Prove all theorems in arithmetic.lean"

**Output** (OVERVIEW.md):
```markdown
## Executive Summary
Processed 3 theorems:
- Proven: 3 (100%)
- Partial: 0
- Failed: 0

## Theorem Results
| Theorem | Status | Tactics | Attempts |
|---------|--------|---------|----------|
| add_comm | COMPLETE | exact | 1/3 |
| mul_comm | COMPLETE | exact | 1/3 |
| add_assoc | COMPLETE | exact | 1/3 |
```

---

### Example 3: Partial Proof

**Input**:
```lean
theorem complex_proof (n : Nat) : ∀ m, n + m = m + n := by
  sorry
```

**Command**: "Prove complex_proof in file.lean"

**Output** (debug/complex_proof.md):
```markdown
## Attempted Tactics

### Attempt 1/3
**Tactic**: `intro m`
**Result**: PARTIAL SUCCESS
**Remaining subgoal**: `⊢ n + m = m + n`

### Attempt 2/3
**Tactic**: `intro m; exact Nat.add_comm n m`
**Result**: SUCCESS

## Final Status: COMPLETE (2 attempts)
```

---

## Quick Reference Card

| Task | Command |
|------|---------|
| Prove all in file | "Prove all theorems in file.lean" |
| Prove specific | "Prove theorem_name in file.lean" |
| Prove multiple | "Prove thm1 and thm2 in file.lean" |
| Batch files | "Prove all in src/*.lean" |
| Check for sorry | "Find unproven theorems in file.lean" |
| Retry failed | "Prove failed_theorem in file.lean" |

---

## Additional Resources

### Documentation
- [LEAN Agent Setup](LEAN_AGENT_SETUP.md) - Complete architecture guide
- [Primary Agents](agent/README.md) - Orchestrator patterns
- [Sub-Agents](subagents/README.md) - Coordinator and specialist patterns

### Lean 4 Resources
- [Lean 4 Manual](https://lean-lang.org/documentation/)
- [Mathlib4 Docs](https://leanprover-community.github.io/mathlib4_docs/)
- [Lean Zulip Chat](https://leanprover.zulipchat.com/)

### MCP Server
- [lean-lsp-mcp GitHub](https://github.com/Seasawher/lean-lsp-mcp)
- [MCP Protocol Docs](https://modelcontextprotocol.io/)

---

**Last Updated**: 2025-12-12  
**Version**: 1.0.0
