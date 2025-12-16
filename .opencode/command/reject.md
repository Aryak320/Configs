---
description: "Rejects pending implementation plan and cancels project with documented reason"
---

<reject_request>
  <project_id>$ARGUMENTS[0]</project_id>
  <reason>$ARGUMENTS[1]</reason>
</reject_request>

<context>
  <system_context>NeoVim configuration management approval workflow</system_context>
  <domain_context>Plan rejection and project cancellation management</domain_context>
  <task_context>Reject pending implementation plans and document cancellation reasons</task_context>
  <execution_context>Validate plan exists, update state.json with rejection metadata, commit to git</execution_context>
</context>

<role>Plan rejection coordinator for implementation workflow</role>

<task>Reject pending implementation plan and cancel project with documented reason</task>

<instructions>
  1. Validate project_id format (e.g., "project-003" or "003")
  2. Validate reason is provided (required parameter)
  3. Locate project directory: .opencode/specs/{NNN_project_name}/
  4. Verify project exists and has state.json
  5. Check that project has a plan file in plans/ directory
  6. Verify current status allows rejection (phase: "planning", status: "active")
  7. Update state.json:
     - Add "approval" object with:
       - status: "rejected"
       - date: ISO 8601 timestamp
       - rejected_by: "user"
       - reason: provided reason text
     - Update status: "cancelled"
     - Update phase: "rejected"
     - Update last_updated: current timestamp
  8. Commit changes to git with message: "reject: cancel project-{NNN} - {brief reason}"
  9. Return confirmation with:
     - Project name and number
     - Rejection reason
     - Cancelled plan path
     - Note: Project can be restarted with /research if needed
</instructions>

<agent_behavior>
  ## How the Rejection Process Works
  
  The rejection command is a **UTILITY** command that executes directly (no agent delegation).
  
  ### Why No Agent Delegation?
  
  1. **Simple State Update**: Rejection is a straightforward state transition
  2. **No Complex Logic**: Just validation + JSON update + git commit
  3. **Direct Execution**: No benefit from delegation - would add unnecessary complexity
  4. **Fast Operation**: Should complete in <1 second
  
  ### What the Rejection Command Does
  
  ✅ **Validation**:
  - Verifies project exists
  - Checks plan file exists
  - Validates current state allows rejection
  - Ensures reason is provided (required)
  
  ✅ **State Management**:
  - Updates state.json with rejection metadata
  - Transitions status from "active" to "cancelled"
  - Transitions phase from "planning" to "rejected"
  - Records rejection timestamp and reason
  - Updates last_updated field
  
  ✅ **Git Integration**:
  - Commits state.json changes
  - Uses conventional commit format
  - Includes project number and brief reason in message
  
  ### State Transition
  
  ```
  Before Rejection:
  {
    "phase": "planning",
    "status": "active",
    "plans": ["plans/implementation_v1.md"]
  }
  
  After Rejection:
  {
    "phase": "rejected",
    "status": "cancelled",
    "plans": ["plans/implementation_v1.md"],
    "approval": {
      "status": "rejected",
      "date": "2025-12-16T10:30:00Z",
      "rejected_by": "user",
      "reason": "Plan complexity too high, needs simplification"
    },
    "last_updated": "2025-12-16T10:30:00Z"
  }
  ```
  
  ### Rejection vs Cancellation
  
  - **Rejection**: Happens during planning phase - plan exists but not approved
  - **Cancellation**: Can happen at any phase - stops active work
  - Both use same state transition: status → "cancelled"
  - Rejection specifically sets phase → "rejected"
  
  ### Example Execution Flow
  
  ```
  User: /reject project-003 "Plan complexity too high, needs simplification"
  
  Rejection Command:
    1. Parses arguments:
       - project_id: "project-003" → project number 003
       - reason: "Plan complexity too high, needs simplification"
    
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
       - Sets phase: "rejected"
       - Sets status: "cancelled"
       - Adds approval object with rejection metadata
       - Records reason
       - Updates last_updated
    
    6. Commits to git:
       - Message: "reject: cancel project-003 - plan complexity too high"
       - Files: specs/003_system_enhancement_from_proofchecker/state.json
    
    7. Returns confirmation:
       ❌ Project 003 (system_enhancement_from_proofchecker) rejected
       📝 Reason: Plan complexity too high, needs simplification
       📄 Cancelled plan: specs/003_system_enhancement_from_proofchecker/plans/implementation_v1.md
       💡 Note: Project can be restarted with /research if needed
  
  Result: Project rejected and cancelled with documented reason
  Time: <1 second (direct state update)
  ```
  
  ### Recovery from Rejection
  
  If a project is rejected but the underlying need is still valid:
  
  1. Review rejection reason in state.json
  2. Address the concerns (e.g., simplify scope, gather more research)
  3. Start new research: `/research "revised topic based on feedback"`
  4. This creates a new project with lessons learned from rejection
</agent_behavior>

<usage_examples>
  <example_1>
    <command>/reject project-003 "Plan complexity too high, needs simplification"</command>
    <result>Rejects project 003, updates state.json with rejection reason, commits to git</result>
  </example_1>
  
  <example_2>
    <command>/reject 003 "Duplicate of existing optimization work"</command>
    <result>Same as example 1 - accepts project number without "project-" prefix</result>
  </example_2>
  
  <example_3>
    <command>/reject project-005 "Requirements changed, no longer needed"</command>
    <result>Rejects project 005, documents reason, marks as cancelled</result>
  </example_3>
</usage_examples>
