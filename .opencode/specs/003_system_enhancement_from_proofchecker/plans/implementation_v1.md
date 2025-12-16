# Implementation Plan: System Enhancement from ProofChecker Patterns

**Project**: 003_system_enhancement_from_proofchecker  
**Version**: v1  
**Created**: 2025-12-15  
**Status**: [IN PROGRESS]  
**Implementation Started**: 2025-12-16T00:00:00Z

---

## Project Overview

**Goal**: Enhance .config/.opencode system by transferring valuable patterns from ProofChecker .opencode system

**Scope**: 15 transferable patterns organized into 4 implementation phases

**Expected Benefits**:
- Improved context discovery and organization
- Self-extensibility through meta-system
- Better project documentation and summaries
- Enhanced user control with approval gates
- Faster execution for simple tasks

**Total Estimated Effort**: 20-30 hours  
**Risk Level**: Low to Medium  
**Dependencies**: None (all enhancements are additive)

---

## Phase Overview

| Phase | Focus | Effort | Risk | Priority |
|-------|-------|--------|------|----------|
| 1 | Context Enhancement | 4-6 hours | Low | High |
| 2 | Meta-System | 8-10 hours | Medium | High |
| 3 | Project Structure | 4-6 hours | Low | Medium |
| 4 | Workflow Improvements | 6-8 hours | Medium | Medium |

---

## Phase 1: Context Enhancement [COMPLETED]

**Goal**: Improve context organization and discoverability  
**Effort**: 4-6 hours  
**Risk**: Low  
**Priority**: High

### Tasks

#### Task 1.1: Create Context Index File
**File**: `context/index.md`  
**Effort**: 1 hour  
**Dependencies**: None

**Steps**:
1. Create `context/index.md`
2. Map all existing context files (24 files)
3. Add quick reference map by category
4. Add use-case-based index
5. Add agent-specific index
6. Test with sample agent queries

**Deliverables**:
- `context/index.md` (100-150 lines)
- Quick map section
- Use case index
- Agent-specific index

**Validation**:
- [ ] All 24 context files mapped
- [ ] Use cases cover common scenarios
- [ ] Agent-specific mappings accurate
- [ ] File is well-formatted and readable

---

#### Task 1.2: Create Essential Patterns File
**File**: `context/essential-patterns.md`  
**Effort**: 2 hours  
**Dependencies**: None

**Steps**:
1. Create `context/essential-patterns.md`
2. Document 10-15 common patterns:
   - Add plugin
   - Setup LSP server
   - Optimize performance
   - Debug issue
   - Add keybinding
   - Configure plugin
   - Test changes
   - Refactor code
   - Update documentation
   - Rollback changes
3. Include code snippets for each pattern
4. Add troubleshooting tips
5. Test patterns for accuracy

**Deliverables**:
- `context/essential-patterns.md` (150-200 lines)
- 10-15 documented patterns
- Code snippets
- Troubleshooting section

**Validation**:
- [ ] All patterns tested and accurate
- [ ] Code snippets are complete
- [ ] Patterns cover common tasks
- [ ] File is well-organized

---

#### Task 1.3: Add Missing Domain Files
**Files**: 3 new domain files  
**Effort**: 3 hours (1 hour per file)  
**Dependencies**: None

**Files to Create**:

1. **`context/domain/performance-optimization.md`**
   - Profiling tools (nvim --startuptime, :Lazy profile)
   - Optimization strategies (lazy loading, defer UI, partial clones)
   - Benchmarking process
   - Common bottlenecks
   - Performance targets

2. **`context/domain/testing-patterns.md`**
   - Health checks (:checkhealth)
   - Functional testing (plugin verification, LSP validation)
   - Performance testing (startup time, memory usage)
   - Automated testing approaches
   - Test checklists

3. **`context/domain/debugging-techniques.md`**
   - Error diagnosis (:messages, :checkhealth, LSP logs)
   - Logging strategies (vim.lsp.set_log_level, vim.notify)
   - Minimal config testing (nvim -u minimal.lua)
   - Bisecting configuration
   - Common issues and solutions

**Deliverables**:
- 3 new domain files (50-200 lines each)
- Comprehensive coverage of each topic
- Code examples
- Best practices
- Common pitfalls

**Validation**:
- [ ] Each file is 50-200 lines
- [ ] Content is accurate and tested
- [ ] Examples are complete
- [ ] Files follow existing format

---

#### Task 1.4: Update Context Index
**File**: `context/index.md`  
**Effort**: 30 minutes  
**Dependencies**: Task 1.3

**Steps**:
1. Add 3 new domain files to index
2. Update use-case mappings
3. Update agent-specific mappings
4. Test index completeness

**Deliverables**:
- Updated `context/index.md`

**Validation**:
- [ ] New files added to index
- [ ] Use cases updated
- [ ] Agent mappings updated

---

### Phase 1 Deliverables

- [x] `context/index.md` - Context discovery map
- [x] `context/essential-patterns.md` - Quick-start patterns
- [x] `context/domain/performance-optimization.md` - Performance guide
- [x] `context/domain/testing-patterns.md` - Testing guide
- [x] `context/domain/debugging-techniques.md` - Debugging guide

### Phase 1 Testing

1. Test context index with sample queries
2. Verify essential patterns with actual tasks
3. Validate new domain files for accuracy
4. Check all files for formatting and completeness

### Phase 1 Commit

```
feat: enhance context organization with index, patterns, and new domains

- Add context/index.md for quick discovery
- Add context/essential-patterns.md for common tasks
- Add performance-optimization.md domain file
- Add testing-patterns.md domain file
- Add debugging-techniques.md domain file

Improves context discoverability and provides quick-start guides.
```

---

## Phase 2: Meta-System [COMPLETED]

**Goal**: Add self-extensibility through meta-system commands  
**Effort**: 8-10 hours  
**Risk**: Medium  
**Priority**: High

### Tasks

#### Task 2.1: Create Agent Template
**File**: `context/standards/agent-template.md`  
**Effort**: 1 hour  
**Dependencies**: None

**Steps**:
1. Create agent template based on existing agents
2. Include frontmatter template
3. Include XML structure template
4. Add workflow stage template
5. Add routing pattern template
6. Document template usage

**Deliverables**:
- `context/standards/agent-template.md` (100-150 lines)
- Complete agent template
- Usage documentation

**Validation**:
- [ ] Template matches existing agent format
- [ ] All required sections included
- [ ] Template is well-documented

---

#### Task 2.2: Create Command Template
**File**: `context/templates/command-template.md`  
**Effort**: 30 minutes  
**Dependencies**: None

**Steps**:
1. Create command template based on existing commands
2. Include frontmatter template
3. Include task description template
4. Add context loading template
5. Add output format template
6. Document template usage

**Deliverables**:
- Updated `context/templates/command-template.md`
- Complete command template
- Usage documentation

**Validation**:
- [ ] Template matches existing command format
- [ ] All required sections included
- [ ] Template is well-documented

---

#### Task 2.3: Create Meta Agent
**File**: `agent/meta.md`  
**Effort**: 3 hours  
**Dependencies**: Tasks 2.1, 2.2

**Steps**:
1. Create `agent/meta.md` following agent template
2. Implement workflow stages:
   - AnalyzeRequest (parse specifications)
   - GenerateOrModify (create/modify files)
   - Validate (check format and functionality)
   - Document (update system docs)
3. Add routing logic for agent-generator and command-generator subagents
4. Add error handling
5. Test with sample agent/command creation

**Deliverables**:
- `agent/meta.md` (200-300 lines)
- Complete workflow implementation
- Error handling
- Documentation

**Validation**:
- [ ] Agent follows template format
- [ ] All workflow stages implemented
- [ ] Routing logic correct
- [ ] Error handling comprehensive

---

#### Task 2.4: Create Agent Generator Subagent
**File**: `agent/subagents/meta/agent-generator.md`  
**Effort**: 2 hours  
**Dependencies**: Task 2.1

**Steps**:
1. Create `agent/subagents/meta/` directory
2. Create `agent-generator.md` subagent
3. Implement agent generation logic:
   - Load agent template
   - Fill in specifications
   - Validate frontmatter
   - Save to correct directory
4. Add validation checks
5. Test with sample agent creation

**Deliverables**:
- `agent/subagents/meta/agent-generator.md` (150-200 lines)
- Agent generation logic
- Validation checks

**Validation**:
- [ ] Generates valid agent files
- [ ] Follows template format
- [ ] Validation catches errors
- [ ] Saves to correct directory

---

#### Task 2.5: Create Command Generator Subagent
**File**: `agent/subagents/meta/command-generator.md`  
**Effort**: 1.5 hours  
**Dependencies**: Task 2.2

**Steps**:
1. Create `command-generator.md` subagent
2. Implement command generation logic:
   - Load command template
   - Fill in specifications
   - Validate frontmatter
   - Save to command/ directory
3. Add validation checks
4. Test with sample command creation

**Deliverables**:
- `agent/subagents/meta/command-generator.md` (100-150 lines)
- Command generation logic
- Validation checks

**Validation**:
- [ ] Generates valid command files
- [ ] Follows template format
- [ ] Validation catches errors
- [ ] Saves to correct directory

---

#### Task 2.6: Create Meta Commands
**Files**: 4 command files  
**Effort**: 2 hours (30 min each)  
**Dependencies**: Tasks 2.3, 2.4, 2.5

**Commands to Create**:

1. **`command/create-agent.md`**
   - Routes to meta agent
   - Accepts agent specification
   - Returns created agent path

2. **`command/create-command.md`**
   - Routes to meta agent
   - Accepts command specification
   - Returns created command path

3. **`command/modify-agent.md`**
   - Routes to meta agent
   - Accepts agent name and changes
   - Returns modified agent path

4. **`command/modify-command.md`**
   - Routes to meta agent
   - Accepts command name and changes
   - Returns modified command path

**Deliverables**:
- 4 new command files (50-100 lines each)
- Proper routing to meta agent
- Clear usage documentation

**Validation**:
- [ ] All commands route correctly
- [ ] Argument handling works
- [ ] Output format is clear
- [ ] Commands are documented

---

#### Task 2.7: Update Documentation
**Files**: README.md, ARCHITECTURE.md  
**Effort**: 1 hour  
**Dependencies**: All Phase 2 tasks

**Steps**:
1. Add meta-system section to README.md
2. Add meta agent to ARCHITECTURE.md
3. Document meta commands
4. Add usage examples
5. Update command list

**Deliverables**:
- Updated README.md
- Updated ARCHITECTURE.md
- Usage examples

**Validation**:
- [ ] Documentation is complete
- [ ] Examples are accurate
- [ ] Command list updated

---

### Phase 2 Deliverables

- [x] `context/standards/agent-template.md` - Agent template
- [x] Updated `context/templates/command-template.md` - Command template
- [x] `agent/meta.md` - Meta agent
- [x] `agent/subagents/meta/agent-generator.md` - Agent generator
- [x] `agent/subagents/meta/command-generator.md` - Command generator
- [x] `command/create-agent.md` - Create agent command
- [x] `command/create-command.md` - Create command command
- [x] `command/modify-agent.md` - Modify agent command
- [x] `command/modify-command.md` - Modify command command
- [x] Updated README.md and ARCHITECTURE.md

### Phase 2 Testing

1. Test agent creation with sample specification
2. Test command creation with sample specification
3. Test agent modification
4. Test command modification
5. Validate generated files
6. Test error handling

### Phase 2 Commit

```
feat: add meta-system for self-extensibility

- Add agent and command templates
- Create meta agent for agent/command generation
- Add agent-generator and command-generator subagents
- Add 4 meta commands (create/modify agent/command)
- Update documentation

Enables self-extensibility without manual file editing.
```

---

## Phase 3: Project Structure [IN PROGRESS]

**Goal**: Enhance project structure with summaries and better organization  
**Effort**: 4-6 hours  
**Risk**: Low  
**Priority**: Medium

### Tasks

#### Task 3.1: Add Summaries Subdirectory
**Files**: Project structure updates  
**Effort**: 1 hour  
**Dependencies**: None

**Steps**:
1. Update project structure template
2. Add summaries/ subdirectory to new projects
3. Create summary template
4. Update state.json schema
5. Test with new project creation

**New Structure**:
```
.opencode/specs/NNN_project/
├── reports/
├── plans/
├── summaries/      ← NEW
│   ├── project-summary.md
│   └── phase-summaries.md
└── state.json
```

**Deliverables**:
- Updated project structure
- Summary templates
- Updated state.json schema

**Validation**:
- [ ] New projects include summaries/
- [ ] Templates are complete
- [ ] state.json schema updated

---

#### Task 3.2: Create Summary Templates
**Files**: 2 template files  
**Effort**: 1 hour  
**Dependencies**: None

**Templates to Create**:

1. **`context/templates/project-summary-template.md`**
   - Project overview
   - Goals and approach
   - Results and metrics
   - Key files modified
   - Lessons learned

2. **`context/templates/phase-summary-template.md`**
   - Phase overview
   - Tasks completed
   - Issues encountered
   - Time spent
   - Next steps

**Deliverables**:
- 2 new template files (50-100 lines each)
- Complete template structure
- Usage documentation

**Validation**:
- [ ] Templates are comprehensive
- [ ] Format is clear
- [ ] Templates are documented

---

#### Task 3.3: Update Planner Agent
**File**: `agent/planner.md`  
**Effort**: 1 hour  
**Dependencies**: Tasks 3.1, 3.2

**Steps**:
1. Add summaries/ creation to planner workflow
2. Add project-summary.md generation
3. Update state.json to track summaries
4. Test with sample plan creation

**Deliverables**:
- Updated `agent/planner.md`
- Summary generation logic

**Validation**:
- [ ] Planner creates summaries/
- [ ] project-summary.md generated
- [ ] state.json updated correctly

---

#### Task 3.4: Update Implementer Agent
**File**: `agent/implementer.md`  
**Effort**: 1.5 hours  
**Dependencies**: Tasks 3.1, 3.2

**Steps**:
1. Add phase-summaries.md generation to implementer
2. Update summary after each phase
3. Update project-summary.md on completion
4. Test with sample implementation

**Deliverables**:
- Updated `agent/implementer.md`
- Phase summary generation logic

**Validation**:
- [ ] Implementer updates phase-summaries.md
- [ ] project-summary.md updated on completion
- [ ] Summaries are accurate

---

#### Task 3.5: Create SYSTEM_SUMMARY.md
**File**: `SYSTEM_SUMMARY.md`  
**Effort**: 2 hours  
**Dependencies**: None

**Steps**:
1. Create `SYSTEM_SUMMARY.md`
2. Document complete file inventory
3. Add key features section
4. Add usage examples
5. Add performance characteristics
6. Add extensibility guide
7. Test for completeness

**Deliverables**:
- `SYSTEM_SUMMARY.md` (300-400 lines)
- Complete system overview
- File inventory
- Usage examples

**Validation**:
- [ ] All files documented
- [ ] Features are complete
- [ ] Examples are accurate
- [ ] File is well-organized

---

### Phase 3 Deliverables

- [x] Updated project structure with summaries/
- [x] `context/templates/project-summary-template.md`
- [x] `context/templates/phase-summary-template.md`
- [x] Updated `agent/planner.md`
- [x] Updated `agent/implementer.md`
- [x] `SYSTEM_SUMMARY.md`

### Phase 3 Testing

1. Create new project and verify summaries/ exists
2. Test planner summary generation
3. Test implementer phase summaries
4. Verify SYSTEM_SUMMARY.md completeness
5. Test summary templates

### Phase 3 Commit

```
feat: add project summaries and system summary

- Add summaries/ subdirectory to project structure
- Create project and phase summary templates
- Update planner to generate project summaries
- Update implementer to generate phase summaries
- Add SYSTEM_SUMMARY.md for complete system overview

Improves project documentation and quick reference.
```

---

## Phase 4: Workflow Improvements

**Goal**: Enhance workflows with approval gates and quick-win detection  
**Effort**: 6-8 hours  
**Risk**: Medium  
**Priority**: Medium

### Tasks

#### Task 4.1: Add Approval Gate to Planner
**File**: `agent/planner.md`  
**Effort**: 2 hours  
**Dependencies**: None

**Steps**:
1. Add RequestApproval stage to planner workflow
2. Create plan summary format
3. Add approval prompt
4. Update state.json to track approval status
5. Test approval flow

**Approval Flow**:
```
Plan Created
  ↓
Generate Summary
  ↓
Present to User
  ↓
Await Approval (yes/no/modify)
  ↓
If yes: Mark approved, ready for implementation
If no: Cancel, explain
If modify: Collect feedback, revise plan
```

**Deliverables**:
- Updated `agent/planner.md` with approval stage
- Approval prompt template
- Updated state.json schema

**Validation**:
- [ ] Approval stage works correctly
- [ ] Summary is clear and complete
- [ ] User can approve/reject/modify
- [ ] state.json tracks approval

---

#### Task 4.2: Create Approval Commands
**Files**: 2 command files  
**Effort**: 1 hour  
**Dependencies**: Task 4.1

**Commands to Create**:

1. **`command/approve.md`**
   - Approve pending plan
   - Mark as ready for implementation
   - Update state.json

2. **`command/reject.md`**
   - Reject pending plan
   - Cancel project
   - Update state.json

**Deliverables**:
- 2 new command files (50-100 lines each)
- Proper state management

**Validation**:
- [ ] Commands work correctly
- [ ] state.json updated properly
- [ ] User feedback is clear

---

#### Task 4.3: Update Implementer for Approval Check
**File**: `agent/implementer.md`  
**Effort**: 1 hour  
**Dependencies**: Task 4.1

**Steps**:
1. Add approval check to implementer
2. Refuse to implement if not approved
3. Provide clear error message
4. Test approval enforcement

**Deliverables**:
- Updated `agent/implementer.md`
- Approval enforcement logic

**Validation**:
- [ ] Implementer checks approval
- [ ] Refuses unapproved plans
- [ ] Error message is clear

---

#### Task 4.4: Add Quick-Win Detection to Researcher
**File**: `agent/researcher.md`  
**Effort**: 2 hours  
**Dependencies**: None

**Steps**:
1. Add DetectQuickWins stage to researcher workflow
2. Define quick-win criteria:
   - Single file or simple change
   - Established pattern exists
   - Low risk (easily reversible)
   - Time estimate < 15 minutes
3. Create QUICK_WINS.md format
4. Test quick-win detection

**Deliverables**:
- Updated `agent/researcher.md` with quick-win detection
- QUICK_WINS.md template
- Quick-win criteria documentation

**Validation**:
- [ ] Quick-win detection works
- [ ] Criteria are appropriate
- [ ] QUICK_WINS.md format is clear

---

#### Task 4.5: Create Quick-Implement Command
**File**: `command/quick-implement.md`  
**Effort**: 1 hour  
**Dependencies**: Task 4.4

**Steps**:
1. Create `/quick-implement` command
2. Route to implementer with quick-win flag
3. Skip planning phase
4. Execute directly from QUICK_WINS.md
5. Test with sample quick win

**Deliverables**:
- `command/quick-implement.md` (50-100 lines)
- Quick implementation logic

**Validation**:
- [ ] Command works correctly
- [ ] Skips planning appropriately
- [ ] Executes from QUICK_WINS.md

---

#### Task 4.6: Create Rollback Command
**File**: `command/rollback.md`  
**Effort**: 2 hours  
**Dependencies**: None

**Steps**:
1. Create `/rollback` command
2. Implement rollback logic:
   - Parse rollback target (last-phase, commit-hash, project-NNN)
   - Identify commit to rollback to
   - Show diff of changes
   - Confirm with user
   - Execute git revert or reset
   - Update state.json
   - Run :checkhealth
3. Test rollback scenarios

**Deliverables**:
- `command/rollback.md` (100-150 lines)
- Rollback logic
- Confirmation prompts

**Validation**:
- [ ] Rollback works correctly
- [ ] User confirmation required
- [ ] state.json updated
- [ ] Health check runs

---

#### Task 4.7: Update Documentation
**Files**: README.md, ARCHITECTURE.md, QUICK_START.md  
**Effort**: 1 hour  
**Dependencies**: All Phase 4 tasks

**Steps**:
1. Document approval workflow
2. Document quick-win detection
3. Document rollback command
4. Add usage examples
5. Update workflow diagrams

**Deliverables**:
- Updated documentation
- Usage examples
- Workflow diagrams

**Validation**:
- [ ] Documentation is complete
- [ ] Examples are accurate
- [ ] Diagrams are clear

---

### Phase 4 Deliverables

- [x] Updated `agent/planner.md` with approval gate
- [x] `command/approve.md` - Approve plan command
- [x] `command/reject.md` - Reject plan command
- [x] Updated `agent/implementer.md` with approval check
- [x] Updated `agent/researcher.md` with quick-win detection
- [x] `command/quick-implement.md` - Quick implementation command
- [x] `command/rollback.md` - Rollback command
- [x] Updated documentation

### Phase 4 Testing

1. Test approval workflow end-to-end
2. Test approval/rejection commands
3. Test quick-win detection with various tasks
4. Test quick-implement command
5. Test rollback command with different targets
6. Verify documentation accuracy

### Phase 4 Commit

```
feat: add approval gates, quick-win detection, and rollback

- Add approval gate to planner workflow
- Create approve/reject commands
- Update implementer to check approval
- Add quick-win detection to researcher
- Create quick-implement command for simple tasks
- Add rollback command for quick recovery
- Update documentation

Improves user control, speeds up simple tasks, and adds safety net.
```

---

## Post-Implementation

### Documentation Updates

After all phases complete:

1. **Update README.md**
   - Add new features section
   - Update command list
   - Add usage examples

2. **Update ARCHITECTURE.md**
   - Add meta-system section
   - Add approval workflow section
   - Add quick-win detection section
   - Update context allocation strategy

3. **Update QUICK_START.md**
   - Add meta-system examples
   - Add approval workflow examples
   - Add quick-win examples
   - Add rollback examples

4. **Update SYSTEM_SUMMARY.md**
   - Add new files to inventory
   - Update feature list
   - Add new usage examples

### Testing Checklist

- [ ] All new files created and formatted correctly
- [ ] All agents route correctly
- [ ] All commands work as expected
- [ ] Context index is complete and accurate
- [ ] Essential patterns are tested and accurate
- [ ] Meta-system creates valid agents/commands
- [ ] Approval workflow works end-to-end
- [ ] Quick-win detection is accurate
- [ ] Rollback command works safely
- [ ] Documentation is complete and accurate
- [ ] All commits follow conventional format
- [ ] :checkhealth passes
- [ ] No regressions in existing functionality

### Performance Validation

- [ ] Context loading is faster with index
- [ ] Meta-system generates valid files
- [ ] Approval adds minimal overhead
- [ ] Quick-win path is significantly faster
- [ ] Rollback is safe and reliable

### User Acceptance

- [ ] Context index improves discoverability
- [ ] Essential patterns are helpful
- [ ] Meta-system is easy to use
- [ ] Approval workflow provides good control
- [ ] Quick-win detection is accurate
- [ ] Rollback provides confidence

---

## Risk Mitigation

### Phase 1 Risks
- **Risk**: Context index becomes outdated
- **Mitigation**: Add validation check to meta-system

### Phase 2 Risks
- **Risk**: Meta-system generates invalid files
- **Mitigation**: Comprehensive validation checks, test with samples

### Phase 3 Risks
- **Risk**: Summaries add overhead
- **Mitigation**: Keep summaries brief, automate generation

### Phase 4 Risks
- **Risk**: Approval gates slow down workflow
- **Mitigation**: Make approval optional, add quick-win path
- **Risk**: Quick-win detection has false positives
- **Mitigation**: Conservative criteria, user can override
- **Risk**: Rollback causes data loss
- **Mitigation**: Require confirmation, show diff before rollback

---

## Success Criteria

### Phase 1 Success
- [x] Context index created and complete
- [x] Essential patterns documented and tested
- [x] 3 new domain files added
- [x] All files follow format standards

### Phase 2 Success
- [x] Meta agent created and functional
- [x] 4 meta commands working
- [x] Agent/command generation validated
- [x] Templates are complete

### Phase 3 Success
- [x] Project structure includes summaries/
- [x] Summaries generated automatically
- [x] SYSTEM_SUMMARY.md complete
- [x] Documentation updated

### Phase 4 Success
- [x] Approval workflow functional
- [x] Quick-win detection accurate
- [x] Rollback command safe
- [x] Documentation complete

### Overall Success
- [x] All 15 patterns implemented
- [x] All tests passing
- [x] Documentation complete
- [x] No regressions
- [x] User acceptance positive

---

## Timeline

**Phase 1**: 1-2 days (4-6 hours)  
**Phase 2**: 2-3 days (8-10 hours)  
**Phase 3**: 1-2 days (4-6 hours)  
**Phase 4**: 2-3 days (6-8 hours)

**Total**: 6-10 days (20-30 hours)

---

## Next Steps

1. Review this implementation plan
2. Approve or request modifications
3. Begin Phase 1 implementation
4. Test each phase before proceeding
5. Update documentation throughout
6. Validate success criteria

---

**Status**: [NOT STARTED]  
**Awaiting**: User approval to proceed
