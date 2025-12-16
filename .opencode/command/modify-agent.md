---
description: "Modifies existing agent files with new capabilities, workflow stages, or documentation"
---

<modify_agent_request>
  <agent_name>$ARGUMENTS[0]</agent_name>
  <modification_description>$ARGUMENTS[1]</modification_description>
</modify_agent_request>

<context>
  <system_context>.opencode meta-programming system for self-modification and extension</system_context>
  <domain_context>Agent architecture modification and enhancement</domain_context>
  <task_context>Modify existing agent files while preserving structure and standards</task_context>
  <execution_context>Validate inputs, route to meta agent, modify agent file, validate changes, commit to git</execution_context>
</context>

<role>Agent modification coordinator for .opencode system enhancement</role>

<task>Modify existing agent files with new capabilities, workflow stages, or documentation while maintaining standards compliance</task>

<instructions>
  1. Validate inputs:
     - agent_name is provided and exists in .opencode/agent/
     - modification_description clearly describes changes
  2. Route this request to the meta agent: @meta
  3. Pass agent_name and modification_description from $ARGUMENTS
  4. The meta agent will:
     - Read existing agent file
     - Parse current structure and frontmatter
     - Apply requested modifications:
       * Add new workflow stages
       * Update delegation patterns
       * Enhance documentation
       * Add new capabilities
       * Modify execution patterns
     - Preserve existing structure and standards
     - Validate modified agent structure
     - Write updated agent file
     - Commit changes to git
  5. Return modified agent file path to user
</instructions>

<delegation_behavior>
  ## How the Meta Agent Works
  
  The meta agent acts as a **SPECIALIST** that executes directly (no delegation).
  
  ### Why No Delegation?
  
  1. **Specialized Expertise**: Meta-programming IS the meta agent's core competency
  2. **Holistic Understanding**: Modifying agents requires understanding entire .opencode architecture
  3. **Direct Execution**: Meta agent directly modifies code - this is its primary function
  4. **No Benefit from Delegation**: Breaking meta-programming into sub-tasks would add complexity
  
  ### What the Meta Agent Does
  
  ✅ **Direct Execution**:
  - Validates agent exists
  - Reads existing agent file
  - Parses current structure, frontmatter, and workflow stages
  - Analyzes modification requirements
  - Applies requested changes:
    * Adds new workflow stages
    * Updates delegation patterns (for coordinators)
    * Enhances execution patterns (for specialists)
    * Improves documentation
    * Adds new capabilities
  - Preserves existing structure and standards
  - Validates modified agent against standards
  - Writes updated agent file
  - Commits changes to git with descriptive message
  - Returns modified agent file path
  
  ### Example Execution Flow
  
  ```
  User: /modify-agent "researcher" "Add parallel research capability for 5 concurrent subagents"
  
  Meta Agent:
    1. Validates inputs:
       - agent_name: "researcher" ✓ (exists in .opencode/agent/)
       - modification_description: "Add parallel research capability..." ✓
    
    2. Reads .opencode/agent/researcher.md
    
    3. Parses current structure:
       - Type: coordinator
       - Current stages: 4 stages
       - Delegation pattern: sequential subagent invocation
    
    4. Analyzes modification requirements:
       - Add parallel execution capability
       - Update delegation pattern
       - Modify workflow stages
       - Update documentation
    
    5. Applies modifications:
       - Updates Stage 3: "Invoke research subagents in parallel (max 5)"
       - Modifies delegation pattern to use parallel task() calls
       - Updates documentation with parallelization benefits
       - Adds context reduction metrics (95% reduction)
    
    6. Preserves existing:
       - Frontmatter structure
       - Other workflow stages
       - Agent type (coordinator)
       - Core responsibilities
    
    7. Validates modified structure
    
    8. Writes updated .opencode/agent/researcher.md
    
    9. Commits: "feat(agent): add parallel research to researcher agent"
    
    10. Returns: .opencode/agent/researcher.md
  
  Result: Researcher agent enhanced with parallel execution capability
  ```
</delegation_behavior>

<usage_examples>
  <example_1>
    <command>/modify-agent "researcher" "Add parallel research capability for 5 concurrent subagents"</command>
    <result>Enhances researcher agent with parallel execution in .opencode/agent/researcher.md</result>
  </example_1>
  
  <example_2>
    <command>/modify-agent "planner" "Add wave-based phase organization with dependency tracking"</command>
    <result>Updates planner agent with wave-based planning in .opencode/agent/planner.md</result>
  </example_2>
  
  <example_3>
    <command>/modify-agent "implementer" "Add rollback capability for failed implementations"</command>
    <result>Adds rollback workflow stage to implementer agent in .opencode/agent/implementer.md</result>
  </example_3>
</usage_examples>
