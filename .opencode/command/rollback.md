---
description: "Rollback changes to previous state with safety checks and confirmation"
---

<rollback_request>
  <target>$ARGUMENTS[0]</target>
</rollback_request>

<context>
  <system_context>Git-based rollback system for NeoVim configuration changes</system_context>
  <domain_context>Safe rollback with diff preview, user confirmation, and state synchronization</domain_context>
  <task_context>Rollback changes to previous phase, commit, or entire project</task_context>
  <execution_context>Parse target, identify commit, show diff, confirm, execute rollback, update state, run health checks</execution_context>
</context>

<role>Rollback coordinator with safety checks and state management</role>

<task>Safely rollback changes to a previous state with user confirmation and automatic state updates</task>

<instructions>
  1. Parse the rollback target from $ARGUMENTS[0]:
     - "last-phase": Rollback to before last completed phase
     - "commit-hash": Rollback to specific commit (e.g., "abc123")
     - "project-NNN": Rollback entire project (e.g., "project-003")
  2. Identify the target commit to rollback to
  3. Show diff of changes that will be reverted
  4. Require user confirmation before proceeding
  5. Execute git revert or reset based on target type
  6. Update state.json to reflect rollback
  7. If NeoVim config affected, run :checkhealth
  8. Update TODO.md if project rollback
  9. Return rollback status and commit hash
</instructions>

<agent_behavior>
  ## How Rollback Works
  
  The rollback command is a **SPECIALIST** that executes directly (no delegation).
  
  ### Why No Delegation?
  
  1. **Safety-Critical Operation**: Rollback requires careful validation and user confirmation
  2. **Holistic Understanding**: Must understand git history, state, and dependencies
  3. **Direct Execution**: Primary function is to safely revert changes
  4. **No Benefit from Delegation**: Would add complexity without improving safety
  
  ### What Rollback Does
  
  ✅ **Target Identification**:
  - Parse rollback target (last-phase, commit-hash, project-NNN)
  - Identify target commit from git history
  - Validate target exists and is reachable
  - Determine rollback strategy (revert vs reset)
  
  ✅ **Safety Checks**:
  - Show diff of changes to be reverted
  - Check for uncommitted changes (warn user)
  - Require explicit user confirmation
  - Validate rollback won't break dependencies
  
  ✅ **Rollback Execution**:
  - Execute git revert (for last-phase, commit-hash)
  - Execute git reset (for project-NNN, with confirmation)
  - Update state.json to reflect rollback
  - Update TODO.md if project rollback
  - Run :checkhealth if NeoVim config affected
  
  ✅ **State Management**:
  - Update project state.json
  - Update phase status in plans
  - Log rollback in history
  - Preserve rollback metadata
  
  ### Rollback Strategies
  
  **last-phase** (Safe Revert):
  - Finds last phase commit from state.json
  - Uses `git revert` to create new commit
  - Preserves history
  - Safe for shared branches
  
  **commit-hash** (Targeted Revert):
  - Reverts specific commit
  - Uses `git revert <hash>`
  - Preserves history
  - Safe for shared branches
  
  **project-NNN** (Hard Reset):
  - Finds first commit of project
  - Uses `git reset --hard` to commit before project
  - **DESTRUCTIVE**: Removes all project commits
  - Requires extra confirmation
  - Updates TODO.md to remove project
  
  ### Example Execution Flow
  
  ```
  User: /rollback last-phase
  
  Rollback:
    1. Parses target: "last-phase"
    
    2. Reads state.json to find last phase commit:
       - Project: 003_lazy_loading_optimization
       - Last phase: Phase 4 (commit: abc123)
       - Target: Commit before Phase 4 (def456)
    
    3. Shows diff:
       ```
       Changes to be reverted:
       - lua/plugins/lazy-ui.lua (deleted)
       - lua/plugins/telescope.lua (modified)
       - README.md (modified)
       
       3 files changed, 45 insertions(+), 12 deletions(-)
       ```
    
    4. Prompts for confirmation:
       "Rollback Phase 4 changes? This will revert commit abc123. [y/N]"
    
    5. User confirms: "y"
    
    6. Executes rollback:
       - Runs: git revert abc123
       - Creates revert commit: "revert: rollback Phase 4 changes"
    
    7. Updates state.json:
       - Sets Phase 4 status to [NOT STARTED]
       - Removes Phase 4 commit hash
       - Updates last_implementation_date
    
    8. Checks if NeoVim config affected:
       - Detects lua/ directory changes
       - Runs: nvim --headless "+checkhealth" +qa
       - Reports health check results
    
    9. Returns: "Rollback complete. Reverted Phase 4 (commit abc123). Health check: OK"
  
  Result: Phase 4 safely reverted, state updated, health check passed
  ```
  
  ```
  User: /rollback project-003
  
  Rollback:
    1. Parses target: "project-003"
    
    2. Finds project in state.json:
       - Project: 003_lazy_loading_optimization
       - First commit: xyz789
       - Phases: 4 completed
       - Commits: 4 total
    
    3. Shows diff:
       ```
       WARNING: This will DELETE all commits for project-003
       
       Commits to be removed:
       - abc123: feat(plugins): Phase 4 - Update documentation
       - def456: test(plugins): Phase 3 - Run tests
       - ghi789: refactor(plugins): Phase 2 - Modify plugins
       - xyz789: feat(plugins): Phase 1 - Generate lazy-loading
       
       Files affected:
       - lua/plugins/lazy-ui.lua (deleted)
       - lua/plugins/*.lua (reverted)
       - README.md (reverted)
       - tests/lazy-loading.lua (deleted)
       
       4 commits, 12 files changed
       ```
    
    4. Prompts for confirmation (EXTRA WARNING):
       "⚠️  DESTRUCTIVE OPERATION ⚠️
       This will permanently delete all commits for project-003.
       Type 'DELETE project-003' to confirm: "
    
    5. User confirms: "DELETE project-003"
    
    6. Executes rollback:
       - Finds commit before project: jkl012
       - Runs: git reset --hard jkl012
       - Removes 4 commits from history
    
    7. Updates state.json:
       - Removes project-003 from active_projects
       - Decrements total_implementations_count
       - Updates last_implementation_date
    
    8. Updates TODO.md:
       - Removes project-003 from Completed section
       - Adds note: "Rolled back on 2025-12-16"
    
    9. Runs health check:
       - Detects lua/ directory changes
       - Runs: nvim --headless "+checkhealth" +qa
       - Reports health check results
    
    10. Returns: "Project-003 rolled back. 4 commits removed. Health check: OK"
  
  Result: Entire project removed, state synchronized, health check passed
  ```
</agent_behavior>

<safety_features>
  ## Safety Mechanisms
  
  ### Pre-Rollback Validation
  - Check for uncommitted changes (warn user to commit or stash)
  - Validate target exists in git history
  - Verify rollback won't break dependencies
  - Show full diff before proceeding
  
  ### Confirmation Requirements
  - **last-phase**: Simple [y/N] confirmation
  - **commit-hash**: Simple [y/N] confirmation with commit message
  - **project-NNN**: Type "DELETE project-NNN" to confirm (extra safety)
  
  ### Post-Rollback Validation
  - Run :checkhealth if NeoVim config affected
  - Verify state.json is consistent
  - Check for broken references in TODO.md
  - Log rollback in history
  
  ### Rollback History
  - All rollbacks logged in state.json
  - Includes: timestamp, target, user, reason
  - Enables rollback auditing
  - Helps prevent accidental rollbacks
</safety_features>

<usage_examples>
  <example_1>
    <command>/rollback last-phase</command>
    <result>Reverts last completed phase, updates state.json, runs health check</result>
  </example_1>
  
  <example_2>
    <command>/rollback abc123</command>
    <result>Reverts specific commit abc123, preserves history</result>
  </example_2>
  
  <example_3>
    <command>/rollback project-003</command>
    <result>Removes entire project-003 (requires "DELETE project-003" confirmation)</result>
  </example_3>
  
  <example_4>
    <command>/rollback def456</command>
    <result>Reverts commit def456 from middle of history</result>
  </example_4>
</usage_examples>

<error_handling>
  ## Common Error Scenarios
  
  ### Uncommitted Changes
  ```
  Error: Uncommitted changes detected
  Please commit or stash changes before rollback:
    - lua/plugins/new-plugin.lua (modified)
    - README.md (modified)
  
  Run: git status
  ```
  
  ### Invalid Target
  ```
  Error: Target not found: "project-999"
  Available projects:
    - project-001: nvim_lsp_setup
    - project-002: telescope_optimization
    - project-003: lazy_loading_optimization
  
  Run: /show-state to see all projects
  ```
  
  ### Commit Not Found
  ```
  Error: Commit not found: "xyz999"
  Recent commits:
    - abc123: feat(plugins): Phase 4
    - def456: test(plugins): Phase 3
    - ghi789: refactor(plugins): Phase 2
  
  Run: git log --oneline -10
  ```
  
  ### Dependency Conflict
  ```
  Warning: Rollback may break dependencies
  Project-004 depends on changes from project-003
  
  Proceed anyway? [y/N]
  ```
  
  ### Health Check Failed
  ```
  Warning: Health check failed after rollback
  Issues detected:
    - LSP server not found: rust-analyzer
    - Plugin failed to load: telescope.nvim
  
  Run: nvim +checkhealth for details
  Consider rolling forward or fixing issues
  ```
</error_handling>

<implementation_notes>
  ## Technical Details
  
  ### Git Commands Used
  - `git revert <commit>`: For last-phase and commit-hash (safe)
  - `git reset --hard <commit>`: For project-NNN (destructive)
  - `git log --oneline`: To find commits
  - `git diff <commit>`: To show changes
  - `git status`: To check for uncommitted changes
  
  ### State.json Updates
  ```json
  {
    "rollback_history": [
      {
        "timestamp": "2025-12-16T10:30:00Z",
        "target": "last-phase",
        "project": "003_lazy_loading_optimization",
        "phase": "Phase 4",
        "commit": "abc123",
        "user": "benjamin",
        "reason": "Manual rollback via /rollback command"
      }
    ]
  }
  ```
  
  ### Health Check Integration
  - Detects if lua/ directory affected
  - Runs: `nvim --headless "+checkhealth" +qa`
  - Parses output for errors
  - Reports issues to user
  - Suggests fixes if problems detected
  
  ### TODO.md Updates (project rollback only)
  - Removes project from Completed section
  - Adds rollback note with timestamp
  - Preserves project history for reference
  - Updates project counters
</implementation_notes>
