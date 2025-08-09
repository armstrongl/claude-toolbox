#!/bin/bash

# Simple script to add color field to agents
# Usage: ./add-color-simple.sh [agents_directory] [color_list_file]

set -euo pipefail

AGENTS_DIR="${1:-$(pwd)/agents}"
COLOR_LIST_FILE="${2:-}"

# Validate agents directory exists
if [ ! -d "$AGENTS_DIR" ]; then
    echo "Error: Agents directory not found: $AGENTS_DIR"
    echo "Usage: $0 [agents_directory] [color_list_file]"
    exit 1
fi

# Default color palette for random assignment
DEFAULT_COLORS=(
    "blue" "green" "cyan" "purple" "indigo" "orange" "teal" "red"
    "pink" "brown" "navy" "gray" "magenta" "yellow" "lime" "violet"
)

# Function to add color to an agent file
add_color() {
    local agent_file="$1"
    local color="$2"
    local agent_name=$(basename "$agent_file" .md)

    if [ ! -f "$agent_file" ]; then
        echo "File not found: $agent_name"
        return 1
    fi

    # Check if color already exists
    if grep -q "^color:" "$agent_file"; then
        echo "Color already exists in $agent_name"
        return 0
    fi

    # Create temp file
    temp_file=$(mktemp)

    # Read file and add color field after the last known field before the closing ---
    awk -v color="$color" '
        /^---$/ && NR > 1 && !done {
            print "color: " color
            print
            done = 1
            next
        }
        {print}
    ' "$agent_file" > "$temp_file"

    mv "$temp_file" "$agent_file"
    echo "✅ Added color: $color to $agent_name"
}

# Function to get random color from available colors
get_random_color() {
    local used_colors=("$@")
    local available_colors=()

    for color in "${DEFAULT_COLORS[@]}"; do
        if [[ ! " ${used_colors[*]} " =~ " ${color} " ]]; then
            available_colors+=("$color")
        fi
    done

    if [ ${#available_colors[@]} -eq 0 ]; then
        # If all colors used, start reusing from default palette
        echo "${DEFAULT_COLORS[$RANDOM % ${#DEFAULT_COLORS[@]}]}"
    else
        echo "${available_colors[$RANDOM % ${#available_colors[@]}]}"
    fi
}

# Load custom color mappings if file provided
declare -A custom_colors
used_colors=()

if [ -n "$COLOR_LIST_FILE" ] && [ -f "$COLOR_LIST_FILE" ]; then
    echo "Loading custom color mappings from $COLOR_LIST_FILE"
    while IFS='=' read -r agent color; do
        # Skip comments and empty lines
        [[ "$agent" =~ ^#.*$ ]] || [[ -z "$agent" ]] && continue
        custom_colors["$agent"]="$color"
        used_colors+=("$color")
    done < "$COLOR_LIST_FILE"
fi

# Process all agent files
echo "Processing agent files in $AGENTS_DIR..."
total_processed=0
total_updated=0

for agent_file in "$AGENTS_DIR"/*.md; do
    if [ ! -f "$agent_file" ]; then
        continue
    fi

    agent_name=$(basename "$agent_file" .md)
    ((total_processed++))

    # Determine color to use
    if [ -n "${custom_colors[$agent_name]:-}" ]; then
        color="${custom_colors[$agent_name]}"
    else
        color=$(get_random_color "${used_colors[@]}")
        used_colors+=("$color")
    fi

    if add_color "$agent_file" "$color"; then
        ((total_updated++))
    fi
done

echo ""
echo "Color field addition complete!"
echo "Processed: $total_processed agents"
echo "Updated: $total_updated agents"