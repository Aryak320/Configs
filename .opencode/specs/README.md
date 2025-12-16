# Specs Directory

This directory contains all NeoVim configuration projects managed by the research-driven development system.

---

## Structure

```
specs/
  TODO.md                          # Project tracking
  001_project_name/                # Project directory
    reports/                       # Research reports
      OVERVIEW.md                  # Research synthesis
      codebase_analysis.md         # Detailed reports
      docs_research.md
      ...
    plans/                         # Implementation plans
      implementation_v1.md         # Plan versions
      implementation_v2.md
    state.json                     # Project state tracking
  002_another_project/
    ...
  archive/                         # Completed and archived projects
    050_old_project/
    ...
```

---

## Project Numbering

- Projects are numbered 001-999
- Numbers are assigned sequentially
- Once a project reaches 999, older projects should be archived

---

## Project Lifecycle

1. **Research**: Researcher creates project and generates reports
2. **Planning**: Planner creates implementation_v1.md
3. **Revision** (optional): Reviser creates implementation_v2.md, v3.md, etc.
4. **Implementation**: Implementer executes plan phases
5. **Completion**: Project marked complete in TODO.md
6. **Archive** (optional): Move to archive/ directory

---

## Archiving

Use the `/empty-archive` command to clean up old archived projects.

Archiving criteria:
- Project is completed
- Configuration is stable
- No longer need detailed history
- Free up project numbers
