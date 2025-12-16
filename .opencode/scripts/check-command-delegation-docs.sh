#!/bin/bash
# Check command delegation behavior documentation

set -euo pipefail

COMMAND_DIR="/home/benjamin/.config/.opencode/command"
ERRORS=0

echo "=== Checking Command Delegation Documentation ==="
echo ""

# Commands that should have delegation_behavior section
COORDINATOR_COMMANDS=(
    "research.md"
    "implement.md"
    "revise.md"
    "test.md"
    "update-docs.md"
)

# Commands that should have agent_behavior section (specialist)
SPECIALIST_COMMANDS=(
    "plan.md"
)

echo "Checking coordinator commands (must have delegation_behavior section)..."
for command in "${COORDINATOR_COMMANDS[@]}"; do
    command_path="$COMMAND_DIR/$command"
    if [ ! -f "$command_path" ]; then
        echo "  ✗ $command: FILE NOT FOUND"
        ((ERRORS++))
        continue
    fi
    
    # Check for delegation_behavior section
    if grep -q "<delegation_behavior>" "$command_path"; then
        echo "  ✓ $command: has delegation_behavior section"
    else
        echo "  ✗ $command: MISSING delegation_behavior section"
        ((ERRORS++))
    fi
    
    # Check for "How the {Agent} Works" heading
    if grep -q "## How the" "$command_path"; then
        echo "  ✓ $command: has 'How the Agent Works' section"
    else
        echo "  ✗ $command: MISSING 'How the Agent Works' section"
        ((ERRORS++))
    fi
    
    # Check for "What the {Agent} Does" section
    if grep -q "### What the" "$command_path"; then
        echo "  ✓ $command: has 'What the Agent Does' section"
    else
        echo "  ✗ $command: MISSING 'What the Agent Does' section"
        ((ERRORS++))
    fi
    
    # Check for "What the {Agent} Delegates" section
    if grep -q "### What the.*Delegates" "$command_path"; then
        echo "  ✓ $command: has 'What the Agent Delegates' section"
    else
        echo "  ✗ $command: MISSING 'What the Agent Delegates' section"
        ((ERRORS++))
    fi
    
    # Check for "Benefits of Delegation" or "Benefits of Conditional Delegation" section
    if grep -q "### Benefits of.*Delegation" "$command_path"; then
        echo "  ✓ $command: has 'Benefits of Delegation' section"
    else
        echo "  ✗ $command: MISSING 'Benefits of Delegation' section"
        ((ERRORS++))
    fi
    
    # Check for "Example Execution Flow" section
    if grep -q "### Example Execution Flow" "$command_path"; then
        echo "  ✓ $command: has 'Example Execution Flow' section"
    else
        echo "  ✗ $command: MISSING 'Example Execution Flow' section"
        ((ERRORS++))
    fi
    
    echo ""
done

echo "Checking specialist commands (must have agent_behavior section)..."
for command in "${SPECIALIST_COMMANDS[@]}"; do
    command_path="$COMMAND_DIR/$command"
    if [ ! -f "$command_path" ]; then
        echo "  ✗ $command: FILE NOT FOUND"
        ((ERRORS++))
        continue
    fi
    
    # Check for agent_behavior section
    if grep -q "<agent_behavior>" "$command_path"; then
        echo "  ✓ $command: has agent_behavior section"
    else
        echo "  ✗ $command: MISSING agent_behavior section"
        ((ERRORS++))
    fi
    
    # Check for "Why No Delegation?" section
    if grep -q "### Why No Delegation?" "$command_path"; then
        echo "  ✓ $command: has 'Why No Delegation?' section"
    else
        echo "  ✗ $command: MISSING 'Why No Delegation?' section"
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
