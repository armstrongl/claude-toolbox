#!/bin/bash

# Script to add missing frontmatter fields to agent files
# Usage: ./update-agent-frontmatter.sh <agent-name> [agents_directory]

set -euo pipefail

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Usage: $0 <agent-name> [agents_directory]"
    echo "  agent-name: Name of the agent file (without .md extension)"
    echo "  agents_directory: Directory containing agent files (default: ./agents)"
    exit 1
fi

AGENT_NAME="$1"
AGENTS_DIR="${2:-$(pwd)/agents}"
AGENT_FILE="${AGENTS_DIR}/${AGENT_NAME}.md"

# Validate agents directory exists
if [ ! -d "$AGENTS_DIR" ]; then
    echo "Error: Agents directory not found: $AGENTS_DIR"
    exit 1
fi

if [ ! -f "$AGENT_FILE" ]; then
    echo "Error: Agent file not found: $AGENT_FILE"
    exit 1
fi

# Create a temporary file
TEMP_FILE=$(mktemp)

# Function to check if field exists in frontmatter
has_field() {
    local field="$1"
    awk '/^---$/{i++}i==1' "$AGENT_FILE" | grep -q "^${field}:"
}

# Read the file and process it
in_frontmatter=false
frontmatter_end=false
needs_fields=false

# Default fields to add if missing (can be customized)
declare -A DEFAULT_FIELDS=(
    ["auto-execute"]="false"
    ["thinking-mode"]="ultrathink"
    ["include-context"]="true"
)

# Check which fields are missing
missing_fields=""
for field in "${!DEFAULT_FIELDS[@]}"; do
    if ! has_field "$field"; then
        missing_fields="${missing_fields}${field}: ${DEFAULT_FIELDS[$field]}\n"
        needs_fields=true
    fi
done

if [ "$needs_fields" = false ]; then
    echo "Agent $AGENT_NAME already has all required fields"
    exit 0
fi

# Process the file
while IFS= read -r line; do
    if [ "$line" = "---" ]; then
        if [ "$in_frontmatter" = false ]; then
            echo "$line" >> "$TEMP_FILE"
            in_frontmatter=true
        else
            # End of frontmatter, add missing fields before closing
            echo -e "$missing_fields---" >> "$TEMP_FILE"
            frontmatter_end=true
        fi
    elif [ "$in_frontmatter" = true ] && [ "$frontmatter_end" = false ]; then
        echo "$line" >> "$TEMP_FILE"
    else
        echo "$line" >> "$TEMP_FILE"
    fi
done < "$AGENT_FILE"

# Replace the original file
mv "$TEMP_FILE" "$AGENT_FILE"
echo "✅ Updated $AGENT_NAME with missing fields"