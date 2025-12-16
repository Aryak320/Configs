---
description: "Creates new agent files with proper structure, frontmatter, and workflow stages"
---

<create_agent_request>
  <agent_name>$ARGUMENTS[0]</agent_name>
  <agent_description>$ARGUMENTS[1]</agent_description>
  <agent_type>$ARGUMENTS[2]</agent_type>
</create_agent_request>

<context>
  <system_context>.opencode meta-programming system for self-modification and extension</system_context>
  <domain_context>Agent architecture with coordinators, specialists, and subagents</domain_context>
  <task_context>Generate new agent files following templates and standards</task_context>
  <execution_context>Validate inputs, route to meta agent, create agent file with proper structure, commit to git</execution_context>
</context>

<role>Agent creation coordinator for .opencode system extension</role>

<task>Create new agent files with proper frontmatter, workflow stages, and documentation following agent templates</task>

<instructions>
  1. Validate inputs:
     - agent_name is provided and follows kebab-case naming
     - agent_description is clear and concise
     - agent_type is one of: coordinator, specialist, subagent
  2. Route this request to the meta agent: @meta
  3. Pass agent_name, agent_description, and agent_type from $ARGUMENTS
  4. The meta agent will:
     - Load agent template from context/templates/
     - Generate agent file with proper frontmatter
     - Add workflow stages appropriate for agent type
     - Include delegation patterns (for coordinators)
     - Add execution patterns (for specialists)
     - Create agent file in .opencode/agent/ directory
     - Validate agent structure
     - Commit agent file to git
  5. Return created agent file path to user
</instructions>

<delegation_behavior>
  ## How the Meta Agent Works
  
  The meta agent acts as a **SPECIALIST** that executes directly (no delegation).
  
  ### Why No Delegation?
  
  1. **Specialized Expertise**: Meta-programming IS the meta agent's core competency
  2. **Holistic Understanding**: Creating agents requires understanding entire .opencode architecture
  3. **Direct Execution**: Meta agent directly generates code - this is its primary function
  4. **No Benefit from Delegation**: Breaking meta-programming into sub-tasks would add complexity
  
  ### What the Meta Agent Does
  
  ✅ **Direct Execution**:
  - Validates agent specifications
  - Loads appropriate templates (coordinator, specialist, subagent)
  - Generates agent frontmatter with proper metadata
  - Creates workflow stages appropriate for agent type
  - Adds delegation patterns for coordinators
  - Adds execution patterns for specialists
  - Writes agent file to .opencode/agent/ directory
  - Validates agent structure against standards
  - Commits agent file to git
  - Returns agent file path
  
  ### Example Execution Flow
  
  ```
  User: /create-agent "performance-analyzer" "Analyzes NeoVim performance metrics" "specialist"
  
  Meta Agent:
    1. Validates inputs:
       - agent_name: "performance-analyzer" ✓
       - agent_description: "Analyzes NeoVim performance metrics" ✓
       - agent_type: "specialist" ✓
    
    2. Loads specialist agent template
    
    3. Generates agent frontmatter:
       ---
       name: performance-analyzer
       type: specialist
       description: Analyzes NeoVim performance metrics
       version: 1.0.0
       ---
    
    4. Creates workflow stages:
       - Stage 1: Load performance data
       - Stage 2: Analyze metrics
       - Stage 3: Generate report
       - Stage 4: Return findings
    
    5. Adds execution patterns (specialist-specific)
    
    6. Writes to .opencode/agent/performance-analyzer.md
    
    7. Validates structure
    
    8. Commits: "feat(agent): add performance-analyzer specialist"
    
    9. Returns: .opencode/agent/performance-analyzer.md
  
  Result: New specialist agent created and ready to use
  ```
</delegation_behavior>

<usage_examples>
  <example_1>
    <command>/create-agent "performance-analyzer" "Analyzes NeoVim performance metrics" "specialist"</command>
    <result>Creates specialist agent for performance analysis in .opencode/agent/performance-analyzer.md</result>
  </example_1>
  
  <example_2>
    <command>/create-agent "plugin-coordinator" "Coordinates plugin installation and configuration" "coordinator"</command>
    <result>Creates coordinator agent with delegation patterns in .opencode/agent/plugin-coordinator.md</result>
  </example_2>
  
  <example_3>
    <command>/create-agent "config-validator" "Validates NeoVim configuration files" "subagent"</command>
    <result>Creates subagent for configuration validation in .opencode/agent/subagents/config-validator.md</result>
  </example_3>
</usage_examples>
