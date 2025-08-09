#!/bin/bash

# update-badges.sh - Automatically update README badge counts
# Usage: ./scripts/update-badges.sh

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
README_FILE="$PROJECT_ROOT/README.md"

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to count files in directory
count_files() {
    local dir="$1"
    local pattern="$2"

    if [[ ! -d "$dir" ]]; then
        echo "0"
        return
    fi

    # Count files matching pattern, excluding directories
    find "$dir" -maxdepth 1 -name "$pattern" -type f | wc -l | tr -d ' '
}



# Update badge counts
update_badges() {
    print_status "$YELLOW" "🔍 Counting files..."

    # Count files in each directory
    local agents_count=$(count_files "$PROJECT_ROOT/agents" "*.md")
    local commands_count=$(count_files "$PROJECT_ROOT/commands" "*.md")
    local templates_count=$(count_files "$PROJECT_ROOT/templates" "*.md")
    local hooks_count=$(count_files "$PROJECT_ROOT/hooks" "*.md")

    print_status "$GREEN" "📊 Current counts:"
    print_status "$GREEN" "   Agents: $agents_count"
    print_status "$GREEN" "   Commands: $commands_count"
    print_status "$GREEN" "   Templates: $templates_count"
    print_status "$GREEN" "   Hooks: $hooks_count"

        # Check if README exists
    if [[ ! -f "$README_FILE" ]]; then
        print_status "$RED" "❌ README.md not found at: $README_FILE"
        exit 1
    fi

    # Update badges using sed
    print_status "$YELLOW" "🔄 Updating badges..."

    # Update Agents badge
    if sed -i.tmp "s|\[\!\[Agents\](https://img\.shields\.io/badge/Agents-[0-9]*-blue)\]|\[\!\[Agents\](https://img.shields.io/badge/Agents-${agents_count}-blue)\]|g" "$README_FILE"; then
        print_status "$GREEN" "✅ Updated Agents badge: $agents_count"
    else
        print_status "$RED" "❌ Failed to update Agents badge"
        exit 1
    fi

    # Update Commands badge
    if sed -i.tmp "s|\[\!\[Commands\](https://img\.shields\.io/badge/Commands-[0-9]*-green)\]|\[\!\[Commands\](https://img.shields.io/badge/Commands-${commands_count}-green)\]|g" "$README_FILE"; then
        print_status "$GREEN" "✅ Updated Commands badge: $commands_count"
    else
        print_status "$RED" "❌ Failed to update Commands badge"
        exit 1
    fi

    # Update Templates badge
    if sed -i.tmp "s|\[\!\[Templates\](https://img\.shields\.io/badge/Templates-[0-9]*-purple)\]|\[\!\[Templates\](https://img.shields.io/badge/Templates-${templates_count}-purple)\]|g" "$README_FILE"; then
        print_status "$GREEN" "✅ Updated Templates badge: $templates_count"
    else
        print_status "$RED" "❌ Failed to update Templates badge"
        exit 1
    fi

    # Update Hooks badge
    if sed -i.tmp "s|\[\!\[Hooks\](https://img\.shields\.io/badge/Hooks-[0-9]*-orange)\]|\[\!\[Hooks\](https://img.shields.io/badge/Hooks-${hooks_count}-orange)\]|g" "$README_FILE"; then
        print_status "$GREEN" "✅ Updated Hooks badge: $hooks_count"
    else
        print_status "$RED" "❌ Failed to update Hooks badge"
        exit 1
    fi

    # Clean up temporary file
    rm -f "$README_FILE.tmp"

    print_status "$GREEN" "🎉 Badge counts updated successfully!"
}

# Check for changes
check_changes() {
    if git diff --quiet "$README_FILE" 2>/dev/null; then
        print_status "$YELLOW" "ℹ️  No changes needed - badges are already up to date"
        return 1
    else
        print_status "$GREEN" "📝 Changes detected in README.md"
        return 0
    fi
}

# Main execution
main() {
    print_status "$GREEN" "🚀 Starting badge update process..."

    # Change to project root
    cd "$PROJECT_ROOT"

    # Update badges
    update_badges

    # Check if there were actual changes
    if check_changes; then
        print_status "$GREEN" "✨ README.md has been updated with new badge counts"

        # Show diff if git is available
        if command -v git &> /dev/null; then
            print_status "$YELLOW" "📋 Changes made:"
            git --no-pager diff --no-index /dev/null "$README_FILE" | grep "^+\[\!\[" || true
        fi
    fi
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "Usage: $0 [--help]"
        echo ""
                echo "Automatically updates README badge counts based on file counts in:"
        echo "  - agents/ directory"
        echo "  - commands/ directory"
        echo "  - templates/ directory"
        echo "  - hooks/ directory"
        echo ""
        echo "The script updates badge counts directly without creating backups."
        exit 0
        ;;
    *)
        main "$@"
        ;;
esac
