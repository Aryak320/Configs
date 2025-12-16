---
description: "Creates new command files with proper structure, routing, and documentation"
---

<create_command_request>
  <command_name>$ARGUMENTS[0]</command_name>
  <command_description>$ARGUMENTS[1]</command_description>
  <agent_name>$ARGUMENTS[2]</agent_name>
</create_command_request>

<context>
  <system_context>.opencode meta-programming system for self-modification and extension</system_context>
  <domain_context>Command architecture with agent routing and parameter handling</domain_context>
  <task_context>Generate new command files following templates and standards</task_context>
  <execution_context>Validate inputs, route to meta agent, create command file with proper structure, commit to git</execution_context>
</context>

<role>Command creation coordinator for .opencode system extension</role>

<task>Create new command files with proper frontmatter, agent routing, and usage examples following command templates</task>

<instructions>
  1. Validate inputs:
     - command_name is provided and follows kebab-case naming
     - command_description is clear and concise
     - agent_name exists in .opencode/agent/ directory
  2. Route this request to the meta agent: @meta
  3. Pass command_name, command_description, and agent_name from $ARGUMENTS
  4. The meta agent will:
     - Load command template from context/templates/
     - Generate command file with proper frontmatter
     - Add request parameter structure
     - Add context sections (system, domain, task, execution)
     - Add role and task definitions
     - Add routing instructions to specified agent
     - Add agent behavior documentation
     - Add 2-3 usage examples
     - Create command file in .opencode/command/ directory
     - Validate command structure
     - Commit command file to git
  5. Return created command file path to user
</instructions>

<delegation_behavior>
  ## How the Meta Agent Works
  
  The meta agent acts as a **SPECIALIST** that executes directly (no delegation).
  
  ### Why No Delegation?
  
  1. **Specialized Expertise**: Meta-programming IS the meta agent's core competency
  2. **Holistic Understanding**: Creating commands requires understanding entire .opencode architecture
  3. **Direct Execution**: Meta agent directly generates code - this is its primary function
  4. **No Benefit from Delegation**: Breaking meta-programming into sub-tasks would add complexity
  
  ### What the Meta Agent Does
  
  ✅ **Direct Execution**:
  - Validates command specifications
  - Verifies target agent exists
  - Loads command template
  - Generates command frontmatter with description
  - Creates request parameter structure
  - Adds context sections (system, domain, task, execution)
  - Adds role and task definitions
  - Creates routing instructions to specified agent
  - Documents agent behavior (coordinator vs specialist)
  - Generates 2-3 realistic usage examples
  - Writes command file to .opencode/command/ directory
  - Validates command structure against standards
  - Commits command file to git
  - Returns command file path
  
  ### Example Execution Flow
  
  ```
  User: /create-command "analyze-performance" "Analyzes NeoVim startup and runtime performance" "performance-analyzer"
  
  Meta Agent:
    1. Validates inputs:
       - command_name: "analyze-performance" ✓
       - command_description: "Analyzes NeoVim startup and runtime performance" ✓
       - agent_name: "performance-analyzer" ✓ (exists in .opencode/agent/)
    
    2. Loads command template
    
    3. Generates command frontmatter:
       ---
       description: "Analyzes NeoVim startup and runtime performance"
       ---
    
    4. Creates request parameter structure:
       <analyze_performance_request>
         <analysis_type>$ARGUMENTS[0]</analysis_type>
       </analyze_performance_request>
    
    5. Adds context sections:
       - system_context: Performance analysis system
       - domain_context: NeoVim startup and runtime metrics
       - task_context: Measure and analyze performance
       - execution_context: Run benchmarks, analyze results
    
    6. Adds routing instructions:
       1. Route to @performance-analyzer
       2. Pass analysis_type from $ARGUMENTS
       3. Agent will measure, analyze, report
       4. Return performance report path
    
    7. Documents agent behavior (specialist pattern)
    
    8. Generates usage examples:
       - /analyze-performance "startup"
       - /analyze-performance "runtime"
       - /analyze-performance "plugin-loading"
    
    9. Writes to .opencode/command/analyze-performance.md
    
    10. Validates structure
    
    11. Commits: "feat(command): add analyze-performance command"
    
    12. Returns: .opencode/command/analyze-performance.md
  
  Result: New command created and ready to use
  ```
</delegation_behavior>

<usage_examples>
  <example_1>
    <command>/create-command "analyze-performance" "Analyzes NeoVim startup and runtime performance" "performance-analyzer"</command>
    <result>Creates command that routes to performance-analyzer agent in .opencode/command/analyze-performance.md</result>
  </example_1>
  
  <example_2>
    <command>/create-command "optimize-config" "Optimizes NeoVim configuration for performance" "optimizer"</command>
    <result>Creates command that routes to optimizer agent in .opencode/command/optimize-config.md</result>
  </example_2>
  
  <example_3>
    <command>/create-command "validate-setup" "Validates NeoVim configuration and dependencies" "validator"</command>
    <result>Creates command that routes to validator agent in .opencode/command/validate-setup.md</result>
  </example_3>
</usage_examples>
