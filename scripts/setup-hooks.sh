#!/bin/bash

# setup-hooks.sh - Configure Git hooks for automatic badge updates
# Usage: ./scripts/setup-hooks.sh

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Setup Git hooks
setup_hooks() {
    print_status "$YELLOW" "🔧 Setting up Git hooks..."

    cd "$PROJECT_ROOT"

    # Check if we're in a Git repository
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        print_status "$RED" "❌ Not in a Git repository. Please run 'git init' first."
        exit 1
    fi

    # Configure Git to use custom hooks directory
    if git config core.hooksPath .githooks; then
        print_status "$GREEN" "✅ Configured Git to use .githooks directory"
    else
        print_status "$RED" "❌ Failed to configure Git hooks directory"
        exit 1
    fi

    # Ensure hook is executable
    if [[ -f ".githooks/pre-commit" ]]; then
        chmod +x .githooks/pre-commit
        print_status "$GREEN" "✅ Made pre-commit hook executable"
    else
        print_status "$RED" "❌ Pre-commit hook not found at .githooks/pre-commit"
        exit 1
    fi

    print_status "$GREEN" "🎉 Git hooks configured successfully!"
    print_status "$YELLOW" "ℹ️  The pre-commit hook will now automatically update README badges"
    print_status "$YELLOW" "ℹ️  when you add or remove .md files in agents/, commands/, or templates/"
}

# Test the setup
test_setup() {
    print_status "$YELLOW" "🧪 Testing badge update script..."

    local badge_script="$PROJECT_ROOT/scripts/update-badges.sh"

    if [[ ! -f "$badge_script" ]]; then
        print_status "$RED" "❌ Badge update script not found at: $badge_script"
        exit 1
    fi

    if [[ ! -x "$badge_script" ]]; then
        print_status "$RED" "❌ Badge update script is not executable"
        exit 1
    fi

    # Run a dry test
    if "$badge_script" >/dev/null 2>&1; then
        print_status "$GREEN" "✅ Badge update script works correctly"
    else
        print_status "$RED" "❌ Badge update script failed during test"
        exit 1
    fi
}

# Main execution
main() {
    print_status "$GREEN" "🚀 Setting up automatic badge updates..."

    setup_hooks
    test_setup

    print_status "$GREEN" "✨ Setup complete!"
    print_status "$YELLOW" ""
    print_status "$YELLOW" "Next steps:"
    print_status "$YELLOW" "1. Run './scripts/update-badges.sh' to update badges manually"
    print_status "$YELLOW" "2. Badge counts will auto-update on commits when files change"
    print_status "$YELLOW" "3. To disable: git config --unset core.hooksPath"
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "Usage: $0 [--help]"
        echo ""
        echo "Sets up Git hooks to automatically update README badge counts."
        echo ""
        echo "This configures:"
        echo "  - Git to use .githooks directory"
        echo "  - Pre-commit hook to update badges when .md files change"
        echo "  - Proper permissions on hook files"
        exit 0
        ;;
    *)
        main "$@"
        ;;
esac
