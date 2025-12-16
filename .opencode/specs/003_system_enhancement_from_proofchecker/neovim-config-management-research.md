# NeoVim Configuration Management: Research Summary

**Date**: December 15, 2025  
**Purpose**: Research best practices for neovim configuration management to inform improvements to the `.config/.opencode` system

---

## Executive Summary

This research synthesizes best practices from official NeoVim documentation, community standards (lazy.nvim, kickstart.nvim), and the existing `.config/.opencode` architecture to identify key patterns and improvement opportunities for neovim configuration management through OpenCode agents.

**Key Finding**: The current `.config/.opencode` system demonstrates mature organizational patterns with excellent delegation architecture, but could benefit from enhanced context organization inspired by the OpenAgents project's modular approach.

---

## 1. Modular Configuration Patterns

### 1.1 Lua Module Organization (NeoVim Official Patterns)

**Directory Structure Best Practices**:
```
~/.config/nvim/
  init.lua              # Entry point
  lua/
    core/              # Core settings (options, keymaps, autocommands)
    plugins/           # Plugin specifications (one per file)
    lsp/               # LSP configurations
    config/            # Feature configurations
    utils/             # Utility modules
```

**Key Principles**:
- **One module per file**: Each plugin gets its own spec file in `lua/plugins/`
- **Lazy loading by default**: Use `require()` caching, module pattern `local M = {}`
- **Clear separation**: Core settings vs plugin configs vs LSP configs
- **Runtime path**: Place modules in `lua/` directory for `require()` access

**Module Pattern** (from official docs):
```lua
local M = {}

-- Private functions (local)
local function private_helper()
  -- implementation
end

-- Public functions (on M table)
M.public_function = function()
  -- implementation
end

return M
```

### 1.2 Plugin Configuration Organization (lazy.nvim)

**lazy.nvim Spec Format**:
```lua
return {
  "owner/repo",
  event = "VeryLazy",    -- Lazy-load trigger
  dependencies = {...},  -- Plugin dependencies
  opts = {...},          -- Configuration options
  config = function()    -- Setup function
    require("plugin").setup()
  end,
}
```

**Loading Triggers**:
- `event`: Event-based (VeryLazy, BufRead, BufEnter, FileType)
- `cmd`: Command-based loading
- `ft`: Filetype-based loading
- `keys`: Keybinding-based loading
- `lazy = true`: Manual loading

**Organization Strategy** (from kickstart.nvim):
- Single-file for simple configs (`init.lua`)
- Multi-file for complex configs (modular approach)
- Group related plugins together
- Clear, descriptive filenames

**Performance Patterns**:
- Heavy plugins (telescope, nvim-tree): `event = "VeryLazy"`
- Language-specific: `ft = "python"`
- Command-heavy: `cmd = {"CommandName"}`
- Defer UI plugins when possible

### 1.3 LSP Configuration Best Practices

**Key Components**:
1. **nvim-lspconfig**: LSP client configurations
2. **mason.nvim**: LSP/DAP/linter installer
3. **nvim-cmp**: Completion engine
4. **Custom handlers**: Buffer-specific configurations

**Best Practice Pattern**:
```lua
-- LSP setup with buffer-local keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
  end
})
```

**Organization**:
- Centralize LSP configs in `lua/lsp/`
- Use autocommands for buffer-local settings
- Separate server configs from keybindings
- Leverage Mason for consistent installations

### 1.4 Keybinding Organization Strategies

**Two-Tier Approach** (from .config STANDARDS.md):
1. **which-key.lua**: Discovery mode, grouped bindings with descriptions
2. **keymaps.lua**: Core bindings that should be muscle memory

**Best Practices**:
- Use `vim.keymap.set()` for all mappings (modern API)
- Always include `desc` for discoverability
- Buffer-local mappings via `buffer = args.buf`
- Group related mappings with which-key
- Non-recursive by default (`remap = false`)

**Example**:
```lua
vim.keymap.set('n', '<Leader>pl1', require('plugin').action,
  { desc = 'Execute action from plugin', silent = true })
```

---

## 2. Context Organization for Neovim

### 2.1 Essential Knowledge Domains

**Current .config/.opencode Domain Files**:
- `neovim-architecture.md`: Core NeoVim components and APIs
- `plugin-ecosystem.md`: Plugin landscape and lazy.nvim patterns
- `lsp-system.md`: LSP architecture and configuration
- `git-integration.md`: Version control integration
- `nixos-basics.md`: NixOS-specific patterns
- `typesetting.md`: LaTeX/typesetting integration
- `ai-integrations.md`: AI tool integration
- `email-integration.md`: Email workflow
- `formal-verification.md`: Proof assistant integration
- `neotex-structure.md`: Custom NeoTeX system

**Analysis**: The domain files are **comprehensive and well-organized**. They use XML-like tags for structure (e.g., `<architecture>`, `<concepts>`), which provides clear semantic organization.

**Recommendation**: Continue this pattern. Consider adding:
- `performance-optimization.md`: Startup time, profiling, benchmarking
- `testing-patterns.md`: How to test neovim configs
- `debugging-techniques.md`: :checkhealth interpretation, logging patterns

### 2.2 Context File Organization Patterns

**OpenAgents Pattern** (for comparison):
```
.opencode/context/
  core/
    standards/     # Quality guidelines (code, docs, tests, patterns)
    workflows/     # Process templates (delegation, review, sessions)
    system/        # System guides
  project/         # Project-specific context
```

**Current .config/.opencode Pattern**:
```
.opencode/context/
  domain/          # Knowledge domains (10 files)
  processes/       # Workflow definitions (5 files)
  standards/       # Coding standards (5 files)
  templates/       # File templates (4 files)
```

**Comparison**:
- **OpenAgents**: Flatter, clearer categorization (standards/workflows/system)
- **.config/.opencode**: More granular, domain-heavy (domain/processes/standards/templates)

**Recommendation**: The current structure is **excellent for neovim**, which genuinely has many distinct knowledge domains. The OpenAgents pattern works better for general software projects.

**Potential Enhancement**: Add an `index.md` similar to OpenAgents for quick context discovery:
```markdown
# Context Index

## Quick Map
code        → standards/lua-coding-standards.md
plugins     → domain/plugin-ecosystem.md
lsp         → domain/lsp-system.md
research    → processes/research-workflow.md
implement   → processes/implementation-workflow.md
```

### 2.3 Standards and Templates

**Current Standards Files**:
1. `lua-coding-standards.md`: Naming, module pattern, docs, error handling
2. `plugin-standards.md`: Plugin organization and configuration
3. `documentation-standards.md`: Documentation format and style
4. `testing-standards.md`: Testing approach and patterns
5. `validation-rules.md`: Validation criteria

**Current Templates**:
1. `plugin-config-template.md`: Plugin spec template
2. `plan-template.md`: Implementation plan structure
3. `report-template.md`: Research report format
4. `commit-message-template.md`: Commit format

**Analysis**: Standards are **comprehensive and well-defined**. The lua-coding-standards.md follows official NeoVim conventions (snake_case, module pattern, LuaDoc).

**Anti-Pattern Detection** (from standards):
- **Avoid**: Modifying global state without pcall
- **Avoid**: Large monolithic config files
- **Avoid**: Synchronous operations that block
- **Avoid**: Hardcoded paths (use vim.fn.stdpath())

---

## 3. Workflow Patterns

### 3.1 Research → Plan → Implement → Test Cycle

**Current .config/.opencode Workflow**:
```
Research (researcher agent)
  ↓ (creates OVERVIEW.md)
Plan (planner agent)
  ↓ (creates implementation_v1.md)
Implement (implementer agent)
  ↓ (executes phases, invokes subagents)
Test (tester agent, invoked per phase)
  ↓ (validates changes)
Revise (reviser agent, if needed)
```

**Strengths**:
- Clear phase separation
- Parallel execution within phases
- Git commits per phase
- State tracking via TODO.md and state.json

**OpenAgents Pattern** (for comparison):
```
Plan → Approve → Load Context → Execute → Validate → Summarize
```

**Key Difference**: .config/.opencode has **implicit approval** (research generates, plan executes), while OpenAgents has **explicit approval gates**.

**Recommendation**: Consider adding explicit approval step between plan and implement:
```
Plan → Show Summary → Await User Approval → Implement
```

### 3.2 Plugin Evaluation and Integration

**Best Practice Workflow** (synthesized from research):

```
1. Research Phase
   - Check plugin documentation
   - Verify compatibility (NeoVim version, dependencies)
   - Read GitHub issues for known problems
   - Check last update date and maintenance status
   - Review alternatives

2. Trial Phase
   - Add plugin with lazy = true (manual loading)
   - Test in isolation
   - Measure startup impact (nvim --startuptime)
   - Check :checkhealth output

3. Integration Phase
   - Determine optimal loading strategy (event/cmd/ft/keys)
   - Configure plugin following standards
   - Add keybindings with which-key
   - Document in appropriate context file
   - Test with existing config

4. Validation Phase
   - Run :checkhealth
   - Check for conflicts
   - Measure performance impact
   - Commit with descriptive message
```

**Automation Opportunity**: Create a `plugin-analyzer` subagent that automates steps 1-2.

### 3.3 Performance Optimization Workflow

**Best Practices** (from lazy.nvim docs):
1. Use `nvim --startuptime startup.log` to profile
2. Check lazy.nvim profiler with `:Lazy profile`
3. Defer non-critical plugins with VeryLazy event
4. Use partial clones (default in lazy.nvim)
5. Enable bytecode compilation (automatic)

**Recommended Workflow**:
```
1. Baseline Measurement
   - Record current startup time
   - Note plugin count and load order

2. Analysis
   - Identify slow-loading plugins
   - Check for unnecessary eager loading
   - Look for redundant plugins

3. Optimization
   - Add lazy-loading triggers
   - Remove unused plugins
   - Optimize plugin configurations
   - Defer UI plugins

4. Validation
   - Measure new startup time
   - Verify functionality
   - Document changes
```

**Current Implementation**: The `performance-profiler` subagent handles this. Consider enhancing with automated recommendations.

### 3.4 Health Check and Maintenance Workflow

**:checkhealth Interpretation** (best practices):
- **ERROR**: Must fix (LSP not installed, missing dependencies)
- **WARNING**: Should fix (outdated versions, missing optional features)
- **OK**: Informational (confirmation of correct setup)

**Maintenance Cycle**:
```
Weekly:
  - Run :checkhealth
  - Check for plugin updates (lazy.nvim auto-checks)
  - Review and apply updates

Monthly:
  - Audit plugin list for unused plugins
  - Review keybindings for conflicts
  - Check for deprecated APIs
  - Update documentation

Quarterly:
  - Performance profiling
  - Configuration cleanup
  - Backup and archival
```

**Current Implementation**: The `health-checker` subagent handles interpretation. The `cruft-finder` handles unused code detection.

---

## 4. Tool Integration Strategies

### 4.1 lazy.nvim Plugin Manager Patterns

**Core Features Leveraged**:
- Automatic lazy-loading
- Lockfile (`lazy-lock.json`) for reproducibility
- Built-in profiler
- UI for management (`:Lazy`)
- Automatic helptag generation

**Configuration Best Practices**:
```lua
require("lazy").setup({
  spec = {
    { import = "plugins" },  -- Import all files from lua/plugins/
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml",
        "tutor", "zipPlugin",
      },
    },
  },
})
```

**Integration Pattern**:
- Use spec files in `lua/plugins/`
- One plugin per file
- Clear dependencies via `dependencies` field
- Version pinning with `commit` or `tag`
- Lock file in version control (recommended)

### 4.2 Mason LSP Installer Integration

**Best Practice Pattern**:
```lua
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "rust_analyzer", "pyright" },
  automatic_installation = true,
})
```

**Integration Strategy**:
- Declarative server installation
- Automatic setup with nvim-lspconfig
- Consistent across machines
- Version control via lockfile

**Current Implementation**: The `lsp-configurator` subagent handles this.

### 4.3 :checkhealth Usage and Interpretation

**Health Check Categories**:
1. **Provider Health**: Python, Node, Ruby, Perl providers
2. **Plugin Health**: Each plugin's self-check
3. **LSP Health**: Server installations and configurations
4. **System Health**: Clipboard, terminal, performance

**Automated Interpretation Pattern**:
```
ERROR → Create fix tasks with high priority
WARNING → Create fix tasks with medium priority
OK → Log for reference
```

**Current Implementation**: The `health-checker` subagent categorizes by severity and provides actionable fixes.

### 4.4 Git Workflows for Dotfiles

**Best Practices**:
1. **Commit granularity**: One logical change per commit
2. **Conventional commits**: `feat:`, `fix:`, `refactor:`, `docs:`
3. **Lock files**: Track `lazy-lock.json` in version control
4. **Branches**: Use branches for experimental configs
5. **Tags**: Tag stable configurations

**Current Implementation**:
```
- Automatic commits per phase
- Conventional commit format
- Git worktree support (via /worktrees command)
- NixOS integration (.dotfiles repository)
```

**Recommendation**: The current implementation is **excellent**. Consider adding:
- Pre-commit hooks for linting
- Automated backup before major changes
- Recovery commands for quick rollback

---

## 5. Context Organization Recommendations

### 5.1 Recommended Structure (Enhanced)

**Proposed Enhancement** (minimal changes to current system):

```
.opencode/context/
  domain/                    # Keep as-is (10 files) ✓
  processes/                 # Keep as-is (5 files) ✓
  standards/                 # Keep as-is (5 files) ✓
  templates/                 # Keep as-is (4 files) ✓
  index.md                   # NEW: Quick reference map
  essential-patterns.md      # NEW: Quick-start patterns
```

**index.md** (similar to OpenAgents pattern):
```markdown
# Context Index

Path: `.opencode/context/{category}/{file}`

## Quick Map
plugins     → domain/plugin-ecosystem.md     [critical]
lsp         → domain/lsp-system.md           [critical]
lua         → standards/lua-coding-standards.md [critical]
research    → processes/research-workflow.md  [high]
implement   → processes/implementation-workflow.md [high]
health      → processes/health-check-workflow.md  [high]

## By Use Case
- Adding new plugin → domain/plugin-ecosystem.md, standards/plugin-standards.md
- LSP setup → domain/lsp-system.md, processes/lsp-setup-workflow.md
- Performance → domain/performance-optimization.md
- Troubleshooting → processes/debugging-workflow.md
```

**essential-patterns.md** (distilled quick-start):
```markdown
# Essential Patterns

Quick reference for common tasks.

## Add Plugin
1. Create lua/plugins/plugin-name.lua
2. Use lazy.nvim spec format
3. Add loading trigger (event/cmd/ft/keys)
4. Configure with opts or config function
5. Test with :Lazy

## Setup LSP
1. Add server to mason ensure_installed
2. Configure in lsp/servers/
3. Add buffer-local keymaps
4. Run :checkhealth
```

### 5.2 Knowledge Domain Priorities

**Critical (must-load for most tasks)**:
- `plugin-ecosystem.md`: Plugin management patterns
- `lsp-system.md`: LSP configuration
- `lua-coding-standards.md`: Code standards
- `neovim-architecture.md`: Core concepts

**High (load for specific workflows)**:
- `git-integration.md`: Version control
- `performance-optimization.md`: Speed improvements
- `research-workflow.md`: Research process
- `implementation-workflow.md`: Implementation process

**Medium (load on demand)**:
- Domain-specific files (typesetting, email, AI, formal-verification)
- NixOS-specific patterns
- Advanced integrations

### 5.3 Lazy Loading Strategy for Context

**Current Approach**: context.lazy = true (load on demand)

**Recommendation**: Implement tiered loading:
```yaml
context:
  always:
    - standards/lua-coding-standards.md
  lazy:
    - domain/*
    - processes/*
  ondemand:
    - templates/*
```

**Agent-Specific Context Loading**:
- **Researcher**: processes/research-workflow.md, domain/plugin-ecosystem.md
- **Implementer**: standards/lua-coding-standards.md, processes/implementation-workflow.md
- **Tester**: processes/testing-workflow.md, domain/lsp-system.md

---

## 6. Workflow Optimization Recommendations

### 6.1 Enhanced Research Workflow

**Current**: Research → OVERVIEW.md → Plan

**Recommended Enhancement**:
```
Research
  ↓
OVERVIEW.md + QUICK_WINS.md
  ↓
Decision: Quick win or Full implementation?
  ↓
Quick win: Direct implementation
Full: Create plan → Implement
```

**Rationale**: Many neovim config changes are small (add plugin, change option). Creating full plans adds overhead.

### 6.2 Approval Gates

**Add Explicit Approval** (inspired by OpenAgents):
```
Plan created
  ↓
Show summary to user
  ↓
User approval (yes/no/modify)
  ↓
Implement
```

**Implementation**: Add `approval_required` flag to planner agent.

### 6.3 Incremental Testing

**Current**: Test after each phase

**Enhancement**: Add pre-flight check
```
Before Phase:
  - Check :checkhealth baseline
  - Record startup time
  - Snapshot configuration

After Phase:
  - Run :checkhealth (compare)
  - Measure startup time (compare)
  - Verify functionality
```

### 6.4 Rollback Mechanism

**Add Quick Rollback**:
```bash
/rollback [commit-hash]
# or
/rollback last-phase
```

**Implementation**: Store phase commits in state.json for easy reference.

---

## 7. Comparison: .config/.opencode vs OpenAgents

### 7.1 Architectural Patterns

| Aspect | .config/.opencode | OpenAgents |
|--------|------------------|------------|
| **Agent Hierarchy** | Orchestrator → Primary → Subagents | Primary → Subagents |
| **Context Organization** | Domain-heavy (10 domains) | Standard-heavy (code/docs/tests) |
| **Delegation Strategy** | Always delegate (context isolation) | Delegate if 4+ files or 60+ min |
| **Workflow** | Research → Plan → Implement | Plan → Approve → Execute |
| **State Management** | state.json + TODO.md | Session-based temp files |
| **Parallelization** | Heavy (up to 5 concurrent) | Moderate (task-based) |

### 7.2 Strengths of Each

**.config/.opencode Strengths**:
- **Domain specialization**: Deep knowledge files for complex domain (neovim)
- **Parallel research**: Fast information gathering
- **Context isolation**: Excellent token economy
- **State persistence**: Comprehensive tracking

**OpenAgents Strengths**:
- **Approval gates**: Explicit user control
- **Context index**: Quick discovery system
- **Modular standards**: Clear quality guidelines
- **Simpler hierarchy**: Fewer abstraction layers

### 7.3 Integration Opportunities

**Patterns to Import from OpenAgents**:
1. **Context Index**: Add quick reference map
2. **Approval Gates**: Explicit user confirmation
3. **Essential Patterns**: Distilled quick-start guide
4. **Lazy Context Loading**: Tiered loading strategy

**Patterns to Keep from .config/.opencode**:
1. **Domain specialization**: Rich knowledge files
2. **Parallel delegation**: Fast research
3. **State management**: state.json + TODO.md
4. **Orchestrator pattern**: Clean routing

---

## 8. Implementation Plan

### Phase 1: Context Enhancement (Low Risk)
- [ ] Add `context/index.md` for quick discovery
- [ ] Add `context/essential-patterns.md` for quick-start
- [ ] Add `context/domain/performance-optimization.md`
- [ ] Add `context/domain/testing-patterns.md`
- [ ] Add `context/domain/debugging-techniques.md`

### Phase 2: Workflow Improvements (Medium Risk)
- [ ] Add approval gate to planner agent
- [ ] Create quick-win detection in researcher
- [ ] Implement pre-flight health checks
- [ ] Add rollback command

### Phase 3: Testing Infrastructure (Low Risk)
- [ ] Create testing workflow documentation
- [ ] Add automated health check diffing
- [ ] Implement startup time tracking
- [ ] Create benchmark repository

### Phase 4: Advanced Features (High Risk)
- [ ] Implement tiered context loading
- [ ] Add plugin analyzer automation
- [ ] Create configuration validation suite
- [ ] Implement automated optimization suggestions

---

## 9. Key Takeaways

### Best Practices Confirmed
1. **Modular organization**: One plugin per file, clear directory structure
2. **Lazy loading**: Event/cmd/ft/keys triggers for optimal performance
3. **Standards compliance**: snake_case, module pattern, LuaDoc
4. **Git integration**: Commit granularity, conventional commits, lock files
5. **Health monitoring**: Regular :checkhealth, automated interpretation

### New Insights
1. **Context discovery**: Index files significantly improve agent efficiency
2. **Approval gates**: Explicit user control improves trust and outcomes
3. **Quick wins**: Not all changes need full research → plan → implement cycle
4. **Essential patterns**: Distilled guides reduce onboarding time
5. **Tiered loading**: Context files can be categorized by frequency of use

### Anti-Patterns Identified
1. **Monolithic configs**: Split into modules instead
2. **Synchronous blocking**: Use async/pcall patterns
3. **Global state mutation**: Isolate to modules
4. **Hardcoded paths**: Use vim.fn.stdpath()
5. **Missing descriptions**: Always add desc to keymaps

### Architecture Validation
The current `.config/.opencode` architecture is **excellent** for neovim configuration management. The domain-heavy context organization is appropriate for this complex problem space. Key enhancements should focus on:
- **Context discovery** (index files)
- **User control** (approval gates)
- **Quick operations** (fast-path for simple changes)
- **Knowledge sharing** (essential patterns guide)

---

## 10. References

### Official Documentation
- [NeoVim Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [lazy.nvim Documentation](https://lazy.folke.io/)
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

### Current System
- `.config/.opencode/README.md`: System overview
- `.config/.opencode/ARCHITECTURE.md`: Architecture details
- `.config/.opencode/context/`: Context files
- `.config/STANDARDS.md`: Lua coding standards

### Community Resources
- NeoVim Plugin Ecosystem
- Mason LSP Installer
- which-key.nvim (keybinding discovery)
- nvim-treesitter (syntax highlighting)

---

## Appendix A: Context File Templates

### A.1 Domain File Template
```markdown
# Domain Name

**Domain**: Brief description

---

## Core Components

<component_name>
  <feature>
    - Detail
  </feature>
</component_name>

---

## Key Concepts

<concept>
  - Definition
  - Usage
</concept>

---

## References

- Official docs
- Community resources
```

### A.2 Process File Template
```markdown
# Process Name

Process for [purpose].

## Steps

1. Step one
2. Step two

## Subagents Used

- subagent-name

## Output

- Deliverable one
```

---

**End of Research Summary**

This document synthesizes neovim configuration best practices with the current `.config/.opencode` architecture to provide actionable recommendations for system enhancement.
