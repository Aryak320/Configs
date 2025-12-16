# Git Integration

Git workflow standards for NeoVim configuration management.

## Commit Standards

- Use conventional commit format
- One commit per phase (implementation)
- One commit per research/plan

## Commit Message Format

```
<type>: <description>

- Detail 1
- Detail 2
```

Types:
- research: Research completion
- plan: Planning completion
- feat: New feature implementation
- refactor: Code refactoring
- perf: Performance improvement
- docs: Documentation update
- fix: Bug fix

## Branching

- Main development in main branch
- Use worktrees for parallel work (optional)

## Automatic Commits

- Researchers commits after research
- Planner commits after planning
- Implementer commits after each phase
