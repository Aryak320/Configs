mkdir -p workflows && cd workflows && \
cat > research-workflow.md << 'EOF5' && cat > planning-workflow.md << 'EOF6' && cat > revision-workflow.md << 'EOF7' && cat > implementation-workflow.md << 'EOF8' && \
echo "Created 4 template files and 4 workflow files"
# Research Report Template

Template for research subagent reports.

```markdown
# {Report Title}: {Topic}

**Research Question**: {Question}
**Date**: YYYY-MM-DD
**Subagent**: {Subagent Name}

## Overview

{High-level summary of findings}

## Key Findings

1. {Finding 1}
2. {Finding 2}
3. {Finding 3}

## Detailed Analysis

### {Section 1}

{Detailed content}

**Files**: {file:line references}

### {Section 2}

{Detailed content}

## Recommendations

1. {Recommendation 1}
2. {Recommendation 2}

## References

- {Source 1}
- {Source 2}
```
