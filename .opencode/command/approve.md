---
description: "Approves pending implementation plan and marks project ready for execution"
---

<approve_request>
  <project_id>$ARGUMENTS[0]</project_id>
</approve_request>

<context>
  <system_context>NeoVim configuration management approval workflow</system_context>
  <domain_context>Plan approval and project state management</domain_context>
  <task_context>Approve pending implementation plans and transition projects to ready state</task_context>
  <execution_context>Validate plan exists, update state.json with approval metadata, commit to git</execution_context>
</context>

<role>Plan approval coordinator for implementation workflow</role>

<task>Approve pending implementation plan and mark project ready for execution</task>

<instructions>
  1. Validate project_id format (e.g., "project-003" or "003")
  2. Locate project directory: .opencode/specs/{NNN_project_name}/
  3. Verify project exists and has state.json
  4. Check that project has a plan file in plans/ directory
  5. Verify current status allows approval (phase: "planning", status: "active")
  6. Update state.json:
     - Add "approval" object with:
       - status: "approved"
       - date: ISO 8601 timestamp
       - approved_by: "user"
     - Update phase: "approved" (ready for implementation)
     - Update last_updated: current timestamp
  7. Commit changes to git with message: "approve: mark project-{NNN} ready for implementation"
  8. Return confirmation with:
     - Project name and number
     - Approved plan path
     - Next step: "/implement {plan_path}"
</instructions>

<agent_behavior>
  ## How the Approval Process Works
  
  The approval command is a **UTILITY** command that executes directly (no agent delegation).
  
  ### Why No Agent Delegation?
  
  1. **Simple State Update**: Approval is a straightforward state transition
  2. **No Complex Logic**: Just validation + JSON update + git commit
  3. **Direct Execution**: No benefit from delegation - would add unnecessary complexity
  4. **Fast Operation**: Should complete in <1 second
  
  ### What the Approval Command Does
  
  ✅ **Validation**:
  - Verifies project exists
  - Checks plan file exists
  - Validates current state allows approval
  - Ensures no blockers present
  
  ✅ **State Management**:
  - Updates state.json with approval metadata
  - Transitions phase from "planning" to "approved"
  - Records approval timestamp
  - Updates last_updated field
  
  ✅ **Git Integration**:
  - Commits state.json changes
  - Uses conventional commit format
  - Includes project number in message
  
  ### State Transition
  
  ```
  Before Approval:
  {
    "phase": "planning",
    "status": "active",
    "plans": ["plans/implementation_v1.md"]
  }
  
  After Approval:
  {
    "phase": "approved",
    "status": "active",
    "plans": ["plans/implementation_v1.md"],
    "approval": {
      "status": "approved",
      "date": "2025-12-16T10:30:00Z",
      "approved_by": "user"
    },
    "last_updated": "2025-12-16T10:30:00Z"
  }
  ```
  
  ### Example Execution Flow
  
  ```
  User: /approve project-003
  
  Approval Command:
    1. Parses project_id: "project-003" → project number 003
    
    2. Locates project directory:
       - Searches .opencode/specs/ for directory matching 003_*
       - Found: .opencode/specs/003_system_enhancement_from_proofchecker/
    
    3. Reads state.json:
       - phase: "planning" ✓
       - status: "active" ✓
       - plans: ["plans/implementation_v1.md"] ✓
    
    4. Validates plan file exists:
       - Checks: .opencode/specs/003_system_enhancement_from_proofchecker/plans/implementation_v1.md
       - Exists: ✓
    
    5. Updates state.json:
       - Sets phase: "approved"
       - Adds approval object with timestamp
       - Updates last_updated
    
    6. Commits to git:
       - Message: "approve: mark project-003 ready for implementation"
       - Files: specs/003_system_enhancement_from_proofchecker/state.json
    
    7. Returns confirmation:
       ✅ Project 003 (system_enhancement_from_proofchecker) approved
       📄 Plan: specs/003_system_enhancement_from_proofchecker/plans/implementation_v1.md
       ▶️  Next: /implement specs/003_system_enhancement_from_proofchecker/plans/implementation_v1.md
  
  Result: Project approved and ready for implementation
  Time: <1 second (direct state update)
  ```
</agent_behavior>

<usage_examples>
  <example_1>
    <command>/approve project-003</command>
    <result>Approves project 003, updates state.json with approval metadata, commits to git</result>
  </example_1>
  
  <example_2>
    <command>/approve 003</command>
    <result>Same as example 1 - accepts project number without "project-" prefix</result>
  </example_2>
  
  <example_3>
    <command>/approve project-001</command>
    <result>Approves lazy-loading optimization project, marks ready for /implement</result>
  </example_3>
</usage_examples>
