# System Architecture

**NeoVim Configuration Management System**

---

## Design Principles

1. **Research-First**: Always research before implementing
2. **Context Isolation**: Minimize token usage through delegation
3. **Parallel Execution**: Maximize concurrency where possible
4. **Standards Compliance**: Follow coding standards strictly
5. **Automated Testing**: Test after every change
6. **Git Integration**: Automatic version control

---

## Delegation Patterns

The system uses two types of agents with distinct delegation patterns:

### Coordinator Agents (Delegate ALL Work)

**Pattern**: Mandatory delegation via task tool

**Agents**:
- **Researcher**: Delegates to research subagents (codebase-analyzer, docs-fetcher, best-practices-researcher, dependency-analyzer, refactor-finder)
- **Implementer**: Delegates to implementation subagents (code-generator, code-modifier, test-runner, doc-generator)
- **Tester**: Delegates to test subagents (health-checker, plugin-tester, lsp-validator, keybinding-tester, performance-tester)
- **Documenter**: Delegates to documentation subagents (module-documenter, example-generator, guide-writer, readme-generator)

**Characteristics**:
- Use task tool for ALL work execution
- Maintain small context (coordination only)
- Receive brief summaries from subagents (95% context reduction)
- Enable parallel execution (40-60% time savings)
- Never execute work themselves

**Example**:
```
Researcher:
  1. Creates 3 report files for subtopics
  2. Launches 3 research subagents in parallel:
     task(subagent_type="subagents/research/codebase-analyzer", ...)
     task(subagent_type="subagents/research/docs-fetcher", ...)
     task(subagent_type="subagents/research/best-practices-researcher", ...)
  3. Receives 3 brief summaries (never reads full reports)
  4. Synthesizes summaries into OVERVIEW.md
  
Result: 95% context reduction (~500 tokens vs ~10,000 tokens)
```

### Conditional Coordinators (Delegate When Needed)

**Pattern**: Conditional delegation based on requirements

**Agents**:
- **Reviser**: Delegates to research subagents only when new research is needed

**Characteristics**:
- Delegate only when specific conditions are met
- Read existing artifacts directly when sufficient
- Flexible approach based on task requirements

**Example**:
```
Reviser:
  Scenario 1 (No new research needed):
    - Reads existing plan and research directly
    - Creates new plan version
    - No delegation
  
  Scenario 2 (New research needed):
    - Invokes research subagents via task tool
    - Receives brief summaries
    - Incorporates into revised plan
```

### Specialist Agents (No Delegation)

**Pattern**: Direct execution without delegation

**Agents**:
- **Planner**: Creates implementation plans directly (plan creation IS its specialty)
- **Orchestrator**: Routes requests to primary agents

**Characteristics**:
- Execute work directly (no subagents)
- Use specialized expertise for their specific task
- Read and write files themselves
- No benefit from delegation

**Example**:
```
Planner:
  1. Reads research OVERVIEW.md and all linked reports
  2. Analyzes findings comprehensively
  3. Creates phased implementation plan directly
  4. Writes plan file
  5. Updates TODO.md
  6. Commits to git
  
No delegation - plan creation IS the planner's specialty
```

### Benefits of Delegation Architecture

**Context Window Efficiency**:
- Coordinator agents see only brief summaries (1-2 paragraphs)
- 95%+ context reduction through metadata passing
- Example: Researcher sees ~500 tokens instead of ~10,000 tokens

**Parallel Execution**:
- Independent tasks execute simultaneously (max 5 concurrent)
- 40-60% time savings vs sequential execution
- Example: 3 research subtopics complete in parallel

**Specialist Expertise**:
- Each subagent is optimized for its specific task type
- Higher quality output through specialization
- Focused implementation per task

**Scalability**:
- System can handle complex workflows efficiently
- Context usage remains bounded regardless of task complexity
- Parallel execution scales with available concurrency

---

## Agent Hierarchy

```
User Request
    ↓
Orchestrator (neovim-orchestrator.md)
    ↓
Primary Agents (researcher, planner, reviser, implementer, documenter, tester)
    ↓
Specialized Subagents (organized by category: research, implementation, analysis, configuration)
```

---

## Orchestrator Layer

**File**: `agent/neovim-orchestrator.md`

**Responsibilities**:
- Parse user requests
- Route to appropriate primary agent
- Minimal context usage (routing logic only)
- State coordination between agents

**Routing Logic**:
- `/research` → researcher agent
- `/plan` → planner agent
- `/revise` → reviser agent
- `/implement` → implementer agent
- Utility commands → direct execution

---

## Primary Agent Layer

### Researcher Agent

**File**: `agent/researcher.md`

**Workflow**:
1. Generate project name and ID
2. Decompose research into 1-5 subtopics
3. Invoke research subagents in parallel (max 5)
4. Collect brief summaries (never read full reports)
5. Create OVERVIEW.md synthesis
6. Commit to git

**Subagents Used** (from `subagents/research/`):
- codebase-analyzer
- docs-fetcher
- best-practices-researcher
- dependency-analyzer
- refactor-finder

**Output**: Project directory with OVERVIEW.md and detailed reports

---

### Planner Agent

**File**: `agent/planner.md`

**Workflow**:
1. Read research OVERVIEW.md
2. Break work into phases
3. Organize phases into waves (parallel execution)
4. Define dependencies and estimates
5. Create implementation_v1.md
6. Update TODO.md
7. Commit to git

**Output**: Implementation plan with phased approach

---

### Reviser Agent

**File**: `agent/reviser.md`

**Workflow**:
1. Read existing plan
2. Conduct additional research if needed
3. Create new plan version (v2, v3, etc.)
4. Preserve old versions
5. Update metadata
6. Commit to git

**Output**: New plan version with updates

---

### Implementer Agent

**File**: `agent/implementer.md`

**Workflow**:
1. Parse implementation plan
2. Update plan status to [IN PROGRESS]
3. Execute waves sequentially
4. Within each wave, execute phases in parallel
5. For each phase:
   - Invoke implementation subagents
   - Test changes
   - Commit completion
6. Update TODO.md to Completed

**Subagents Used** (from `subagents/implementation/`):
- code-generator (new files)
- code-modifier (changes)

**Primary Agents Used**:
- tester (validation)
- documenter (documentation)

**Output**: Modified NeoVim config with tests passed

---

## Subagent Layer

Subagents are organized into 4 categories under `agent/subagents/`:
- **research/** - Research and analysis specialists (5 agents)
- **implementation/** - Code generation and modification (2 agents)
- **analysis/** - Specialized analysis tools (3 agents)
- **configuration/** - Domain-specific configuration (3 agents)

### Research Subagents (`subagents/research/`)

**codebase-analyzer**:
- Scans NeoVim config for patterns
- Analyzes plugin configurations
- Identifies optimization opportunities
- Returns: Brief summary + detailed report path

**docs-fetcher**:
- Fetches plugin/API documentation
- Uses cache directory
- Can use gh CLI for GitHub docs
- Returns: Brief summary + cached doc paths

**best-practices-researcher**:
- Researches community patterns
- Finds benchmarks and optimizations
- Analyzes trade-offs
- Returns: Brief summary + recommendations

**dependency-analyzer**:
- Maps plugin dependencies
- Checks version compatibility
- Identifies conflicts
- Returns: Brief summary + dependency graph

**refactor-finder**:
- Finds unused code and plugins
- Identifies duplicate configurations
- Suggests optimizations
- Returns: Brief summary + refactoring opportunities

---

### Implementation Subagents (`subagents/implementation/`)

**code-generator**:
- Creates new Lua modules
- Generates plugin specs
- Follows STANDARDS.md
- Returns: Brief summary + created file paths

**code-modifier**:
- Modifies existing configurations
- Refactors code
- Updates to new APIs
- Returns: Brief summary + modified file paths

---

### Tester Agent (Primary)

**File**: `agent/tester.md`

**Responsibilities**:
- Runs :checkhealth
- Tests plugin functionality
- Validates LSP servers
- Measures performance
- Returns: Test status (PASS/FAIL) + summary

---

### Documenter Agent (Primary)

**File**: `agent/documenter.md`

**Responsibilities**:
- Generates module documentation
- Creates usage examples
- Updates README files
- Returns: Brief summary + updated doc paths

---

### Analysis Subagents (`subagents/analysis/`)

**cruft-finder**:
- Finds unused code and plugins
- Identifies disabled configurations
- Detects orphaned files
- Returns: Cruft report with removal recommendations

**plugin-analyzer**:
- Deep plugin analysis
- Compatibility checking
- Health assessment
- Returns: Plugin analysis report

**performance-profiler**:
- Startup time analysis
- Plugin loading profiling
- Bottleneck identification
- Returns: Performance report with optimizations

---

### Configuration Subagents (`subagents/configuration/`)

**health-checker**:
- :checkhealth interpretation
- Issue categorization by severity
- Actionable fix recommendations
- Returns: Health report with fixes

**keybinding-optimizer**:
- Keybinding organization (which-key vs keymaps)
- Conflict detection
- Layout optimization
- Returns: Keybinding optimization report

**lsp-configurator**:
- LSP setup optimization
- Mason integration
- Custom handler configuration
- Returns: LSP configuration report

---

## Context Management

### Level 1: Single Agent Isolation

```
Orchestrator (minimal context)
    ↓
Primary Agent (routing + summaries only)
    ↓
Subagents (full context, return summaries)
```

**Context Reduction**: 95-96% through metadata passing

### Level 2: Multi-Agent Coordination

```
Orchestrator coordinates sequence:
  Research → return OVERVIEW path
  Plan → return plan path  
  Implement → return completion status
```

Each agent works in isolation with state files for coordination.

---

## State Management

### Global State

**File**: `state/global.json`

Tracks:
- Active projects
- System metrics
- Operation counts
- Last operation dates

### Project State

**File**: `specs/NNN_project/state.json`

Tracks:
- Project status
- Research reports
- Plan versions
- Implementation progress
- Commits

### TODO Tracking

**File**: `specs/TODO.md`

Sections:
- Not Started
- In Progress
- Completed

---

## Data Flow

### Research Flow

```
User → /research "topic"
  ↓
Orchestrator → Researcher Agent
  ↓
Researcher → [Parallel Subagents]
  ↓
Subagents → Return summaries
  ↓
Researcher → Create OVERVIEW.md
  ↓
Researcher → Commit + return path
  ↓
User ← OVERVIEW path
```

### Implementation Flow

```
User → /implement plan_path
  ↓
Orchestrator → Implementer Agent
  ↓
Implementer → Read plan
  ↓
For each wave:
  Implementer → [Parallel Phases]
    ↓
  Phases → Invoke subagents
    ↓
  Subagents → Modify/create files
    ↓
  Tester → Validate changes
    ↓
  Implementer → Commit phase
  ↓
Implementer → Update TODO
  ↓
User ← Completion summary
```

---

## Performance Optimization

### Parallel Execution

- Research: Up to 5 concurrent subagents
- Implementation: Parallel phases within waves
- No blocking on independent operations

### Caching

- Documentation cached in `.opencode/cache/docs/`
- TTL: 7 days
- Speeds up repeated research

### Context Preservation

- Primary agents: Summaries only
- Subagents: Full context for work
- Never pass large content between agents

---

## Error Handling

### Levels

1. **Validation Errors**: Caught before delegation
2. **Delegation Errors**: Logged, reported to user
3. **Partial Success**: Continue with available results
4. **Recovery**: Retry with exponential backoff (max 3 retries)

### Logging

All errors logged to `logs/errors.log` with:
- Timestamp
- Agent name
- Error details
- Recovery actions

---

## Integration Points

### NeoVim Configuration

- Path: `/home/benjamin/.config/nvim/`
- Access: Full read/write
- Operations: Create, modify, test configs

### Git

- Automatic commits per phase
- Conventional commit format
- Complete project history

### External Tools

- lazy.nvim (plugin manager)
- Mason (LSP installer)
- :checkhealth (validation)
- nvim --startuptime (profiling)
- gh CLI (GitHub access)

### Standards

- Path: `/home/benjamin/.config/STANDARDS.md`
- Applied by all code generation/modification
- Enforced through validation

---

## Extensibility

### Adding New Subagents

1. Create subagent file in `agent/subagents/`
2. Define responsibilities and workflow
3. Implement summary return pattern
4. Update primary agent to use it

### Adding New Commands

1. Create command file in `command/`
2. Define command behavior
3. Update orchestrator routing if needed

### Adding New Context

1. Add files to appropriate `context/` subdirectory
2. Reference in relevant agents
3. Keep context files focused and concise

---

## Security Considerations

- No external code execution without validation
- All file operations logged
- Git history provides audit trail
- Automatic testing prevents breaking changes
- Standards compliance enforced

---

## Future Enhancements

Potential improvements:
- Web dashboard for project visualization
- Performance metric tracking over time
- Automated benchmark regression detection
- Machine learning for optimization suggestions
- Integration with more external tools
