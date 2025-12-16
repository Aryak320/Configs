# Configuration Subagents

Domain-specific configuration specialists for NeoVim setup and optimization.

---

## Purpose

These agents handle specific configuration domains with expert knowledge. They provide:
- Domain-specific expertise
- Automated diagnostics
- Actionable recommendations
- Configuration optimization

---

## Agents

### health-checker.md
**Purpose**: Runs and interprets :checkhealth with actionable fixes

**Responsibilities**:
- Run nvim --headless +"checkhealth" +"quit"
- Parse and categorize results (critical, warning, ok)
- Identify issues with plugins, LSP, external tools
- Provide specific fix recommendations
- Check for missing dependencies

**Command**: `/health-check`

**Returns**: Health report with actionable fixes

---

### keybinding-optimizer.md
**Purpose**: Manages keybinding organization and optimization

**Responsibilities**:
- Organize which-key.lua vs keymaps.lua
- Detect keybinding conflicts
- Optimize keybinding layout
- Suggest improvements
- Maintain consistency

**Invocation**: Via researcher agent or standalone

**Returns**: Keybinding optimization report

---

### lsp-configurator.md
**Purpose**: LSP setup and optimization specialist

**Responsibilities**:
- Configure LSP servers
- Integrate with Mason
- Optimize performance
- Set up custom handlers
- Manage capabilities

**Invocation**: Via researcher agent or standalone

**Returns**: LSP configuration report

---

## Invocation Patterns

### Standalone (via commands)
```
User → /health-check
  ↓
Orchestrator → @subagents/configuration/health-checker
  ↓
User ← Health report with fixes
```

### During Research
```
Researcher → @subagents/configuration/lsp-configurator
  ↓
Researcher ← Brief summary + report path
```

---

## Use Cases

**health-checker**:
- Regular health checks
- Issue diagnostics
- Dependency verification
- Post-installation validation

**keybinding-optimizer**:
- Keybinding reorganization
- Conflict resolution
- Layout optimization
- Consistency enforcement

**lsp-configurator**:
- LSP server setup
- Performance optimization
- Custom handler configuration
- Mason integration

---

## Domain Expertise

Configuration subagents provide specialized knowledge in:
- **health-checker**: NeoVim health system, dependency management
- **keybinding-optimizer**: Keybinding best practices, which-key patterns
- **lsp-configurator**: LSP protocol, server configuration, Mason ecosystem

---

## Context Reduction

Configuration subagents enable context reduction through:
- Brief summary returns
- Report path passing
- Focused domain scope
- Clear actionable recommendations
