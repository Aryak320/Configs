# Context Index

Quick reference map for all context files in the .opencode system. This index helps agents and users discover relevant context for specific tasks.

**Total Context Files**: 27 files across 4 categories

---

## Quick Reference Map

### Domain Files (13 files)

Domain-specific knowledge about NeoVim configuration components.

- **[neovim-architecture.md](domain/neovim-architecture.md)** - Core NeoVim architecture, init system, plugin system, Lua runtime, and API layers
- **[plugin-ecosystem.md](domain/plugin-ecosystem.md)** - Plugin manager (lazy.nvim), plugin categories, and lazy-loading strategies
- **[lsp-system.md](domain/lsp-system.md)** - Language Server Protocol integration, client-server architecture, and LSP capabilities
- **[neotex-structure.md](domain/neotex-structure.md)** - Specific directory organization for this NeoVim configuration
- **[ai-integrations.md](domain/ai-integrations.md)** - AI coding assistants (OpenCode, MCP Hub, Lectic) and integration patterns
- **[git-integration.md](domain/git-integration.md)** - Git workflow integration and fugitive.vim usage
- **[email-integration.md](domain/email-integration.md)** - Email client integration patterns
- **[formal-verification.md](domain/formal-verification.md)** - Lean 4 and formal verification tooling
- **[typesetting.md](domain/typesetting.md)** - LaTeX and document typesetting configuration
- **[nixos-basics.md](domain/nixos-basics.md)** - NixOS-specific configuration considerations
- **[performance-optimization.md](domain/performance-optimization.md)** - Performance optimization strategies, profiling tools, and lazy-loading patterns
- **[testing-patterns.md](domain/testing-patterns.md)** - Testing methodologies, test organization, and validation patterns
- **[debugging-techniques.md](domain/debugging-techniques.md)** - Debugging strategies, diagnostic tools, and troubleshooting workflows

### Standards Files (5 files)

Coding standards, conventions, and validation rules.

- **[lua-coding-standards.md](standards/lua-coding-standards.md)** - Lua naming conventions, module patterns, documentation, and error handling
- **[plugin-standards.md](standards/plugin-standards.md)** - Plugin specification format, lazy-loading patterns, and configuration standards
- **[documentation-standards.md](standards/documentation-standards.md)** - Documentation structure, style guide, and content standards
- **[testing-standards.md](standards/testing-standards.md)** - Test organization, coverage requirements, and testing patterns
- **[validation-rules.md](standards/validation-rules.md)** - Validation rules for plans, code, and configurations

### Process Files (5 files)

Workflow processes for different development activities.

- **[implementation-workflow.md](processes/implementation-workflow.md)** - Process for executing implementation plans with waves and phases
- **[planning-workflow.md](processes/planning-workflow.md)** - Process for creating implementation plans from research
- **[research-workflow.md](processes/research-workflow.md)** - Process for conducting research and creating reports
- **[revision-workflow.md](processes/revision-workflow.md)** - Process for revising plans based on feedback or changes
- **[git-integration.md](processes/git-integration.md)** - Git workflow integration process

### Template Files (4 files)

Reusable templates for common artifacts.

- **[plan-template.md](templates/plan-template.md)** - Implementation plan structure with waves, phases, and tasks
- **[report-template.md](templates/report-template.md)** - Research report structure and format
- **[plugin-config-template.md](templates/plugin-config-template.md)** - Plugin specification template for lazy.nvim
- **[commit-message-template.md](templates/commit-message-template.md)** - Git commit message format

---

## Use Case Index

### Adding a New Plugin

**Relevant Context**:
1. [plugin-ecosystem.md](domain/plugin-ecosystem.md) - Understanding lazy.nvim and plugin categories
2. [plugin-standards.md](standards/plugin-standards.md) - Plugin specification format and standards
3. [plugin-config-template.md](templates/plugin-config-template.md) - Template for plugin configuration
4. [neotex-structure.md](domain/neotex-structure.md) - Where to place plugin files
5. [lua-coding-standards.md](standards/lua-coding-standards.md) - Lua coding conventions

**Workflow**: Research → Plan → Implement → Test → Document

### Configuring LSP Server

**Relevant Context**:
1. [lsp-system.md](domain/lsp-system.md) - LSP architecture and capabilities
2. [neotex-structure.md](domain/neotex-structure.md) - LSP directory structure
3. [lua-coding-standards.md](standards/lua-coding-standards.md) - Lua module patterns
4. [testing-standards.md](standards/testing-standards.md) - Testing LSP configurations

**Workflow**: Research language server → Configure in lua/lsp/servers/ → Test

### Creating Implementation Plan

**Relevant Context**:
1. [planning-workflow.md](processes/planning-workflow.md) - Planning process
2. [plan-template.md](templates/plan-template.md) - Plan structure template
3. [validation-rules.md](standards/validation-rules.md) - Plan validation requirements
4. [implementation-workflow.md](processes/implementation-workflow.md) - How plans are executed

**Workflow**: Research → Create plan → Validate → Execute

### Implementing a Feature

**Relevant Context**:
1. [implementation-workflow.md](processes/implementation-workflow.md) - Implementation process
2. [neotex-structure.md](domain/neotex-structure.md) - File organization
3. [lua-coding-standards.md](standards/lua-coding-standards.md) - Coding standards
4. [testing-standards.md](standards/testing-standards.md) - Testing requirements
5. [testing-patterns.md](domain/testing-patterns.md) - Testing methodologies and patterns
6. [git-integration.md](processes/git-integration.md) - Git workflow

**Workflow**: Read plan → Execute waves → Test → Commit → Document

### Conducting Research

**Relevant Context**:
1. [research-workflow.md](processes/research-workflow.md) - Research process
2. [report-template.md](templates/report-template.md) - Report structure
3. [documentation-standards.md](standards/documentation-standards.md) - Documentation format

**Workflow**: Define scope → Research → Create report → Validate

### Revising a Plan

**Relevant Context**:
1. [revision-workflow.md](processes/revision-workflow.md) - Revision process
2. [plan-template.md](templates/plan-template.md) - Plan structure
3. [validation-rules.md](standards/validation-rules.md) - Validation requirements

**Workflow**: Analyze feedback → Update plan → Validate → Re-execute

### Integrating AI Tools

**Relevant Context**:
1. [ai-integrations.md](domain/ai-integrations.md) - AI tool landscape
2. [plugin-ecosystem.md](domain/plugin-ecosystem.md) - Plugin integration patterns
3. [neotex-structure.md](domain/neotex-structure.md) - Configuration structure

**Workflow**: Research tool → Plan integration → Configure → Test

### Optimize Performance

**Relevant Context**:
1. [performance-optimization.md](domain/performance-optimization.md) - Performance strategies and profiling
2. [plugin-ecosystem.md](domain/plugin-ecosystem.md) - Lazy-loading patterns
3. [neovim-architecture.md](domain/neovim-architecture.md) - NeoVim runtime and initialization
4. [lua-coding-standards.md](standards/lua-coding-standards.md) - Efficient coding patterns

**Workflow**: Profile → Identify bottlenecks → Optimize → Validate improvements

### Test Changes

**Relevant Context**:
1. [testing-patterns.md](domain/testing-patterns.md) - Testing methodologies and organization
2. [testing-standards.md](standards/testing-standards.md) - Testing requirements and coverage
3. [lua-coding-standards.md](standards/lua-coding-standards.md) - Code structure for testability
4. [validation-rules.md](standards/validation-rules.md) - Validation requirements

**Workflow**: Write tests → Run tests → Validate coverage → Fix failures

### Debug Issue

**Relevant Context**:
1. [debugging-techniques.md](domain/debugging-techniques.md) - Debugging strategies and tools
2. [neovim-architecture.md](domain/neovim-architecture.md) - Understanding system behavior
3. [lsp-system.md](domain/lsp-system.md) - LSP-specific debugging
4. [testing-patterns.md](domain/testing-patterns.md) - Test-driven debugging

**Workflow**: Reproduce issue → Isolate cause → Apply fix → Validate → Test

---

## Agent-Specific Index

### Planner Agent

**Required Context**:
- [planning-workflow.md](processes/planning-workflow.md) - Planning process
- [plan-template.md](templates/plan-template.md) - Plan structure
- [validation-rules.md](standards/validation-rules.md) - Validation requirements
- [neotex-structure.md](domain/neotex-structure.md) - File organization
- [debugging-techniques.md](domain/debugging-techniques.md) - Debugging strategies

**Optional Context** (based on task):
- Domain files relevant to feature being planned
- [implementation-workflow.md](processes/implementation-workflow.md) - How plans are executed
- [performance-optimization.md](domain/performance-optimization.md) - For performance-focused plans

### Researcher Agent

**Required Context**:
- [research-workflow.md](processes/research-workflow.md) - Research process
- [report-template.md](templates/report-template.md) - Report structure
- [documentation-standards.md](standards/documentation-standards.md) - Documentation format
- [debugging-techniques.md](domain/debugging-techniques.md) - Debugging strategies

**Optional Context** (based on research topic):
- Relevant domain files (e.g., lsp-system.md for LSP research)
- [neotex-structure.md](domain/neotex-structure.md) - Configuration context
- [performance-optimization.md](domain/performance-optimization.md) - For performance research

### Implementer Agent

**Required Context**:
- [implementation-workflow.md](processes/implementation-workflow.md) - Implementation process
- [lua-coding-standards.md](standards/lua-coding-standards.md) - Coding standards
- [neotex-structure.md](domain/neotex-structure.md) - File organization
- [testing-standards.md](standards/testing-standards.md) - Testing requirements
- [testing-patterns.md](domain/testing-patterns.md) - Testing methodologies
- [debugging-techniques.md](domain/debugging-techniques.md) - Debugging strategies

**Optional Context** (based on task):
- [plugin-standards.md](standards/plugin-standards.md) - For plugin work
- [lsp-system.md](domain/lsp-system.md) - For LSP work
- [git-integration.md](processes/git-integration.md) - For git operations
- [performance-optimization.md](domain/performance-optimization.md) - For performance-critical work

### Tester Agent

**Required Context**:
- [testing-standards.md](standards/testing-standards.md) - Testing requirements
- [testing-patterns.md](domain/testing-patterns.md) - Testing methodologies
- [lua-coding-standards.md](standards/lua-coding-standards.md) - Code structure understanding
- [validation-rules.md](standards/validation-rules.md) - Validation requirements
- [debugging-techniques.md](domain/debugging-techniques.md) - Debugging strategies

**Optional Context** (based on test type):
- [neotex-structure.md](domain/neotex-structure.md) - File organization
- Relevant domain files for integration tests

### Documenter Agent

**Required Context**:
- [documentation-standards.md](standards/documentation-standards.md) - Documentation format
- [lua-coding-standards.md](standards/lua-coding-standards.md) - Code documentation patterns
- [debugging-techniques.md](domain/debugging-techniques.md) - Debugging strategies

**Optional Context** (based on documentation target):
- [neotex-structure.md](domain/neotex-structure.md) - Configuration structure
- Relevant domain files for context

### Reviser Agent

**Required Context**:
- [revision-workflow.md](processes/revision-workflow.md) - Revision process
- [plan-template.md](templates/plan-template.md) - Plan structure
- [validation-rules.md](standards/validation-rules.md) - Validation requirements
- [debugging-techniques.md](domain/debugging-techniques.md) - Debugging strategies

**Optional Context** (based on revision scope):
- [planning-workflow.md](processes/planning-workflow.md) - Original planning process
- [implementation-workflow.md](processes/implementation-workflow.md) - Execution context

### Orchestrator Agent

**Required Context**:
- [implementation-workflow.md](processes/implementation-workflow.md) - Orchestration process
- [neotex-structure.md](domain/neotex-structure.md) - Configuration structure
- [debugging-techniques.md](domain/debugging-techniques.md) - Debugging strategies
- All workflow files for coordinating subagents

**Optional Context**:
- All domain files for comprehensive understanding
- All standards files for validation
- [performance-optimization.md](domain/performance-optimization.md) - For performance coordination
- [testing-patterns.md](domain/testing-patterns.md) - For test orchestration

---

## Context Loading Strategies

### Minimal Context (Fast)

Load only required context for specific agent and task. Use for simple, focused tasks.

**Example**: Adding a simple plugin
- plugin-standards.md
- plugin-config-template.md
- lua-coding-standards.md

### Standard Context (Balanced)

Load required context plus relevant domain files. Use for typical development tasks.

**Example**: Implementing LSP configuration
- implementation-workflow.md
- lsp-system.md
- neotex-structure.md
- lua-coding-standards.md
- testing-standards.md

### Full Context (Comprehensive)

Load all relevant context for complex or cross-cutting tasks. Use for major features or refactoring.

**Example**: Major architecture change
- All workflow files
- All relevant domain files
- All standards files
- Relevant templates

---

## Maintenance Notes

**Last Updated**: 2025-12-16 (Added performance-optimization.md, testing-patterns.md, debugging-techniques.md)

**Update Triggers**:
- New context file added to any category
- Context file renamed or moved
- New use case identified
- Agent responsibilities change

**Validation**:
- All file links should be valid relative paths
- File counts should match actual directory contents
- Agent-specific indices should align with agent definitions
