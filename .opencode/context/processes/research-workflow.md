# Research Workflow

Process for conducting research on NeoVim configuration topics.

## Steps

1. Receive research prompt
2. Generate project name and ID
3. Decompose into 1-5 subtopics
4. Invoke research subagents in parallel (max 5)
5. Collect summaries
6. Synthesize OVERVIEW.md
7. Commit to git

## Subagents Used

- codebase-analyzer
- docs-fetcher
- best-practices-researcher
- dependency-analyzer
- refactor-finder

## Output

- Project directory: `.opencode/specs/NNN_project_name/`
- OVERVIEW.md with research synthesis
- Individual research reports
- Git commit
