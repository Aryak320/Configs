# Implementation Workflow

Process for executing implementation plans.

## Steps

1. Read implementation plan
2. Update plan status to [IN PROGRESS]
3. Execute waves sequentially
4. Within each wave, execute phases in parallel
5. Invoke implementation subagents
6. Test after each phase
7. Commit after each phase
8. Update TODO.md on completion

## Subagents Used

- code-generator (new files)
- code-modifier (changes)
- tester (validation)
- documenter (docs)

## Output

- Modified/created files
- Test results
- Git commits (per phase)
- Updated TODO.md
