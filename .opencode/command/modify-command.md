---
description: "Modifies existing command files with new parameters, routing, or documentation"
---

<modify_command_request>
  <command_name>$ARGUMENTS[0]</command_name>
  <modification_description>$ARGUMENTS[1]</modification_description>
</modify_command_request>

<context>
  <system_context>.opencode meta-programming system for self-modification and extension</system_context>
  <domain_context>Command architecture modification and enhancement</domain_context>
  <task_context>Modify existing command files while preserving structure and standards</task_context>
  <execution_context>Validate inputs, route to meta agent, modify command file, validate changes, commit to git</execution_context>
</context>

<role>Command modification coordinator for .opencode system enhancement</role>

<task>Modify existing command files with new parameters, routing logic, or documentation while maintaining standards compliance</task>

<instructions>
  1. Validate inputs:
     - command_name is provided and exists in .opencode/command/
     - modification_description clearly describes changes
  2. Route this request to the meta agent: @meta
  3. Pass command_name and modification_description from $ARGUMENTS
  4. The meta agent will:
     - Read existing command file
     - Parse current structure and frontmatter
     - Apply requested modifications:
       * Add new parameters
       * Update routing logic
       * Change agent routing
       * Enhance documentation
       * Add usage examples
       * Update context sections
     - Preserve existing structure and standards
     - Validate modified command structure
     - Write updated command file
     - Commit changes to git
  5. Return modified command file path to user
</instructions>

<delegation_behavior>
  ## How the Meta Agent Works
  
  The meta agent acts as a **SPECIALIST** that executes directly (no delegation).
  
  ### Why No Delegation?
  
  1. **Specialized Expertise**: Meta-programming IS the meta agent's core competency
  2. **Holistic Understanding**: Modifying commands requires understanding entire .opencode architecture
  3. **Direct Execution**: Meta agent directly modifies code - this is its primary function
  4. **No Benefit from Delegation**: Breaking meta-programming into sub-tasks would add complexity
  
  ### What the Meta Agent Does
  
  ✅ **Direct Execution**:
  - Validates command exists
  - Reads existing command file
  - Parses current structure, frontmatter, and parameters
  - Analyzes modification requirements
  - Applies requested changes:
    * Adds new parameters to request structure
    * Updates routing instructions
    * Changes agent routing (if needed)
    * Enhances context sections
    * Improves documentation
    * Adds new usage examples
  - Preserves existing structure and standards
  - Validates modified command against standards
  - Writes updated command file
  - Commits changes to git with descriptive message
  - Returns modified command file path
  
  ### Example Execution Flow
  
  ```
  User: /modify-command "research" "Add optional complexity parameter for research depth control"
  
  Meta Agent:
    1. Validates inputs:
       - command_name: "research" ✓ (exists in .opencode/command/)
       - modification_description: "Add optional complexity parameter..." ✓
    
    2. Reads .opencode/command/research.md
    
    3. Parses current structure:
       - Current parameters: research_prompt
       - Routing: @researcher
       - Usage examples: 3 examples
    
    4. Analyzes modification requirements:
       - Add complexity parameter
       - Update request structure
       - Update routing instructions
       - Add usage example with complexity
    
    5. Applies modifications:
       - Updates request structure:
         <research_prompt>$ARGUMENTS[0]</research_prompt>
         <complexity>$ARGUMENTS[1]</complexity>
       - Updates routing instructions:
         "Pass research_prompt and optional complexity from $ARGUMENTS"
       - Adds usage example:
         /research "Optimize lazy.nvim" "3"
       - Updates documentation
    
    6. Preserves existing:
       - Frontmatter description
       - Context sections
       - Agent routing (@researcher)
       - Other usage examples
    
    7. Validates modified structure
    
    8. Writes updated .opencode/command/research.md
    
    9. Commits: "feat(command): add complexity parameter to research command"
    
    10. Returns: .opencode/command/research.md
  
  Result: Research command enhanced with complexity control
  ```
</delegation_behavior>

<usage_examples>
  <example_1>
    <command>/modify-command "research" "Add optional complexity parameter for research depth control"</command>
    <result>Adds complexity parameter to research command in .opencode/command/research.md</result>
  </example_1>
  
  <example_2>
    <command>/modify-command "plan" "Change routing to new planner-v2 agent"</command>
    <result>Updates plan command to route to planner-v2 in .opencode/command/plan.md</result>
  </example_2>
  
  <example_3>
    <command>/modify-command "implement" "Add dry-run parameter for validation without execution"</command>
    <result>Adds dry-run capability to implement command in .opencode/command/implement.md</result>
  </example_3>
</usage_examples>
