#!/bin/bash

# Batch add missing fields to all agents in a directory
# Usage: ./batch-add-missing-fields.sh [agents_directory] [update_script_path]

set -euo pipefail

AGENTS_DIR="${1:-$(pwd)/agents}"
UPDATE_SCRIPT="${2:-$(dirname "$0")/update-agent-frontmatter.sh}"

# Validate agents directory exists
if [ ! -d "$AGENTS_DIR" ]; then
    echo "Error: Agents directory not found: $AGENTS_DIR"
    echo "Usage: $0 [agents_directory] [update_script_path]"
    exit 1
fi

# Validate update script exists
if [ ! -f "$UPDATE_SCRIPT" ]; then
    echo "Error: Update script not found: $UPDATE_SCRIPT"
    echo "Usage: $0 [agents_directory] [update_script_path]"
    exit 1
fi

# Dynamically discover all agent files
agents_to_update=()
for agent_file in "$AGENTS_DIR"/*.md; do
    if [ -f "$agent_file" ]; then
        agent_name=$(basename "$agent_file" .md)
        agents_to_update+=("$agent_name")
    fi
done

if [ ${#agents_to_update[@]} -eq 0 ]; then
    echo "No agent files found in $AGENTS_DIR"
    exit 1
fi

echo "Starting batch update of agent frontmatter fields..."
echo "============================================"

success_count=0
fail_count=0

echo "Found ${#agents_to_update[@]} agent files to process"
echo ""

for agent in "${agents_to_update[@]}"; do
    echo -n "Updating $agent... "
    if "$UPDATE_SCRIPT" "$agent" "$AGENTS_DIR" 2>/dev/null; then
        ((success_count++))
    else
        echo "❌ Failed"
        ((fail_count++))
    fi
done

echo ""
echo "============================================"
echo "Batch update complete!"
echo "Successfully updated: $success_count agents"
echo "Failed: $fail_count agents"

if [ $fail_count -gt 0 ]; then
    echo ""
    echo "Some agents failed to update. You may want to check them manually."
    exit 1
fi