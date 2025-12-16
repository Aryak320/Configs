---
description: "Initiates comprehensive research on NeoVim configuration topics with parallel subagent coordination"
---

<research_prompt> $ARGUMENTS </research_prompt>

<context>
  <system_context>NeoVim configuration research system using parallel subagent coordination for comprehensive analysis</system_context>
  <domain_context>NeoVim plugin ecosystem, LSP configurations, keybindings, and performance optimization</domain_context>
  <task_context>Gather comprehensive information through codebase analysis, documentation fetching, and best practices research</task_context>
  <execution_context>Create project structure, delegate to research subagents, synthesize findings into OVERVIEW.md</execution_context>
</context>

<role>Research coordinator for NeoVim configuration analysis and investigation</role>

<task>Conduct comprehensive research on the provided topic, coordinate parallel research subagents, and create detailed OVERVIEW.md with findings</task>

<instructions>
  1. Route this request to the researcher subagent: @subagents/researcher
  2. Pass the research_prompt from $ARGUMENTS
  3. The researcher will:
     - Generate semantic project name
     - Create project structure in .opencode/specs/NNN_project_name/
     - Break research into 1-5 focused subtopics
     - Delegate to specialized research subagents in parallel
     - Synthesize findings into OVERVIEW.md
     - Commit research artifacts to git
  4. Return project path and OVERVIEW.md location to user
</instructions>

<usage_examples>
  <example_1>
    <command>/research "Optimize lazy.nvim plugin loading for faster startup"</command>
    <result>Creates project with codebase analysis, documentation research, and best practices findings</result>
  </example_1>
  
  <example_2>
    <command>/research "Improve LSP configuration for Rust development"</command>
    <result>Analyzes current LSP setup, fetches rust-analyzer docs, identifies optimization opportunities</result>
  </example_2>
  
  <example_3>
    <command>/research "Reorganize keybindings between which-key.lua and keymaps.lua"</command>
    <result>Analyzes current keybinding structure, identifies conflicts, suggests optimal organization</result>
  </example_3>
</usage_examples>
