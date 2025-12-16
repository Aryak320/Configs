---
description: "Executes quick-win implementations directly from research findings without full planning"
---

<quick_implement_request>
  <quick_win_selector>$ARGUMENTS[0]</quick_win_selector>
  <research_path>$ARGUMENTS[1]</research_path>
</quick_implement_request>

<context>
  <system_context>Rapid implementation system for low-risk, high-value configuration changes</system_context>
  <domain_context>Quick wins from research reports - simple optimizations that don't require full planning</domain_context>
  <task_context>Execute quick-win implementations directly, bypassing the planning phase for simple changes</task_context>
  <execution_context>Read research findings, present quick wins, execute selected implementation, run health checks, commit</execution_context>
</context>

<role>Quick-win implementation executor for simple, low-risk configuration changes</role>

<task>Execute quick-win implementations directly from research findings without creating full implementation plans</task>

<instructions>
  1. Route this request to the implementer agent: @implementer
  2. Pass the quick_win_selector (number, name, or "all")
  3. Pass optional research_path (defaults to most recent research report)
  4. The implementer will:
     - Read research report and extract quick wins section
     - Present quick wins to user with descriptions and risk levels
     - If selector provided, validate and confirm selection
     - If no selector, prompt user to choose
     - Execute selected quick win(s) directly (no planning phase)
     - Delegate to implementation subagents (code-generator, code-modifier)
     - Run health checks after implementation
     - Commit changes with clear message
     - Update TODO.md if applicable
  5. Return implementation status and commit hash to user
</instructions>

<delegation_behavior>
  ## How Quick-Implement Works
  
  The quick-implement command routes to the **implementer agent** with a special quick-win flag.
  
  ### What the Implementer Does (Quick-Win Mode)
  
  ✅ **Quick Win Discovery**:
  - Reads research report (OVERVIEW.md or specified path)
  - Extracts "Quick Wins" or "Low-Hanging Fruit" section
  - Parses quick win items with descriptions and risk levels
  - Presents formatted list to user
  
  ✅ **User Interaction**:
  - If selector provided: Validates and confirms selection
  - If no selector: Prompts user to choose from list
  - Shows quick win details before execution
  - Requires confirmation for safety
  
  ✅ **Direct Execution**:
  - Skips planning phase (no implementation_v1.md created)
  - Delegates to implementation subagents directly
  - Executes single quick win or multiple in sequence
  - Updates state as [QUICK_WIN_IN_PROGRESS]
  
  ✅ **Validation**:
  - Runs health checks after implementation
  - Validates configuration syntax
  - Tests affected functionality
  - Rolls back on critical failures
  
  ✅ **State Management**:
  - Commits with descriptive message
  - Updates TODO.md (Quick Wins section if exists)
  - Logs to .opencode/logs/quick-wins.log
  - Returns brief summary
  
  ### What the Implementer Delegates
  
  🔄 **Implementation Work**:
  - Code generation → `subagents/implementation/code-generator`
  - Code modification → `subagents/implementation/code-modifier`
  - Health checks → `subagents/configuration/health-checker`
  
  ### Why Quick-Implement?
  
  💡 **Speed**:
  - No planning overhead for simple changes
  - Direct execution saves 60-80% time vs full workflow
  - Ideal for configuration tweaks and optimizations
  
  💡 **Low Risk**:
  - Quick wins are pre-vetted during research
  - Health checks catch issues immediately
  - Easy to rollback single commits
  
  💡 **High Value**:
  - Implements "low-hanging fruit" quickly
  - Builds momentum with visible improvements
  - Frees planning for complex changes
  
  ### Safety Features
  
  🛡️ **Risk Mitigation**:
  - User confirmation required before execution
  - Health checks run automatically
  - Automatic rollback on critical failures
  - Clear commit messages for easy reversion
  
  🛡️ **Scope Limits**:
  - Only for changes marked as "quick wins" in research
  - No architectural changes allowed
  - No breaking changes allowed
  - Maximum 3 files modified per quick win
  
  ### Example Execution Flow
  
  ```
  User: /quick-implement 1
  
  Implementer (Quick-Win Mode):
    1. Reads most recent research report
       - Found: .opencode/specs/001_opencode_hover_scrolling/reports/research_summary.md
    
    2. Extracts quick wins section:
       Quick Win 1: Add keybindings for scrolling (Risk: Low)
       Quick Win 2: Configure window layout (Risk: Low)
       Quick Win 3: Add focus-switching helper (Risk: Low)
    
    3. User selected: Quick Win 1
    
    4. Confirms with user:
       "Execute Quick Win 1: Add keybindings for scrolling?
        - Modifies: lua/plugins/opencode.lua
        - Risk: Low
        - Estimated time: 2-3 minutes
        [y/N]"
    
    5. User confirms: y
    
    6. Delegates to code-modifier:
       task(
         subagent_type="subagents/implementation/code-modifier",
         description="Add opencode scrolling keybindings",
         prompt="Modify lua/plugins/opencode.lua
                 
                 Add keybindings:
                 - <leader>ok: session.half.page.up
                 - <leader>oj: session.half.page.down
                 - <leader>oK: session.page.up
                 - <leader>oJ: session.page.down
                 
                 Follow standards: /home/benjamin/.config/CLAUDE.md"
       )
    
    7. Receives brief summary:
       "Added 4 scrolling keybindings to opencode.lua. File: lua/plugins/opencode.lua"
    
    8. Runs health checks:
       task(
         subagent_type="subagents/configuration/health-checker",
         description="Validate opencode configuration",
         prompt="Run health checks on lua/plugins/opencode.lua"
       )
    
    9. Health check result: "All checks passed. No errors."
    
    10. Commits:
        "feat(opencode): add scrolling keybindings for quick navigation"
    
    11. Returns:
        "✅ Quick Win 1 implemented successfully
         - File modified: lua/plugins/opencode.lua
         - Health checks: PASSED
         - Commit: a1b2c3d
         - Time: 2 minutes"
  
  Result: Quick win implemented in 2 minutes (vs 15-20 minutes for full workflow)
  Context: Implementer saw ~200 tokens (quick win spec) instead of ~5,000 tokens (full plan)
  Time: 90% faster than full planning workflow
  ```
</delegation_behavior>

<usage_examples>
  <example_1>
    <command>/quick-implement 1</command>
    <result>Executes first quick win from most recent research report</result>
  </example_1>
  
  <example_2>
    <command>/quick-implement "lazy-loading optimization"</command>
    <result>Searches for and executes quick win matching the description</result>
  </example_2>
  
  <example_3>
    <command>/quick-implement all .opencode/specs/001_hover_scrolling/reports/research_summary.md</command>
    <result>Executes all quick wins from specified research report in sequence</result>
  </example_3>
  
  <example_4>
    <command>/quick-implement</command>
    <result>Lists available quick wins from most recent research and prompts for selection</result>
  </example_4>
</usage_examples>

<quick_win_criteria>
  ## What Qualifies as a Quick Win?
  
  Quick wins must meet ALL of these criteria:
  
  ✅ **Low Risk**:
  - No architectural changes
  - No breaking changes
  - No external dependencies
  - Easily reversible
  
  ✅ **Small Scope**:
  - Maximum 3 files modified
  - Maximum 50 lines of code changed
  - Single focused improvement
  - No cascading changes required
  
  ✅ **High Value**:
  - Immediate visible benefit
  - Addresses user pain point
  - Improves performance or usability
  - Aligns with best practices
  
  ✅ **Well-Defined**:
  - Clear implementation steps
  - Known configuration patterns
  - Documented in research
  - No ambiguity in requirements
  
  ### Examples of Good Quick Wins
  
  ✅ Add keybindings for existing functionality
  ✅ Enable lazy-loading for specific plugins
  ✅ Configure window layout preferences
  ✅ Add missing LSP server configurations
  ✅ Enable recommended plugin options
  ✅ Fix simple configuration errors
  
  ### Examples of NOT Quick Wins
  
  ❌ Refactor plugin architecture
  ❌ Migrate to new plugin manager
  ❌ Implement custom plugin from scratch
  ❌ Change core NeoVim behavior
  ❌ Multi-phase implementations
  ❌ Changes requiring extensive testing
</quick_win_criteria>

<error_handling>
  ## Error Scenarios
  
  ### No Quick Wins Found
  ```
  Error: No quick wins found in research report
  
  Suggestions:
  - Run /research first to generate findings
  - Check if research report has "Quick Wins" section
  - Use /plan for complex changes that need full planning
  ```
  
  ### Invalid Selector
  ```
  Error: Quick win "5" not found
  
  Available quick wins:
  1. Add scrolling keybindings (Risk: Low)
  2. Configure window layout (Risk: Low)
  3. Add focus helper (Risk: Low)
  
  Usage: /quick-implement [1-3]
  ```
  
  ### Health Check Failure
  ```
  Warning: Health check failed after implementation
  
  Error: Syntax error in lua/plugins/opencode.lua:45
  
  Actions taken:
  - Changes committed: a1b2c3d
  - Health check logged: .opencode/logs/health-checks.log
  
  Next steps:
  - Review error: cat .opencode/logs/health-checks.log
  - Fix manually or rollback: /rollback a1b2c3d
  ```
  
  ### User Cancellation
  ```
  Quick win execution cancelled by user
  
  No changes made.
  ```
</error_handling>

<integration_points>
  ## Research Report Format
  
  Quick wins should be documented in research reports under a dedicated section:
  
  ```markdown
  ## Quick Wins
  
  ### 1. Add Scrolling Keybindings
  
  **Description**: Add keybindings for scrolling opencode output without focus
  **Risk**: Low
  **Effort**: 2-3 minutes
  **Files**: lua/plugins/opencode.lua
  **Value**: Improves workflow efficiency
  
  **Implementation**:
  - Add <leader>ok for scroll up
  - Add <leader>oj for scroll down
  - Add <leader>oK for page up
  - Add <leader>oJ for page down
  
  ### 2. Configure Window Layout
  
  **Description**: Set default window position and size
  **Risk**: Low
  **Effort**: 1-2 minutes
  **Files**: lua/plugins/opencode.lua
  **Value**: Better screen real estate usage
  
  **Implementation**:
  - Set position to "right"
  - Set width to 0.4 (40%)
  - Set height to 0.8 (80%)
  ```
  
  ## TODO.md Integration
  
  Quick wins can optionally be tracked in TODO.md:
  
  ```markdown
  ## Quick Wins
  - [ ] Add scrolling keybindings (opencode)
  - [ ] Configure window layout (opencode)
  - [x] Add focus helper (opencode) - Completed 2025-12-15
  ```
  
  ## Logging
  
  All quick win executions are logged to `.opencode/logs/quick-wins.log`:
  
  ```
  [2025-12-15 14:30:22] QUICK_WIN_START: Add scrolling keybindings
  [2025-12-15 14:30:24] DELEGATE: code-modifier (lua/plugins/opencode.lua)
  [2025-12-15 14:30:26] HEALTH_CHECK: PASSED
  [2025-12-15 14:30:27] COMMIT: a1b2c3d
  [2025-12-15 14:30:27] QUICK_WIN_COMPLETE: 5 seconds
  ```
</integration_points>
