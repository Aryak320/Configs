# Research Workflow

**Agent**: Researcher
**Trigger**: `/research` command or research request
**Purpose**: Conduct comprehensive research on NeoVim configuration topics

---

## Workflow Steps

### 1. Project Setup

**Actions**:
- Generate semantic project name from research prompt
- Assign next available project number (001-999)
- Create project directory structure
- Initialize state.json

**Directory Created**:
```
.opencode/specs/NNN_project_name/
  reports/
  plans/
  state.json
```

---

### 2. Topic Decomposition

**Actions**:
- Analyze research prompt complexity
- Identify 1-5 distinct research areas
- Create focused research question for each
- Determine appropriate research subagent for each area
- Create placeholder report files

**Subagent Selection**:
- Codebase analysis → codebase-analyzer
- External documentation → docs-fetcher
- Community practices → best-practices-researcher
- Dependencies → dependency-analyzer
- Refactoring → refactor-finder

---

### 3. Parallel Research Execution

**Actions**:
- Invoke 1-5 research subagents concurrently (max 5)
- Pass report file path and research question to each
- Subagents write detailed findings to report files
- Subagents return brief summaries (1-2 paragraphs)
- Collect all summaries without reading full reports

**Context Preservation**:
- Researcher receives only brief summaries
- Full reports remain in files
- 95% context reduction through metadata passing

---

### 4. Synthesis

**Actions**:
- Compile brief summaries from all subagents
- Create OVERVIEW.md in reports/ directory
- Write high-level research summary
- Add links to all detailed reports
- Include metadata (date, subtopics, confidence)
- Provide high-level recommendations

**OVERVIEW.md Format**:
```markdown
# Research Overview: {Project Name}

**Date**: YYYY-MM-DD
**Research Prompt**: {Original prompt}
**Subtopics**: {Count}

## Summary
{High-level synthesis}

## Key Findings
{Bullet points of discoveries}

## Detailed Reports
1. [Topic 1](./report1.md) - {Brief summary}
2. [Topic 2](./report2.md) - {Brief summary}

## Recommendations
{Next steps}

## Metadata
- Confidence: High/Medium/Low
- Sources: {Count}
```

---

### 5. Commit and Finalize

**Actions**:
- Stage all report files and OVERVIEW.md
- Create git commit (conventional format)
- Update project state.json (status: research_complete)
- Update global state.json
- Log completion

**Commit Format**:
```
research: complete {project_name} investigation

- Created {N} research reports
- Analyzed: {key areas}
- Findings: {brief summary}
```

---

### 6. Return Summary

**Actions**:
- Provide user with project path
- Include OVERVIEW.md location
- Summarize key findings
- Suggest next steps (planning)
- Return commit hash

**Output Format**:
```
✅ Research Complete: {Project Name}

Project: .opencode/specs/{NNN_project_name}/
Overview: .opencode/specs/{NNN_project_name}/reports/OVERVIEW.md

Research Summary:
{High-level findings}

Reports Generated ({N}):
1. {Topic} - {Summary}
2. {Topic} - {Summary}

Next Steps:
/plan .opencode/specs/{NNN_project_name}/reports/OVERVIEW.md

Commit: {hash}
```

---

## Error Handling

### Subagent Failure

**Action**:
- Log error to logs/errors.log
- Continue with other subagents (partial success)
- Mark failed subtopic in OVERVIEW.md
- Include error summary in final report
- Retry failed subagent once (2s delay)

### Partial Success

**Action**:
- Proceed with available research
- Clearly mark incomplete sections
- Provide partial OVERVIEW.md
- Note limitations in summary

---

## Success Criteria

- At least 1 research subtopic completed successfully
- OVERVIEW.md created with synthesis
- Project committed to git
- State files updated
- User receives actionable summary

---

## Parallel Execution

- Max 5 concurrent subagents
- No sequential blocking
- Collect results asynchronously
- Continue with partial results if some fail

---

## State Updates

**state.json** updated with:
```json
{
  "status": "research_complete",
  "research": {
    "subtopics": ["topic1", "topic2"],
    "reports": ["reports/topic1.md", "reports/topic2.md"],
    "overview": "reports/OVERVIEW.md",
    "confidence": "high"
  },
  "commits": ["abc123"]
}
```

---

## Time Estimate

- Simple research (1-2 subtopics): 2-5 minutes
- Medium research (3-4 subtopics): 5-10 minutes
- Complex research (5 subtopics): 10-15 minutes

Actual time depends on:
- Codebase size
- Documentation availability
- External resource access
- Network speed
