#!/bin/bash

# Enhanced script to validate and fix agent files
# Usage: ./batch-update-agents.sh [agents_directory] [--fix]

set -euo pipefail

# Parse arguments
AGENTS_DIR=""
FIX_MODE=false

# Process all arguments
for arg in "$@"; do
    if [ "$arg" = "--fix" ]; then
        FIX_MODE=true
    elif [ -z "$AGENTS_DIR" ] && [ "$arg" != "--fix" ]; then
        AGENTS_DIR="$arg"
    fi
done

# Default to current directory's agents/ folder if no directory provided
if [ -z "$AGENTS_DIR" ]; then
    AGENTS_DIR="$(pwd)/agents"
fi

# Validate agents directory exists
if [ ! -d "$AGENTS_DIR" ]; then
    echo "Error: Agents directory not found: $AGENTS_DIR"
    echo "Usage: $0 [agents_directory] [--fix]"
    exit 1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
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
    awk '/^---$/{i++; if(i==2) exit} i==1 && i!=0' "$file" | grep -q "^${field}:"
}

# Function to get field value from frontmatter
get_field_value() {
    local file="$1"
    local field="$2"

    if ! has_frontmatter "$file"; then
        return 1
    fi

    # Extract frontmatter section and get field value
    awk "/^---$/{i++; if(i==2) exit} i==1 && /^${field}:/ {sub(/^${field}:[[:space:]]*/, \"\"); print}" "$file"
}

# Function to get agent name from filename
get_agent_name() {
    local file="$1"
    basename "$file" .md
}

# Function to validate model field
validate_model() {
    local model="$1"
    case "$model" in
        opus|sonnet|haiku)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Function to validate color field
validate_color() {
    local color="$1"
    case "$color" in
        red|blue|green|yellow|magenta|cyan)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Function to check if description contains "MUST USE" or "MUST BE USED"
has_must_use() {
    local description="$1"
    echo "$description" | grep -qi "MUST.*USE"
}

# Function to fix frontmatter issues
fix_frontmatter() {
    local file="$1"
    local temp_file="${file}.tmp"
    local agent_name=$(get_agent_name "$file")

    # Read the entire file
    local content=$(cat "$file")

    # Extract frontmatter and body
    local frontmatter_content=""
    local body_content=""
    local in_frontmatter=false
    local frontmatter_end_found=false

    while IFS= read -r line; do
        if [ "$line" = "---" ]; then
            if [ "$in_frontmatter" = false ]; then
                in_frontmatter=true
                continue
            else
                frontmatter_end_found=true
                in_frontmatter=false
                continue
            fi
        fi

        if [ "$in_frontmatter" = true ]; then
            frontmatter_content="${frontmatter_content}${line}\n"
        elif [ "$frontmatter_end_found" = true ]; then
            body_content="${body_content}${line}\n"
        fi
    done < "$file"

    # Parse existing frontmatter fields
    local name=""
    local description=""
    local model=""
    local color=""

    if [ -n "$frontmatter_content" ]; then
        name=$(echo -e "$frontmatter_content" | grep "^name:" | sed 's/^name:[[:space:]]*//' || echo "")
        description=$(echo -e "$frontmatter_content" | grep "^description:" | sed 's/^description:[[:space:]]*//' || echo "")
        model=$(echo -e "$frontmatter_content" | grep "^model:" | sed 's/^model:[[:space:]]*//' || echo "")
        color=$(echo -e "$frontmatter_content" | grep "^color:" | sed 's/^color:[[:space:]]*//' || echo "")
    fi

    # Set defaults if fields are missing
    if [ -z "$name" ]; then
        name="$agent_name"
    fi

    if [ -z "$description" ]; then
        description="Use this agent when working with $agent_name. MUST BE USED for specialized tasks requiring expert knowledge in this domain."
    elif ! has_must_use "$description"; then
        # Add MUST BE USED to existing description if not present
        if echo "$description" | grep -qi "USE PROACTIVELY"; then
            description=$(echo "$description" | sed 's/USE PROACTIVELY/MUST BE USED. USE PROACTIVELY/')
        else
            description="MUST BE USED when appropriate. $description"
        fi
    fi

    if [ -z "$model" ] || ! validate_model "$model"; then
        model="sonnet"
    fi

    if [ -z "$color" ] || ! validate_color "$color"; then
        color="blue"
    fi

    # Write the corrected file
    {
        echo "---"
        echo "name: $name"
        echo "description: $description"
        echo "model: $model"
        echo "color: $color"
        echo "---"
        echo ""
        echo -e "$body_content"
    } > "$temp_file"

    # Replace original file
    mv "$temp_file" "$file"
}

# Function to fix list items to end with periods
fix_list_periods() {
    local file="$1"
    local temp_file="${file}.tmp"

    # Process the file line by line
    while IFS= read -r line; do
        # Check if line is a list item (starts with - and has content)
        if [[ "$line" =~ ^[[:space:]]*-[[:space:]]+.+ ]]; then
            # Remove trailing whitespace
            line=$(echo "$line" | sed 's/[[:space:]]*$//')
            # Add period if it doesn't end with punctuation
            if [[ ! "$line" =~ [.!?:]$ ]]; then
                line="${line}."
            fi
        fi
        echo "$line"
    done < "$file" > "$temp_file"

    # Replace original file
    mv "$temp_file" "$file"
}

# Arrays to track different categories
declare -a missing_name
declare -a missing_description
declare -a missing_model
declare -a missing_color
declare -a invalid_model
declare -a invalid_color
declare -a frontmatter_line_breaks
declare -a missing_must_use
declare -a missing_list_periods
declare -a compliant_agents

echo "======================================"
echo "Enhanced Agent Files Validation Report"
echo "======================================"
echo ""

if [ "$FIX_MODE" = true ]; then
    echo -e "${BLUE}Running in FIX mode - issues will be automatically corrected${NC}"
    echo ""
fi

total_agents=0
issues_found_total=0

for agent_file in "$AGENTS_DIR"/*.md; do
    if [ ! -f "$agent_file" ]; then
        continue
    fi

    agent_name=$(get_agent_name "$agent_file")
    ((total_agents++))

    local_issues_found=false

    # Check for required frontmatter fields
    if ! has_field "$agent_file" "name"; then
        missing_name+=("$agent_name")
        local_issues_found=true
    fi

    if ! has_field "$agent_file" "description"; then
        missing_description+=("$agent_name")
        local_issues_found=true
    else
        # Check if description contains MUST USE
        description=$(get_field_value "$agent_file" "description")
        if ! has_must_use "$description"; then
            missing_must_use+=("$agent_name")
            local_issues_found=true
        fi
    fi

    if ! has_field "$agent_file" "model"; then
        missing_model+=("$agent_name")
        local_issues_found=true
    else
        model=$(get_field_value "$agent_file" "model")
        if ! validate_model "$model"; then
            invalid_model+=("$agent_name")
            local_issues_found=true
        fi
    fi

    if ! has_field "$agent_file" "color"; then
        missing_color+=("$agent_name")
        local_issues_found=true
    else
        color=$(get_field_value "$agent_file" "color")
        if ! validate_color "$color"; then
            invalid_color+=("$agent_name")
            local_issues_found=true
        fi
    fi

    # Check for line breaks in frontmatter
    if has_frontmatter "$agent_file"; then
        frontmatter_lines=$(awk '/^---$/{i++; if(i==2) exit} i==1 && i!=0' "$agent_file")
        if echo "$frontmatter_lines" | grep -q "^[[:space:]]*$"; then
            frontmatter_line_breaks+=("$agent_name")
            local_issues_found=true
        fi
    fi

    # Check for list items without periods
    if grep -q "^[[:space:]]*-[[:space:]]\+.*[^.!?:]$" "$agent_file"; then
        missing_list_periods+=("$agent_name")
        local_issues_found=true
    fi

    # Apply fixes if in fix mode
    if [ "$FIX_MODE" = true ] && [ "$local_issues_found" = true ]; then
        echo -e "${YELLOW}Fixing issues in: $agent_name${NC}"
        fix_frontmatter "$agent_file"
        fix_list_periods "$agent_file"
        ((issues_found_total++))
    elif [ "$local_issues_found" = false ]; then
        compliant_agents+=("$agent_name")
    else
        ((issues_found_total++))
    fi
done

if [ "$FIX_MODE" = true ]; then
    echo -e "${GREEN}✅ Fixed issues in $issues_found_total agent(s)${NC}"
    echo -e "${GREEN}✅ Compliant agents: ${#compliant_agents[@]}/$total_agents${NC}"
else
    echo -e "${GREEN}✅ Fully Compliant Agents: ${#compliant_agents[@]}/$total_agents${NC}"
fi
echo ""

# Report findings (only if not in fix mode)
if [ "$FIX_MODE" = false ]; then
    if [ ${#missing_name[@]} -gt 0 ]; then
        echo -e "${RED}❌ Missing name field (${#missing_name[@]} agents):${NC}"
        printf '%s\n' "${missing_name[@]}" | column -c 80
        echo ""
    fi

    if [ ${#missing_description[@]} -gt 0 ]; then
        echo -e "${RED}❌ Missing description field (${#missing_description[@]} agents):${NC}"
        printf '%s\n' "${missing_description[@]}" | column -c 80
        echo ""
    fi

    if [ ${#missing_model[@]} -gt 0 ]; then
        echo -e "${RED}❌ Missing model field (${#missing_model[@]} agents):${NC}"
        printf '%s\n' "${missing_model[@]}" | column -c 80
        echo ""
    fi

    if [ ${#missing_color[@]} -gt 0 ]; then
        echo -e "${RED}❌ Missing color field (${#missing_color[@]} agents):${NC}"
        printf '%s\n' "${missing_color[@]}" | column -c 80
        echo ""
    fi

    if [ ${#invalid_model[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️  Invalid model field (${#invalid_model[@]} agents):${NC}"
        printf '%s\n' "${invalid_model[@]}" | column -c 80
        echo "    Valid values: opus, sonnet, haiku"
        echo ""
    fi

    if [ ${#invalid_color[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️  Invalid color field (${#invalid_color[@]} agents):${NC}"
        printf '%s\n' "${invalid_color[@]}" | column -c 80
        echo "    Valid values: red, blue, green, yellow, magenta, cyan"
        echo ""
    fi

    if [ ${#frontmatter_line_breaks[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️  Frontmatter has line breaks (${#frontmatter_line_breaks[@]} agents):${NC}"
        printf '%s\n' "${frontmatter_line_breaks[@]}" | column -c 80
        echo ""
    fi

    if [ ${#missing_must_use[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️  Description missing 'MUST USE' (${#missing_must_use[@]} agents):${NC}"
        printf '%s\n' "${missing_must_use[@]}" | column -c 80
        echo ""
    fi

    if [ ${#missing_list_periods[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️  List items missing periods (${#missing_list_periods[@]} agents):${NC}"
        printf '%s\n' "${missing_list_periods[@]}" | column -c 80
        echo ""
    fi

    echo "======================================"
    echo "Run with --fix flag to automatically correct these issues"
fi

echo "======================================"
echo "Summary:"
echo "  Total agents: $total_agents"
echo "  Fully compliant: ${#compliant_agents[@]}"
if [ "$FIX_MODE" = false ]; then
    echo "  Needing updates: $issues_found_total"
else
    echo "  Fixed in this run: $issues_found_total"
fi
echo "======================================"