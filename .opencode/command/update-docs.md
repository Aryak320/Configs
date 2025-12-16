---
description: "Updates documentation for NeoVim configurations and modules"
---

<doc_request>
  <target>$ARGUMENTS[0]</target>
</doc_request>

<context>
  <system_context>NeoVim documentation generation and update system</system_context>
  <domain_context>Module documentation, usage examples, configuration guides, keybinding docs</domain_context>
  <task_context>Generate or update documentation for specified targets</task_context>
</context>

<role>Documentation generation coordinator</role>

<task>Create or update documentation for NeoVim configurations</task>

<instructions>
  1. Route this request to the documenter agent: @documenter
  2. Pass target (module path, "all", or "keybindings")
  3. The documenter will:
     - Analyze code to document
     - Extract function signatures and parameters
     - Identify configuration options
     - Generate usage examples
     - Create or update markdown documentation
     - Follow documentation standards
     - Return brief summary with updated doc paths
  4. Display list of updated documentation files
</instructions>

<delegation_behavior>
  ## How the Documenter Works
  
  The documenter agent acts as a **DOCUMENTATION COORDINATOR**, not an executor.
  
  ### What the Documenter Does
  
  ✅ **Coordination**:
  - Analyzes documentation requirements
  - Determines doc types needed (module docs, examples, guides, READMEs)
  - Invokes documentation subagents for each doc type
  - Collects brief summaries from doc subagents
  - Aggregates results into overall documentation summary
  - Returns list of updated documentation files
  
  ✅ **Documentation Orchestration**:
  - Organizes docs by type
  - Runs independent doc generation in parallel
  - Monitors doc completion
  - Aggregates documentation results
  
  ### What the Documenter Delegates
  
  🔄 **All Documentation Generation**:
  - Module documentation → `subagents/documentation/module-documenter`
  - Usage examples → `subagents/documentation/example-generator`
  - Configuration guides → `subagents/documentation/guide-writer`
  - README files → `subagents/documentation/readme-generator`
  
  ### Benefits of Delegation
  
  💡 **Context Window Efficiency**:
  - Documenter maintains small context (coordination only)
  - Doc subagents load only what they need for their doc type
  - Brief summaries instead of full documentation (95% context reduction)
  - Enables parallel generation of independent docs (40-60% time savings)
  
  💡 **Specialist Expertise**:
  - module-documenter knows how to analyze code and extract documentation
  - example-generator knows how to create clear, practical examples
  - guide-writer knows how to write comprehensive guides
  - readme-generator knows README structure and conventions
  - Each subagent is optimized for its doc type
  
  💡 **Better Quality**:
  - Specialists produce higher quality documentation
  - Focused documentation per doc type
  - Comprehensive coverage through parallel generation
  
  ### Example Execution Flow
  
  ```
  User: /update-docs lua/plugins/telescope.lua
  
  Documenter:
    1. Determines doc types needed:
       - Module documentation
       - Usage examples
       - README update
    
    2. Launches 3 doc subagents in parallel:
       
       # Doc 1: Module documentation
       task(
         subagent_type="subagents/documentation/module-documenter",
         description="Document telescope.lua module",
         prompt="Create comprehensive documentation for telescope.lua..."
       )
       
       # Doc 2: Usage examples
       task(
         subagent_type="subagents/documentation/example-generator",
         description="Generate telescope usage examples",
         prompt="Create usage examples for telescope pickers..."
       )
       
       # Doc 3: README update
       task(
         subagent_type="subagents/documentation/readme-generator",
         description="Update plugins README",
         prompt="Update lua/plugins/README.md with telescope section..."
       )
    
    3. Receives 3 brief summaries:
       - Module: "Created telescope.md with 5 sections. Coverage: 100%."
       - Examples: "Generated 4 usage examples. File: TELESCOPE_EXAMPLES.md"
       - README: "Updated plugins README with telescope section."
    
    4. Aggregates results:
       Documentation updated:
       - lua/plugins/telescope.md (new)
       - docs/TELESCOPE_EXAMPLES.md (new)
       - lua/plugins/README.md (updated)
    
    5. Returns documentation summary to user
  
  Result: Comprehensive documentation via subagent delegation
  Context: Documenter saw ~300 tokens (summaries) instead of ~5,000 tokens (full docs) = 94% reduction
  Time: Parallel execution saved 40-60% time vs sequential
  ```
</delegation_behavior>

<usage_examples>
  <example_1>
    <command>/update-docs all</command>
    <result>Updates all module documentation</result>
  </example_1>
  
  <example_2>
    <command>/update-docs lua/plugins/lsp</command>
    <result>Updates LSP plugin documentation</result>
  </example_2>
  
  <example_3>
    <command>/update-docs keybindings</command>
    <result>Updates keybinding documentation</result>
  </example_3>
</usage_examples>
