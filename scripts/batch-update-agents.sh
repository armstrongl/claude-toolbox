#!/bin/bash

# Script to analyze and help batch update agent files
# Usage: ./batch-update-agents.sh [agents_directory]

set -euo pipefail

# Default to current directory's agents/ folder if no argument provided
AGENTS_DIR="${1:-$(pwd)/agents}"

# Validate agents directory exists
if [ ! -d "$AGENTS_DIR" ]; then
    echo "Error: Agents directory not found: $AGENTS_DIR"
    echo "Usage: $0 [agents_directory]"
    exit 1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a file has frontmatter
has_frontmatter() {
    local file="$1"
    head -n 1 "$file" | grep -q "^---$"
}

# Function to check if frontmatter has a specific field
has_field() {
    local file="$1"
    local field="$2"

    if ! has_frontmatter "$file"; then
        return 1
    fi

    # Extract frontmatter section and check for field
    awk '/^---$/{i++}i==1' "$file" | grep -q "^${field}:"
}

# Function to get agent name from filename
get_agent_name() {
    local file="$1"
    basename "$file" .md
}

# Arrays to track different categories
declare -a needs_auto_execute
declare -a needs_thinking_mode
declare -a needs_include_context
declare -a has_kebab_heading
declare -a needs_description_enhancement

echo "======================================"
echo "Agent Files Analysis Report"
echo "======================================"
echo ""

total_agents=0
compliant_agents=0

for agent_file in "$AGENTS_DIR"/*.md; do
    if [ ! -f "$agent_file" ]; then
        continue
    fi

    agent_name=$(get_agent_name "$agent_file")
    ((total_agents++))

    issues_found=false

    # Check for missing auto-execute field
    if ! has_field "$agent_file" "auto-execute"; then
        needs_auto_execute+=("$agent_name")
        issues_found=true
    fi

    # Check for missing thinking-mode field
    if ! has_field "$agent_file" "thinking-mode"; then
        needs_thinking_mode+=("$agent_name")
        issues_found=true
    fi

    # Check for missing include-context field
    if ! has_field "$agent_file" "include-context"; then
        needs_include_context+=("$agent_name")
        issues_found=true
    fi

    # Check for kebab-case heading
    if grep -q "^# ${agent_name}$" "$agent_file" 2>/dev/null; then
        has_kebab_heading+=("$agent_name")
        issues_found=true
    fi

    # Check if description needs enhancement (brief descriptions without examples)
    if has_field "$agent_file" "description"; then
        # Extract description and check if it contains examples
        description=$(awk '/^description:/{flag=1} /^[a-z-]+:/{if(flag==1)exit} flag' "$agent_file")
        if ! echo "$description" | grep -q "Examples:" && ! echo "$description" | grep -q "<example>"; then
            # Only flag if description is brief (less than 200 chars)
            desc_length=$(echo "$description" | wc -c | tr -d ' ')
            if [ "$desc_length" -lt 400 ]; then
                needs_description_enhancement+=("$agent_name")
                issues_found=true
            fi
        fi
    fi

    if [ "$issues_found" = false ]; then
        ((compliant_agents++))
    fi
done

echo -e "${GREEN}✅ Fully Compliant Agents:${NC} $compliant_agents/$total_agents"
echo ""

# Report findings
if [ ${#needs_auto_execute[@]} -gt 0 ]; then
    echo -e "${YELLOW}📝 Missing auto-execute field (${#needs_auto_execute[@]} agents):${NC}"
    printf '%s\n' "${needs_auto_execute[@]}" | column -c 80
    echo ""
fi

if [ ${#needs_thinking_mode[@]} -gt 0 ]; then
    echo -e "${YELLOW}📝 Missing thinking-mode field (${#needs_thinking_mode[@]} agents):${NC}"
    printf '%s\n' "${needs_thinking_mode[@]}" | column -c 80
    echo ""
fi

if [ ${#needs_include_context[@]} -gt 0 ]; then
    echo -e "${YELLOW}📝 Missing include-context field (${#needs_include_context[@]} agents):${NC}"
    printf '%s\n' "${needs_include_context[@]}" | column -c 80
    echo ""
fi

if [ ${#has_kebab_heading[@]} -gt 0 ]; then
    echo -e "${RED}⚠️  Has kebab-case heading to remove (${#has_kebab_heading[@]} agents):${NC}"
    printf '%s\n' "${has_kebab_heading[@]}"
    echo ""
fi

if [ ${#needs_description_enhancement[@]} -gt 0 ]; then
    echo -e "${YELLOW}💡 Brief descriptions needing examples (${#needs_description_enhancement[@]} agents):${NC}"
    printf '%s\n' "${needs_description_enhancement[@]}" | column -c 80
    echo ""
fi

echo "======================================"
echo "Summary:"
echo "  Total agents: $total_agents"
echo "  Fully compliant: $compliant_agents"
echo "  Needing updates: $((total_agents - compliant_agents))"
echo "======================================"