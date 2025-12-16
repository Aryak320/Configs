# Analysis Subagents

Specialized analysis tools for specific aspects of NeoVim configuration.

---

## Purpose

These agents provide deep-dive analysis for specific concerns. They can be:
- Invoked standalone via commands
- Invoked during research phases
- Used for targeted diagnostics

---

## Agents

### cruft-finder.md
**Purpose**: Identifies unused code, plugins, and orphaned configurations

**Responsibilities**:
- Find disabled plugins (enabled = false)
- Detect dead code
- Locate orphaned files
- Identify duplicate configurations
- Assess removal safety

**Command**: `/remove-cruft`

**Returns**: Cruft report with removal recommendations

---

### plugin-analyzer.md
**Purpose**: Deep plugin analysis and compatibility checking

**Responsibilities**:
- Analyze lazy.nvim configurations
- Check plugin compatibility
- Identify optimization opportunities
- Assess plugin health
- Detect conflicts

**Invocation**: Via researcher agent or standalone

**Returns**: Plugin analysis report

---

### performance-profiler.md
**Purpose**: Startup time analysis and performance optimization

**Responsibilities**:
- Measure startup time (nvim --startuptime)
- Profile plugin loading
- Identify bottlenecks
- Recommend lazy-loading strategies
- Memory analysis

**Command**: `/optimize-performance`

**Returns**: Performance report with optimizations

---

## Invocation Patterns

### Standalone (via commands)
```
User → /remove-cruft
  ↓
Orchestrator → @subagents/analysis/cruft-finder
  ↓
User ← Cruft report
```

### During Research
```
Researcher → @subagents/analysis/plugin-analyzer
  ↓
Researcher ← Brief summary + report path
```

---

## Use Cases

**cruft-finder**:
- Regular maintenance
- Pre-optimization cleanup
- Configuration simplification

**plugin-analyzer**:
- Plugin health checks
- Compatibility verification
- Optimization planning

**performance-profiler**:
- Startup time optimization
- Bottleneck identification
- Lazy-loading improvements

---

## Context Reduction

Analysis subagents enable context reduction through:
- Brief summary returns
- Report path passing
- Focused analysis scope
- Clear actionable recommendations
