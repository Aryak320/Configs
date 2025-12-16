# Research Subagents

Research specialists invoked by the researcher primary agent during parallel research phases.

---

## Purpose

These agents gather, analyze, and report information during research phases. They share common characteristics:
- Read-only operations
- Report generation
- Brief summary returns
- Parallel execution (up to 5 concurrent)

---

## Agents

### codebase-analyzer.md
**Purpose**: Scans NeoVim config for patterns and existing implementations

**Responsibilities**:
- Analyze plugin configurations
- Extract keybinding organization
- Identify optimization opportunities
- Map current architecture

**Returns**: Brief summary + detailed report path

---

### docs-fetcher.md
**Purpose**: Fetches external documentation from GitHub and official sites

**Responsibilities**:
- Retrieve plugin/API documentation
- Cache resources (7-day TTL)
- Parse for relevant sections
- Use gh CLI for GitHub access

**Returns**: Brief summary + cached doc paths

---

### best-practices-researcher.md
**Purpose**: Researches community patterns and optimization strategies

**Responsibilities**:
- Find community best practices
- Benchmark performance patterns
- Analyze trade-offs
- Identify anti-patterns

**Returns**: Brief summary + recommendations

---

### dependency-analyzer.md
**Purpose**: Maps plugin dependency chains and compatibility

**Responsibilities**:
- Analyze plugin dependencies
- Check version requirements
- Identify conflicts
- Map load order

**Returns**: Brief summary + dependency graph

---

### refactor-finder.md
**Purpose**: Identifies improvement opportunities and unused code

**Responsibilities**:
- Find unused code and plugins
- Detect duplicate configurations
- Suggest optimizations
- Identify complexity issues

**Returns**: Brief summary + refactoring opportunities

---

## Invocation

Research subagents are invoked by the researcher primary agent (`agent/researcher.md`) during research phases. They are never invoked directly by commands.

**Example workflow**:
```
User → /research "topic"
  ↓
Orchestrator → @researcher
  ↓
Researcher → Parallel invocation:
  ├─ @subagents/research/codebase-analyzer
  ├─ @subagents/research/docs-fetcher
  ├─ @subagents/research/best-practices-researcher
  └─ @subagents/research/dependency-analyzer
  ↓
Researcher ← Brief summaries + report paths
  ↓
Researcher → Creates OVERVIEW.md
```

---

## Context Reduction

Research subagents enable 95%+ context reduction through:
- Brief summary returns (1-2 paragraphs)
- Artifact path passing (not content)
- Metadata-only communication
- Parallel execution without blocking

The researcher agent never reads full reports, only summaries and paths.
