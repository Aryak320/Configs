#!/bin/bash
# OpenCode Keybinding Validation Test Script
# Tests all custom keybinding configurations for correctness
# Part of Phase 4: Keybinding Validation and Testing

CONFIG_FILE="$HOME/.config/opencode/opencode.json"
PASS_COUNT=0
FAIL_COUNT=0

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test function - checks if pattern exists in config
test_config_exists() {
    local test_name="$1"
    local pattern="$2"
    
    if grep -q "$pattern" "$CONFIG_FILE"; then
        echo -e "${GREEN}✅ PASS${NC}: $test_name"
        ((PASS_COUNT++))
        return 0
    else
        echo -e "${RED}❌ FAIL${NC}: $test_name - Pattern not found: $pattern"
        ((FAIL_COUNT++))
        return 1
    fi
}

# Test function - checks if pattern does NOT exist in config
test_config_not_exists() {
    local test_name="$1"
    local pattern="$2"
    
    if ! grep -q "$pattern" "$CONFIG_FILE"; then
        echo -e "${GREEN}✅ PASS${NC}: $test_name"
        ((PASS_COUNT++))
        return 0
    else
        echo -e "${RED}❌ FAIL${NC}: $test_name - Pattern should not exist: $pattern"
        ((FAIL_COUNT++))
        return 1
    fi
}

# Test function - checks if a key binding contains specific value
test_binding_value() {
    local test_name="$1"
    local key="$2"
    local expected_value="$3"
    
    # Extract the value for the key
    local actual_value=$(grep "\"$key\":" "$CONFIG_FILE" | sed 's/.*: *"\([^"]*\)".*/\1/')
    
    if [ "$actual_value" = "$expected_value" ]; then
        echo -e "${GREEN}✅ PASS${NC}: $test_name"
        ((PASS_COUNT++))
        return 0
    else
        echo -e "${RED}❌ FAIL${NC}: $test_name - Expected: '$expected_value', Got: '$actual_value'"
        ((FAIL_COUNT++))
        return 1
    fi
}

# Test function - checks if a binding does NOT contain a specific substring
test_binding_not_contains() {
    local test_name="$1"
    local key="$2"
    local forbidden_value="$3"
    
    # Extract the value for the key
    local actual_value=$(grep "\"$key\":" "$CONFIG_FILE" | sed 's/.*: *"\([^"]*\)".*/\1/')
    
    if [[ "$actual_value" != *"$forbidden_value"* ]]; then
        echo -e "${GREEN}✅ PASS${NC}: $test_name"
        ((PASS_COUNT++))
        return 0
    else
        echo -e "${RED}❌ FAIL${NC}: $test_name - Value should not contain: '$forbidden_value', Got: '$actual_value'"
        ((FAIL_COUNT++))
        return 1
    fi
}

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}ERROR: Config file not found: $CONFIG_FILE${NC}"
    exit 1
fi

echo "=========================================="
echo "OpenCode Keybinding Validation Tests"
echo "=========================================="
echo "Config file: $CONFIG_FILE"
echo ""

# ==========================================
# TC1: Leader Key Change
# ==========================================
echo -e "${YELLOW}TC1: Leader Key Change${NC}"
test_binding_value "TC1.1: Leader key is ctrl+d" "leader" "ctrl+d"
test_binding_not_contains "TC1.2: input_delete does NOT include ctrl+d" "input_delete" "ctrl+d"
echo ""

# ==========================================
# TC2: Session Navigation
# ==========================================
echo -e "${YELLOW}TC2: Session Navigation${NC}"
test_binding_value "TC2.1: session_child_cycle is <leader>j" "session_child_cycle" "<leader>j"
test_binding_value "TC2.2: session_child_cycle_reverse is <leader>k" "session_child_cycle_reverse" "<leader>k"
echo ""

# ==========================================
# TC3: Message Navigation - Half Page
# ==========================================
echo -e "${YELLOW}TC3: Message Navigation - Half Page${NC}"
test_binding_value "TC3.1: messages_half_page_down is alt+j" "messages_half_page_down" "alt+j"
test_binding_value "TC3.2: messages_half_page_up is alt+k" "messages_half_page_up" "alt+k"
echo ""

# ==========================================
# TC4: Message Navigation - First/Last
# ==========================================
echo -e "${YELLOW}TC4: Message Navigation - First/Last${NC}"
test_binding_value "TC4.1: messages_first is <leader>h" "messages_first" "<leader>h"
test_binding_value "TC4.2: messages_last is <leader>l" "messages_last" "<leader>l"
echo ""

# ==========================================
# TC5: Session List
# ==========================================
echo -e "${YELLOW}TC5: Session List${NC}"
test_binding_value "TC5.1: session_list is <leader>s" "session_list" "<leader>s"
echo ""

# ==========================================
# TC6: Input Newline
# ==========================================
echo -e "${YELLOW}TC6: Input Newline${NC}"
test_binding_not_contains "TC6.1: input_newline does NOT include ctrl+j" "input_newline" "ctrl+j"
test_config_exists "TC6.2: input_newline includes shift+return" '"input_newline": "shift+return,ctrl+return,alt+return"'
echo ""

# ==========================================
# TC7: Input Delete
# ==========================================
echo -e "${YELLOW}TC7: Input Delete${NC}"
test_binding_value "TC7.1: input_delete is delete,shift+delete (no ctrl+d)" "input_delete" "delete,shift+delete"
echo ""

# ==========================================
# TC8: Vim-like Editing
# ==========================================
echo -e "${YELLOW}TC8: Vim-like Editing${NC}"
# Cursor movement
test_config_exists "TC8.1: Cursor left includes alt+h" '"input_move_left": "left,ctrl+b,alt+h"'
test_config_exists "TC8.2: Cursor down includes alt+j" '"input_move_down": "down,alt+j"'
test_config_exists "TC8.3: Cursor up includes alt+k" '"input_move_up": "up,alt+k"'
test_config_exists "TC8.4: Cursor right includes alt+l" '"input_move_right": "right,ctrl+f,alt+l"'

# Word movement
test_config_exists "TC8.5: Word forward includes alt+w" '"input_word_forward": "alt+f,alt+right,ctrl+right,alt+w,alt+e"'
test_config_exists "TC8.6: Word backward includes alt+b" '"input_word_backward": "alt+b,alt+left,ctrl+left"'

# Undo/redo
test_config_exists "TC8.7: Undo binding exists" '"input_undo": "ctrl+-,super+z"'
test_config_exists "TC8.8: Redo binding exists" '"input_redo": "ctrl+.,super+shift+z"'
echo ""

# ==========================================
# TC9: Messages Toggle Conceal
# ==========================================
echo -e "${YELLOW}TC9: Messages Toggle Conceal${NC}"
test_binding_value "TC9.1: messages_toggle_conceal is none" "messages_toggle_conceal" "none"
echo ""

# ==========================================
# TC10: Default Keybindings Preserved
# ==========================================
echo -e "${YELLOW}TC10: Default Keybindings Preserved${NC}"
test_config_exists "TC10.1: ctrl+p for command_list" '"command_list": "ctrl+p"'
test_config_exists "TC10.2: tab for agent_cycle" '"agent_cycle": "tab"'
test_config_exists "TC10.3: escape for session_interrupt" '"session_interrupt": "escape"'
test_config_exists "TC10.4: return for input_submit" '"input_submit": "return"'
echo ""

# ==========================================
# Summary
# ==========================================
echo "=========================================="
echo "Test Results Summary"
echo "=========================================="
echo -e "${GREEN}Passed: $PASS_COUNT${NC}"
echo -e "${RED}Failed: $FAIL_COUNT${NC}"
echo "Total:  $((PASS_COUNT + FAIL_COUNT))"
echo ""

if [ $FAIL_COUNT -eq 0 ]; then
    echo -e "${GREEN}✅ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed. Please review the configuration.${NC}"
    exit 1
fi
