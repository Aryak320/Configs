---
description: "Profiles startup time and recommends lazy-loading optimizations"
---

<context>
  <system_context>NeoVim performance profiling and optimization system</system_context>
  <domain_context>Startup time analysis, plugin loading profiling, lazy-loading optimization</domain_context>
  <task_context>Measure performance, identify bottlenecks, recommend optimizations</task_context>
</context>

<role>Performance profiling and optimization coordinator</role>

<task>Profile NeoVim startup, identify bottlenecks, and recommend lazy-loading optimizations</task>

<instructions>
  1. Route this request to the performance-profiler subagent: @subagents/analysis/performance-profiler
  2. The profiler will:
     - Run nvim --startuptime analysis
     - Profile plugin loading times
     - Identify performance bottlenecks
     - Analyze lazy.nvim configuration
     - Compare against benchmarks
     - Recommend lazy-loading strategies
     - Return performance report with specific optimizations
  3. Display results with bottlenecks highlighted
  4. Show before/after projections for recommended optimizations
</instructions>

<usage_examples>
  <example>
    <command>/optimize-performance</command>
    <result>Profiles startup, identifies slow plugins, recommends lazy-loading improvements</result>
  </example>
</usage_examples>
