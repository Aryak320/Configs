# Project Standards Reference

This document consolidates all project standards and guidelines from CLAUDE.md to maintain uniform and consistent approaches when refactoring or extending the repository.

**Source**: `/home/benjamin/.config/CLAUDE.md`  
**Last Updated**: 2025-12-15

---

## Table of Contents

1. [Core Documentation](#core-documentation)
2. [Code Standards](#code-standards)
3. [Testing Standards](#testing-standards)
4. [Development Workflow](#development-workflow)
5. [Architecture Standards](#architecture-standards)
6. [Documentation Standards](#documentation-standards)
7. [Quality Enforcement](#quality-enforcement)
8. [Quick Reference](#quick-reference)

---

## Core Documentation

### Primary Documentation Hub
- **[Claude Code Documentation](.claude/docs/README.md)** - Complete index of patterns, guides, workflows, and reference documentation for working with .claude/ system
- **[Neovim Configuration Guidelines](nvim/CLAUDE.md)** - Coding standards, style guide, and architecture documentation for Neovim configuration
- **[Code Standards](nvim/docs/CODE_STANDARDS.md)** - Lua coding conventions, module structure, and development process
- **[Documentation Standards](nvim/docs/DOCUMENTATION_STANDARDS.md)** - Documentation structure, style guide, and content standards

---

## Code Standards

### Comprehensive Code Standards
**Reference**: [Code Standards](.claude/docs/reference/standards/code-standards.md)

Complete coding conventions, language-specific standards, architectural requirements, and link conventions.

### Bash Sourcing (MANDATORY)
**Used by**: All commands, all agents

**Requirements**:
- All bash blocks MUST follow three-tier sourcing pattern (enforced by linter and pre-commit hooks)
- Tier 1 libraries (state-persistence.sh, workflow-state-machine.sh, error-handling.sh) require fail-fast handlers
- **Reference**: [Mandatory Bash Block Sourcing Pattern](.claude/docs/reference/standards/code-standards.md#mandatory-bash-block-sourcing-pattern)

**Three-Tier Pattern**:
```bash
# Tier 1: Core workflow libraries (fail-fast)
source "$CLAUDE_LIB/core/state-persistence.sh" 2>/dev/null || { echo "Error: Cannot load state-persistence library"; exit 1; }

# Tier 2: Workflow utilities (fail-fast)
source "$CLAUDE_LIB/workflow/validation-utils.sh" 2>/dev/null || { echo "Error: Cannot load validation-utils library"; exit 1; }

# Tier 3: Optional utilities (graceful degradation)
source "$CLAUDE_LIB/utils/formatting.sh" 2>/dev/null || true
```

### Task Tool Invocation (MANDATORY)
**Used by**: All commands invoking agents

**Requirements**:
- All Task tool invocations MUST use imperative directives: `"**EXECUTE NOW**: USE the Task tool..."`
- Pseudo-code syntax `Task { ... }` without directive is PROHIBITED (enforced by linter)
- Instructional text patterns without actual Task invocation are PROHIBITED
- **Reference**: [Task Tool Invocation Patterns](.claude/docs/reference/standards/command-authoring.md#task-tool-invocation-patterns)

### Path Validation (MANDATORY)
**Used by**: All commands with path operations

**Requirements**:
- PATH MISMATCH validation MUST handle PROJECT_DIR under HOME (e.g., ~/.config) as valid configuration
- Use `validate_path_consistency()` from validation-utils.sh or inline conditional pattern
- **Anti-pattern**: Direct HOME check without PROJECT_DIR context causes false positives
- **Reference**: [Path Validation Patterns](.claude/docs/reference/standards/command-authoring.md#path-validation-patterns)

### Bash Block Size Limits (MANDATORY)
**Used by**: All commands

**Requirements**:
- All bash blocks MUST be under 400 lines (hard limit, causes preprocessing bugs)
- Recommended: <300 lines for complex logic (safe zone)
- Split oversized blocks at logical boundaries using state persistence
- **Reference**: [Bash Block Size Limits and Prevention](.claude/docs/reference/standards/command-authoring.md#bash-block-size-limits-and-prevention)

### Plan Metadata Integration (MANDATORY)
**Used by**: /create-plan, /lean-plan, /repair, /revise, /debug

**Requirements**:
- All plan-generating commands MUST inject plan metadata standards via `format_standards_for_prompt()`
- **Reference**: [Plan Metadata Standard Integration](.claude/docs/reference/standards/command-authoring.md#plan-metadata-standard-integration)

---

## Testing Standards

### Testing Protocols
**Reference**: [Testing Protocols](.claude/docs/reference/standards/testing-protocols.md)  
**Used by**: /test, /test-all, /implement

Complete test discovery, patterns, coverage requirements, and isolation standards.

### Non-Interactive Testing (MANDATORY)
**Reference**: [Non-Interactive Testing Standard](.claude/docs/reference/standards/non-interactive-testing-standard.md)  
**Used by**: /create-plan, /lean-plan, /implement, /debug, /repair, all test phases

All test phases in implementation plans must be executable automatically without manual intervention.

**Required Automation Metadata**:
- `automation_type`: Must be "automated" (not "manual")
- `validation_method`: Must be "programmatic" (not "visual")
- `skip_allowed`: Must be `false` (no optional testing)
- `artifact_outputs`: Array of test artifacts (JUnit XML, JSON reports, coverage data)

**Prohibited Anti-Patterns** (NEVER use):
- "skip for now"
- "manually verify"
- "optional testing"
- "if needed"
- "verify visually"
- "inspect output"
- "check results"

**Enforcement**:
- ERROR-level validator: validate-non-interactive-tests.sh
- Pre-commit hook integration blocks commits with interactive anti-patterns
- Plan-architect agent generates test phases with automation metadata by default

---

## Development Workflow

### Directory Protocols
**Reference**: [Directory Protocols](.claude/docs/concepts/directory-protocols.md)  
**Used by**: /research, /create-plan, /implement, /list-plans, /list-reports, /list-summaries

The specifications directory uses a topic-based structure (`specs/{NNN_topic}/`) with artifact subdirectories.

**Key Concepts**:
- **Topic-based structure**: All artifacts for a feature in one numbered directory
- **LLM-based naming**: Haiku agent generates semantic names from user descriptions, falls back to `no_name` on failure
- **Plan levels**: Single file → Phase expansion → Stage expansion (on-demand)
- **Phase dependencies**: Enable parallel execution of independent phases (40-60% time savings)
- **Artifact lifecycle**: Debug reports committed, others gitignored

**Topic Naming Reference**: [Topic Naming with LLM](.claude/docs/guides/development/topic-naming-with-llm.md)

### Development Workflow
**Reference**: [Development Workflow](.claude/docs/concepts/development-workflow.md)  
**Used by**: /implement, /create-plan

Complete workflow documentation with spec updater details.

### Development Philosophy
**Reference**: [Writing Standards](.claude/docs/concepts/writing-standards.md)  
**Used by**: /refactor, /implement, /create-plan, /document

Complete development philosophy, clean-break approach, and documentation standards.

### Clean-Break Development (MANDATORY)
**Reference**: [Clean-Break Development Standard](.claude/docs/reference/standards/clean-break-development.md)  
**Used by**: /refactor, /implement, /create-plan, all development commands

**Quick Reference**:
- **Internal tooling changes**: ALWAYS use clean-break (no deprecation periods)
- **State machine/workflow changes**: Atomic migration, then delete old code
- **Interface changes**: Unified implementation, no compatibility wrappers
- **Documentation**: Already enforced via Writing Standards

### Adaptive Planning
**Reference**: [Adaptive Planning Guide](.claude/docs/workflows/adaptive-planning-guide.md)  
**Used by**: /implement

Intelligent plan revision capabilities, automatic triggers, and loop prevention.

**Configuration**: [Adaptive Planning Configuration](.claude/docs/reference/standards/adaptive-planning.md)  
**Used by**: /create-plan, /expand, /implement, /revise

Complexity thresholds, threshold adjustment guidelines, and configuration ranges.

### Plan Metadata Standard (MANDATORY)
**Reference**: [Plan Metadata Standard](.claude/docs/reference/standards/plan-metadata-standard.md)  
**Used by**: /create-plan, /lean-plan, /repair, /revise, /debug, plan-architect

**Required Fields** (ERROR if missing):
1. **Date**: `YYYY-MM-DD` or `YYYY-MM-DD (Revised)` - Creation/revision date
2. **Feature**: One-line description (50-100 chars) - What is being implemented
3. **Status**: `[NOT STARTED]`, `[IN PROGRESS]`, `[COMPLETE]`, `[BLOCKED]` - Current plan status
4. **Estimated Hours**: `{low}-{high} hours` - Time estimate as numeric range
5. **Standards File**: `/absolute/path/to/CLAUDE.md` - Standards traceability
6. **Research Reports**: Markdown links with relative paths or `none` if no research phase

**Enforcement**: Automated validation via pre-commit hooks (ERROR-level for missing required fields), validate-all-standards.sh --plans category, and plan-architect self-validation.

### Concurrent Execution Safety (MANDATORY)
**Reference**: [Concurrent Execution Safety Standard](.claude/docs/reference/standards/concurrent-execution-safety.md)  
**Used by**: All commands

Commands must support concurrent execution of multiple instances without state interference.

**Three-Part Pattern**:
1. Nanosecond-precision WORKFLOW_ID generation (`date +%s%N`)
2. No shared state ID files (WORKFLOW_ID embedded in state file)
3. State file discovery via pattern matching (most recent by mtime)

**Quick Reference**:
- **Block 1**: Use `WORKFLOW_ID=$(generate_unique_workflow_id "command_name")` for nanosecond-precision timestamps
- **Block 2+**: Use `STATE_FILE=$(discover_latest_state_file "command_name")` for state restoration
- **Anti-Pattern**: NEVER use shared state ID files (e.g., `plan_state_id.txt`)

**Testing Requirements**:
- Commands must pass concurrent execution tests (2, 3, 5 instances)
- No "Failed to restore WORKFLOW_ID" errors
- All instances complete successfully
- WORKFLOW_IDs unique across all instances

**Validation**:
```bash
# Detect shared state ID file anti-pattern
bash .claude/scripts/lint/lint-shared-state-files.sh .claude/commands/*.md

# Integrated validation
bash .claude/scripts/validate-all-standards.sh --concurrency
```

---

## Architecture Standards

### Directory Organization
**Reference**: [Directory Organization](.claude/docs/concepts/directory-organization.md)  
**Used by**: /implement, /create-plan, /refactor, all development commands

Complete directory structure, file placement rules, decision matrix, and anti-patterns.

**Quick Summary**: `.claude/` contains:
- `scripts/` - Standalone tools
- `lib/` - Sourced functions
- `commands/` - Slash commands
- `agents/` - AI assistants
- `skills/` - Model-invoked capabilities
- `docs/` - Documentation
- `tests/` - Test suites

### Hierarchical Agent Architecture
**Reference**: [Hierarchical Agent Architecture Overview](.claude/docs/concepts/hierarchical-agents-overview.md)  
**Used by**: /implement, /create-plan, /debug, /lean-plan, /research

Complete patterns, utilities, templates, and troubleshooting.

**Documentation Modules**:
- [Coordination](.claude/docs/concepts/hierarchical-agents-coordination.md) - Multi-agent coordination patterns
- [Communication](.claude/docs/concepts/hierarchical-agents-communication.md) - Agent communication protocols
- [Patterns](.claude/docs/concepts/hierarchical-agents-patterns.md) - Design patterns and best practices
- [Examples](.claude/docs/concepts/hierarchical-agents-examples.md) - Practical examples including research-coordinator pattern

**Architecture Standards**:
- [Choosing Agent Architecture](.claude/docs/guides/architecture/choosing-agent-architecture.md) - Decision framework for hierarchical vs flat agent models
- [Three-Tier Coordination Pattern](.claude/docs/concepts/three-tier-coordination-pattern.md) - Commands → Coordinators → Specialists pattern
- [Coordinator Patterns Standard](.claude/docs/reference/standards/coordinator-patterns-standard.md) - Five core coordinator patterns
- [Coordinator Return Signals](.claude/docs/reference/standards/coordinator-return-signals.md) - Standardized return signal contracts
- [Artifact Metadata Standard](.claude/docs/reference/standards/artifact-metadata-standard.md) - Metadata schema for 95%+ context reduction
- [Brief Summary Format](.claude/docs/reference/standards/brief-summary-format.md) - 96% context reduction via brief summaries
- [State System Patterns](.claude/docs/concepts/state-system-patterns.md) - Workflow state machine and cross-block persistence
- [Error Logging Standard](.claude/docs/reference/standards/error-logging-standard.md) - Centralized error logging and debugging workflows

**Key Implementations**:
- **Research Coordinator Pattern** (IMPLEMENTED 2025-12-08): Supervisor-based parallel research orchestration with 95% context reduction. See Example 7 in hierarchical-agents-examples.md.
- **Lean Command Coordinator Optimization** (IMPLEMENTED 2025-12-08): Dual coordinator integration achieving 95-96% context reduction and 40-60% time savings. See Example 8 in hierarchical-agents-examples.md.

**Migration Guides**:
- [Research Coordinator Migration Guide](.claude/docs/guides/development/research-coordinator-migration-guide.md)
- [Research Invocation Standards](.claude/docs/reference/standards/research-invocation-standards.md)

### Skills Architecture
**Reference**: [Skills README](.claude/skills/README.md)  
**Used by**: All commands, all agents

Skills are model-invoked autonomous capabilities that Claude automatically uses when relevant needs are detected.

**Skills vs Commands vs Agents**:
| Aspect | Skills | Commands | Agents |
|--------|--------|----------|--------|
| Invocation | Autonomous (model-invoked) | Explicit (`/cmd`) | Task delegation |
| Scope | Single focused capability | Quick shortcuts | Complex orchestration |
| Discovery | Automatic | Manual | Manual delegation |
| Composition | Auto-composition | Manual chaining | Coordinates skills |

**Available Skills**:
- `document-converter` - Bidirectional document conversion (Markdown, DOCX, PDF)

**Integration Patterns**:
1. **Autonomous**: Claude detects need and loads skill automatically
2. **Agent Auto-Loading**: Agents use `skills:` frontmatter field for auto-loading

**Authoring Standards**: [Skills Authoring Standards](.claude/docs/reference/standards/skills-authoring.md)

### State-Based Orchestration
**Reference**: [State-Based Orchestration Overview](.claude/docs/architecture/state-based-orchestration-overview.md)  
**Used by**: Custom orchestrators

Complete architecture, migration guide, and performance metrics.

**Idempotent State Transitions**: [Idempotent State Transitions Standard](.claude/docs/reference/standards/idempotent-state-transitions.md)

The workflow state machine handles same-state transitions gracefully with early-exit optimization.

---

## Documentation Standards

### Documentation Policy
**Reference**: [Documentation Standards](.claude/docs/reference/standards/documentation-standards.md)  
**Used by**: /document, /create-plan

Complete README.md structure requirements, directory classification, and template selection guide.

### README Requirements

**Directory Classification**:
- **Active Development** (commands/, agents/, lib/, docs/, tests/, scripts/): README.md required at all levels
- **Utility** (data/, backups/): Root README.md only, documents purpose and lifecycle
- **Temporary** (tmp/): README.md not required (ephemeral content)
- **Archive** (archive/): Timestamped manifests only, no root README
- **Topic-Based** (specs/): Root README.md only, individual topics self-documenting

**Standard README Sections** (for directories requiring README):
- **Purpose**: Clear explanation of directory role
- **Module Documentation**: Documentation for each file/module (active directories only)
- **Usage Examples**: Code examples where applicable
- **Navigation Links**: Links to parent and subdirectory READMEs

### Documentation Format

**Required**:
- Use clear, concise language
- Include code examples with syntax highlighting
- Use Unicode box-drawing for diagrams (see nvim/CLAUDE.md)
- Follow CommonMark specification

**Prohibited**:
- No emojis in file content (UTF-8 encoding issues)
- No historical commentary (see Development Philosophy → Documentation Standards)

### Documentation Updates

**Requirements**:
- Update documentation with code changes
- Keep examples current with implementation
- Document breaking changes prominently
- Remove any historical markers when updating existing docs

### TODO.md Standards
**Reference**: [TODO Organization Standards](.claude/docs/reference/standards/todo-organization-standards.md)

**Quick Reference**:
- **6-section hierarchy**: In Progress → Not Started → Backlog → Superseded → Abandoned → Completed
- **Checkboxes**: `[ ]` (not started), `[x]` (in progress/completed/abandoned), `[~]` (superseded)
- **Backlog section**: Manually curated and preserved by /todo command
- **Completed section**: Date-grouped entries (newest first)

### Output Formatting Standards
**Reference**: [Output Formatting Standards](.claude/docs/reference/standards/output-formatting.md)  
**Used by**: /implement, all commands and agents

**Quick Reference**:
- Suppress library sourcing with `2>/dev/null` while preserving error handling
- Target 2-3 bash blocks per command (Setup/Execute/Cleanup)
- Single summary line per block for interim output (not final completion summaries)
- Console summaries use 4-section format (Summary/Phases/Artifacts/Next Steps) with emoji markers
- Comments describe WHAT code does, not WHY it was designed that way

---

## Quality Enforcement

### Code Quality Enforcement
**Reference**: [Enforcement Mechanisms Reference](.claude/docs/reference/standards/enforcement-mechanisms.md)  
**Used by**: All commands, pre-commit hooks, CI validation

Standards are enforced automatically via pre-commit hooks and unified validation scripts. Violations block commits.

**Quick Reference**:
- Pre-commit hook runs on all staged `.claude/` files
- ERROR-level violations (sourcing, suppression, conditionals) block commits
- WARNING-level issues (README, links) are informational only
- Bypass with `git commit --no-verify` (document justification in commit message)

### Validation Commands

```bash
# Run all validators
bash .claude/scripts/validate-all-standards.sh --all

# Run specific validator categories
bash .claude/scripts/validate-all-standards.sh --sourcing      # Library sourcing
bash .claude/scripts/validate-all-standards.sh --suppression   # Error suppression
bash .claude/scripts/validate-all-standards.sh --conditionals  # Bash conditionals
bash .claude/scripts/validate-all-standards.sh --readme        # README structure
bash .claude/scripts/validate-all-standards.sh --links         # Link validity
bash .claude/scripts/validate-all-standards.sh --concurrency   # Concurrent execution
bash .claude/scripts/validate-all-standards.sh --plans         # Plan metadata

# Staged files only (pre-commit mode)
bash .claude/scripts/validate-all-standards.sh --staged
```

### Enforcement Tools

| Tool | Checks | Severity |
|------|--------|----------|
| check-library-sourcing.sh | Three-tier sourcing, fail-fast handlers | ERROR |
| lint_error_suppression.sh | State persistence suppression, deprecated paths | ERROR |
| lint_bash_conditionals.sh | Preprocessing-unsafe conditionals | ERROR |
| validate-readmes.sh | README structure | WARNING |
| validate-links-quick.sh | Internal link validity | WARNING |

### Error Logging Standards
**Reference**: [Error Handling Pattern](.claude/docs/concepts/patterns/error-handling.md)  
**Used by**: All commands, all agents, /implement, /debug, /errors, /repair

All commands and agents must integrate centralized error logging for queryable error tracking and cross-workflow debugging.

**Quick Reference**:
1. Source error-handling library: `source "$CLAUDE_LIB/core/error-handling.sh" 2>/dev/null || { echo "Error: Cannot load error-handling library"; exit 1; }`
2. Initialize error log: `ensure_error_log_exists`
3. Set workflow metadata: `COMMAND_NAME="/command"`, `WORKFLOW_ID="workflow_$(date +%s)"`, `USER_ARGS="$*"`
4. Log errors: `log_command_error "$error_type" "$error_message" "$error_details"`
5. Parse subagent errors: `parse_subagent_error "$agent_output" "$agent_name"`

**Error Types**: `state_error`, `validation_error`, `agent_error`, `parse_error`, `file_error`, `timeout_error`, `execution_error`, `dependency_error`

**Error Consumption Workflow**:
1. **Query errors**: `/errors [--command CMD] [--since TIME] [--type TYPE]` to view logged errors
2. **Analyze patterns**: `/repair [--since TIME] [--type TYPE]` to group errors and create fix plan
3. **Implement fixes**: `/implement [plan-file]` to execute repair plan, then `/test [plan-file]` to run tests

**Command Guides**:
- [Errors Command Guide](.claude/docs/guides/commands/errors-command-guide.md)
- [Repair Command Guide](.claude/docs/guides/commands/repair-command-guide.md)

---

## Quick Reference

### Command Development
**References**:
- [Command Reference](.claude/docs/reference/standards/command-reference.md) - Complete catalog of slash commands
- [Command Authoring](.claude/docs/reference/standards/command-authoring.md) - Complete command development patterns
- [Command Patterns Quick Reference](.claude/docs/reference/command-patterns-quick-reference.md) - Copy-paste templates
- [Validation Utils Library](.claude/lib/workflow/validation-utils.sh) - Reusable validation functions

### Decision Trees
**Reference**: [Decision Trees](.claude/docs/reference/decision-trees/README.md)

Decision flowcharts for common development scenarios.

### Reference Documentation
**Reference**: [Reference Documentation](.claude/docs/reference/README.md)

Command/agent references and navigation links.

### Configuration Portability
**Reference**: [Duplicate Commands Troubleshooting](.claude/docs/troubleshooting/duplicate-commands.md)  
**Used by**: All commands, project setup, troubleshooting

Command/agent/hook discovery hierarchy and configuration portability.

### Standards Discovery

**Discovery Method**:
1. Search upward from current directory for CLAUDE.md
2. Check for subdirectory-specific CLAUDE.md files
3. Merge/override: subdirectory standards extend parent standards

**Subdirectory Standards**:
- Subdirectory CLAUDE.md files can override parent standards
- Always check most specific (deepest) CLAUDE.md first
- Fall back to parent standards for missing sections

**Fallback Behavior**:
When CLAUDE.md not found or incomplete:
- Use sensible language-specific defaults
- Suggest creating/updating CLAUDE.md with `/setup`
- Continue with graceful degradation

---

## Summary

This STANDARDS.md file provides a comprehensive reference for all project standards, organized by category with direct links to detailed documentation. Use this as a quick lookup when:

- **Refactoring code**: Check Code Standards, Clean-Break Development, and Architecture Standards
- **Writing tests**: Review Testing Standards and Non-Interactive Testing
- **Creating commands**: Reference Command Development and Code Quality Enforcement
- **Writing documentation**: Follow Documentation Standards and README Requirements
- **Architecting features**: Consult Hierarchical Agent Architecture and Skills Architecture
- **Debugging issues**: Use Error Logging Standards and Validation Commands

All standards are enforced via automated validation and pre-commit hooks to ensure consistency across the repository.
