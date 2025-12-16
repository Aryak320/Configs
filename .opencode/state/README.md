# State Management

This directory contains global and project-specific state tracking.

---

## Files

- **global.json**: System-wide state and metrics
- Project states are in each project directory: `specs/NNN_project/state.json`

---

## Global State Schema

```json
{
  "system_version": "1.0.0",
  "created": "ISO-8601 timestamp",
  "last_updated": "ISO-8601 timestamp",
  "active_projects": ["001_project_name", "002_another"],
  "total_projects": 2,
  "total_research_count": 5,
  "total_plans_count": 3,
  "total_implementations_count": 2,
  "last_research_date": "ISO-8601 timestamp",
  "last_plan_date": "ISO-8601 timestamp",
  "last_implementation_date": "ISO-8601 timestamp",
  "metrics": {
    "avg_startup_time_ms": 120,
    "total_plugins": 47,
    "total_lsp_servers": 8
  }
}
```

---

## Project State Schema

Located at: `specs/NNN_project/state.json`

```json
{
  "project_id": "001_project_name",
  "status": "research_complete|planning|in_progress|completed",
  "created": "ISO-8601 timestamp",
  "last_updated": "ISO-8601 timestamp",
  "research": {
    "subtopics": ["topic1", "topic2"],
    "reports": ["reports/topic1.md", "reports/topic2.md"],
    "overview": "reports/OVERVIEW.md",
    "confidence": "high|medium|low"
  },
  "plans": [
    {
      "version": "v1",
      "path": "plans/implementation_v1.md",
      "status": "completed|in_progress|not_started",
      "created": "timestamp"
    }
  ],
  "implementation": {
    "current_phase": 3,
    "total_phases": 5,
    "completed_phases": [1, 2],
    "failed_phases": [],
    "blockers": []
  },
  "commits": ["abc123", "def456"]
}
```

---

## State Updates

State is automatically updated by agents:
- **Researcher**: Creates project state, updates research section
- **Planner**: Adds plan to plans array
- **Reviser**: Adds new plan version
- **Implementer**: Updates implementation section, completion status

Manual state updates are also possible for corrections.
