#!/bin/bash
# Check task tool usage in coordinator agents

set -euo pipefail

AGENT_DIR="/home/benjamin/.config/.opencode/agent"
ERRORS=0

echo "=== Checking Task Tool Usage in Coordinator Agents ==="
echo ""

# Coordinator agents that MUST have task: true
COORDINATOR_AGENTS=(
    "researcher.md"
    "implementer.md"
    "tester.md"
    "documenter.md"
)

# Specialist agents that MUST have task: false
SPECIALIST_AGENTS=(
    "planner.md"
)

# Conditional agents that MUST have task: true
CONDITIONAL_AGENTS=(
    "reviser.md"
)

echo "Checking coordinator agents (must have task: true)..."
for agent in "${COORDINATOR_AGENTS[@]}"; do
    agent_path="$AGENT_DIR/$agent"
    if [ ! -f "$agent_path" ]; then
        echo "  ✗ $agent: FILE NOT FOUND"
        ((ERRORS++))
        continue
    fi
    
    # Check if task: true in frontmatter
    if grep -q "task: true" "$agent_path"; then
        echo "  ✓ $agent: task tool enabled"
    else
        echo "  ✗ $agent: task tool NOT enabled (must be 'task: true')"
        ((ERRORS++))
    fi
    
    # Check for critical_instructions section
    if grep -q "<critical_instructions" "$agent_path"; then
        echo "  ✓ $agent: has critical_instructions section"
    else
        echo "  ✗ $agent: MISSING critical_instructions section"
        ((ERRORS++))
    fi
    
    # Check for tool_usage section
    if grep -q "<tool_usage>" "$agent_path"; then
        echo "  ✓ $agent: has tool_usage section"
    else
        echo "  ✗ $agent: MISSING tool_usage section"
        ((ERRORS++))
    fi
    
    # Check for delegation_examples section
    if grep -q "<delegation_examples>" "$agent_path"; then
        echo "  ✓ $agent: has delegation_examples section"
    else
        echo "  ✗ $agent: MISSING delegation_examples section"
        ((ERRORS++))
    fi
    
    # Check for task() invocations in examples
    task_count=$(grep -c "task(" "$agent_path" || echo "0")
    if [ "$task_count" -ge 3 ]; then
        echo "  ✓ $agent: has $task_count task() invocations (≥3)"
    else
        echo "  ✗ $agent: only $task_count task() invocations (need ≥3)"
        ((ERRORS++))
    fi
    
    echo ""
done

echo "Checking specialist agents (must have task: false)..."
for agent in "${SPECIALIST_AGENTS[@]}"; do
    agent_path="$AGENT_DIR/$agent"
    if [ ! -f "$agent_path" ]; then
        echo "  ✗ $agent: FILE NOT FOUND"
        ((ERRORS++))
        continue
    fi
    
    # Check if task: false in frontmatter
    if grep -q "task: false" "$agent_path"; then
        echo "  ✓ $agent: task tool disabled (specialist)"
    else
        echo "  ✗ $agent: task tool NOT disabled (must be 'task: false')"
        ((ERRORS++))
    fi
    
    # Check for agent_classification section
    if grep -q "<agent_classification>" "$agent_path"; then
        echo "  ✓ $agent: has agent_classification section"
    else
        echo "  ✗ $agent: MISSING agent_classification section"
        ((ERRORS++))
    fi
    
    echo ""
done

echo "Checking conditional agents (must have task: true)..."
for agent in "${CONDITIONAL_AGENTS[@]}"; do
    agent_path="$AGENT_DIR/$agent"
    if [ ! -f "$agent_path" ]; then
        echo "  ✗ $agent: FILE NOT FOUND"
        ((ERRORS++))
        continue
    fi
    
    # Check if task: true in frontmatter
    if grep -q "task: true" "$agent_path"; then
        echo "  ✓ $agent: task tool enabled"
    else
        echo "  ✗ $agent: task tool NOT enabled (must be 'task: true')"
        ((ERRORS++))
    fi
    
    # Check for conditional_delegation in instructions
    if grep -q "conditional_delegation" "$agent_path"; then
        echo "  ✓ $agent: has conditional_delegation pattern"
    else
        echo "  ✗ $agent: MISSING conditional_delegation pattern"
        ((ERRORS++))
    fi
    
    echo ""
done

echo "=== Summary ==="
if [ $ERRORS -eq 0 ]; then
    echo "✓ All checks passed!"
    exit 0
else
    echo "✗ $ERRORS error(s) found"
    exit 1
fi
