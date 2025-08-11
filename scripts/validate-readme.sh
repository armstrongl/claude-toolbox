#!/bin/bash

# Standalone script to validate README.md content
# Ensures README tables accurately reflect repository structure

echo "🔍 Validating README.md content..."

# Get the repository root (or current directory if not in git repo)
if git rev-parse --git-dir > /dev/null 2>&1; then
    REPO_ROOT=$(git rev-parse --show-toplevel)
else
    REPO_ROOT="."
fi

README_FILE="$REPO_ROOT/README.md"

# Check if README.md exists
if [ ! -f "$README_FILE" ]; then
    echo "❌ README.md not found"
    exit 1
fi

# Function to extract table content from README
extract_table_content() {
    local section_name="$1"
    local start_marker="$2"
    local end_marker="$3"

    # Extract content between markers and parse table rows
    awk -v start="$start_marker" -v end="$end_marker" '
        /^## / { in_section = 0 }
        $0 ~ start { in_section = 1; next }
        in_section && $0 ~ end { exit }
        in_section && /^\| / && !/^\| [A-Za-z]/ && !/^\|--/ {
            # Extract the link text from table row
            if (match($0, /\| \[([^\]]+)\]\([^)]+\) \|/)) {
                print substr($0, RSTART + 2, RLENGTH - 2)
            }
        }
    ' "$README_FILE" | sed 's/\[\([^]]*\)\].*/\1/'
}

# Function to get actual directory contents
get_directory_contents() {
    local dir="$1"
    if [ -d "$dir" ]; then
        # Only include files that have actual content (non-zero size)
        find "$dir" -name "*.md" -type f -size +0 | sed "s|^$dir/||" | sed 's|\.md$||'
    fi
}

# Function to compare README content with actual files
validate_section() {
    local section_name="$1"
    local start_marker="$2"
    local end_marker="$3"
    local directory="$4"

    echo "  Checking $section_name..."

    # Extract README table content
    readme_items=$(extract_table_content "$section_name" "$start_marker" "$end_marker")

    # Get actual directory contents
    actual_items=$(get_directory_contents "$directory")

    # Check for missing items in README
    missing_in_readme=""
    while IFS= read -r item; do
        if [ -n "$item" ]; then
            # Convert filename to display name (e.g., "adult-learning-theory-expert" -> "Adult Learning Theory Expert")
            display_name=$(echo "$item" | sed 's/-/ /g' | sed 's/\b\w/\U&/g')

            if ! echo "$readme_items" | grep -qi "$display_name"; then
                missing_in_readme="$missing_in_readme$item, "
            fi
        fi
    done <<< "$actual_items"

    # Check for extra items in README
    extra_in_readme=""
    while IFS= read -r readme_item; do
        if [ -n "$readme_item" ]; then
            # Convert display name to filename format
            filename=$(echo "$readme_item" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

            if [ ! -f "$directory/$filename.md" ]; then
                extra_in_readme="$extra_in_readme$readme_item, "
            fi
        fi
    done <<< "$readme_items"

    # Report issues
    if [ -n "$missing_in_readme" ]; then
        echo "    ❌ Missing in README: ${missing_in_readme%, }"
        return 1
    fi

    if [ -n "$extra_in_readme" ]; then
        echo "    ❌ Extra in README: ${extra_in_readme%, }"
        return 1
    fi

    echo "    ✅ $section_name is up to date"
    return 0
}

# Track validation results
validation_failed=false

# Validate each section
echo "  Validating Specialized Agents..."
if ! validate_section "Specialized Agents" "## 🤖 Specialized Agents" "## 💬 Custom Commands" "agents"; then
    validation_failed=true
fi

echo "  Validating Custom Commands..."
if ! validate_section "Custom Commands" "## 💬 Custom Commands" "## 🧩 Templates" "commands"; then
    validation_failed=true
fi

echo "  Validating Templates..."
if ! validate_section "Templates" "## 🧩 Templates" "## 🤝 Contributing" "templates"; then
    validation_failed=true
fi

# Check if validation passed
if [ "$validation_failed" = true ]; then
    echo ""
    echo "❌ README validation failed!"
    echo "Please update the README.md to accurately reflect the repository structure."
    exit 1
fi

echo "✅ README validation passed!"
exit 0
