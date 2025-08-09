---
name: create-bash-script
description: Generate production-ready bash scripts with standardized structure, error handling, and common flags.
argument-hint: <script-name> [description]
allowed-tools: Edit, Read, Bash, Write, MultiEdit, Bash(mkdir*), Bash(chmod*)
auto-execute: false
thinking-mode: ultrathink
author: Larah
version: 1.0.0
tags: bash, scripting, automation, development
---

You are Claude Code. You will create production-ready bash scripts following best practices and standardized patterns. The user will provide a script name and optionally a description of what the script should do.

## Bash Scripting Guidelines

### 1. Script Structure

Always use this standard structure:

- Shebang line: `#!/usr/bin/env bash`
- Script metadata block with description, author, version
- Strict error handling with `set -euo pipefail`
- Standard flag definitions (--help, --verbose, --dry-run, --backup)
- Function definitions before main logic
- Main function that orchestrates the script
- Guard to ensure main runs only when script is executed directly

### 2. Error Handling

- Use `set -euo pipefail` at the beginning
- Implement proper error messages with context
- Use trap for cleanup on exit
- Return meaningful exit codes (0 for success, 1-255 for various errors)

### 3. Standard Flags

Every script must implement these flags:

- `--help` / `-h`: Display usage information
- `--verbose` / `-v`: Enable verbose output
- `--dry-run` / `-n`: Show what would be done without executing
- `--backup` / `-b`: Create backups before modifying files

### 4. Best Practices

- Use lowercase for variable names, uppercase for constants
- Quote all variables: `"${variable}"`
- Use `[[ ]]` for conditionals instead of `[ ]`
- Implement logging functions for consistent output
- Add input validation for all parameters
- Use functions for repeated code
- Include helpful error messages

### 5. Documentation

- Add comprehensive comments for complex logic
- Document all functions with purpose and parameters
- Include usage examples in help text
- Maintain a changelog in script comments

## Process Instructions

1. Parse the user's input to extract:
   - Script name (required)
   - Script purpose/description (optional)
   - Any specific requirements mentioned

2. Generate the bash script with the following components:

   a. **Header Section**:
      - Shebang line
      - Script metadata (description, author, date, version)
      - License information if applicable

   b. **Configuration Section**:
      - Set strict mode options
      - Define global variables and constants
      - Set default values for flags

   c. **Utility Functions**:
      - Logging functions (info, error, debug)
      - Backup function
      - Cleanup function
      - Any task-specific utility functions

   d. **Flag Parsing**:
      - Implement getopts or manual parsing for all standard flags
      - Add any script-specific flags
      - Validate flag combinations

   e. **Help Function**:
      - Display script purpose
      - Show all available options with descriptions
      - Include usage examples
      - Show version information

   f. **Main Logic**:
      - Input validation
      - Core functionality
      - Error handling
      - Cleanup on exit

   g. **Script Guard**:
      - Ensure main function only runs when script is executed directly

3. Generate a README.md file for the script containing:
   - Script name and purpose
   - Installation instructions
   - Usage examples
   - Flag descriptions
   - Requirements/dependencies
   - Troubleshooting section
   - Contributing guidelines

4. Unless otherwise specified, save both files to the default scripts directory:
   - Ensure the directory `/Users/larah/.dotfiles/.scripts/` exists (create if needed)
   - Script: `/Users/larah/.dotfiles/.scripts/<script-name>/<script-name>.sh` with executable permissions (chmod +x)
   - README: `/Users/larah/.dotfiles/.scripts/<script-name>/README.md`
   - Changelog: `/Users/larah/.dotfiles/.scripts/<script-name>/CHANGELOG.md`

5. Update the `/Users/larah/.dotfiles/.scripts/README.md` file to include the new script name and description.

6. If verbose mode was requested, also display:
   - Summary of what was created
   - Next steps for the user
   - Tips for customization

## Minimal Style Guide

### Naming Conventions

- Script names: lowercase with hyphens (e.g., `backup-database.sh`)
- Functions: lowercase with underscores (e.g., `parse_arguments()`)
- Constants: uppercase with underscores (e.g., `DEFAULT_BACKUP_DIR`)
- Local variables: lowercase with underscores

### Formatting

- Use 2 spaces for indentation (no tabs)
- Maximum line length: 80 characters
- One blank line between functions
- Opening braces on same line for functions and conditionals

### Comments

- Use `#` for single-line comments
- Start sentences with capital letters
- Place comments above the code they describe
- Use TODO/FIXME/NOTE markers for important notes

## Script Template

```bash
#!/usr/bin/env bash
#
# Script: [SCRIPT_NAME]
# Description: [DESCRIPTION]
# Author: [AUTHOR]
# Date: [DATE]
# Version: 1.0.0
#
# Usage: [SCRIPT_NAME] [OPTIONS]
#
# Options:
#   -h, --help      Show this help message
#   -v, --verbose   Enable verbose output
#   -n, --dry-run   Show what would be done without executing
#   -b, --backup    Create backups before modifying files

set -euo pipefail

# Constants
readonly SCRIPT_NAME="$(basename "${0}")"
readonly SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
readonly VERSION="1.0.0"

# Global variables
VERBOSE=false
DRY_RUN=false
CREATE_BACKUP=false

# Logging functions
log_info() {
  echo "[INFO] $*" >&2
}

log_error() {
  echo "[ERROR] $*" >&2
}

log_debug() {
  if [[ "${VERBOSE}" == true ]]; then
    echo "[DEBUG] $*" >&2
  fi
}

# Display usage information
show_help() {
  cat << EOF
${SCRIPT_NAME} - [DESCRIPTION]

Version: ${VERSION}

USAGE:
    ${SCRIPT_NAME} [OPTIONS]

OPTIONS:
    -h, --help      Show this help message and exit
    -v, --verbose   Enable verbose output
    -n, --dry-run   Show what would be done without executing
    -b, --backup    Create backups before modifying files

EXAMPLES:
    # Run with default settings
    ${SCRIPT_NAME}

    # Run in dry-run mode with verbose output
    ${SCRIPT_NAME} --dry-run --verbose

    # Run with backup enabled
    ${SCRIPT_NAME} --backup

EOF
}

# Parse command line arguments
parse_arguments() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      -h|--help)
        show_help
        exit 0
        ;;
      -v|--verbose)
        VERBOSE=true
        shift
        ;;
      -n|--dry-run)
        DRY_RUN=true
        shift
        ;;
      -b|--backup)
        CREATE_BACKUP=true
        shift
        ;;
      --)
        shift
        break
        ;;
      -*)
        log_error "Unknown option: $1"
        show_help
        exit 1
        ;;
      *)
        break
        ;;
    esac
  done
}

# Create backup of a file
create_backup() {
  local file="$1"
  if [[ -f "${file}" ]] && [[ "${CREATE_BACKUP}" == true ]]; then
    local backup_file="${file}.backup.$(date +%Y%m%d_%H%M%S)"
    if [[ "${DRY_RUN}" == true ]]; then
      log_info "[DRY-RUN] Would create backup: ${file} -> ${backup_file}"
    else
      cp "${file}" "${backup_file}"
      log_info "Created backup: ${backup_file}"
    fi
  fi
}

# Cleanup function
cleanup() {
  log_debug "Performing cleanup..."
  # Add cleanup tasks here
}

# Main function
main() {
  log_debug "Starting ${SCRIPT_NAME} v${VERSION}"

  # Your main logic here
  log_info "Executing main logic..."

  if [[ "${DRY_RUN}" == true ]]; then
    log_info "[DRY-RUN] Would perform main action"
  else
    # Actual implementation
    log_info "Performing main action..."
  fi

  log_info "Script completed successfully"
}

# Set trap for cleanup on exit
trap cleanup EXIT

# Parse arguments
parse_arguments "$@"

# Execute main function only if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main
fi
```

## README Template

```markdown
# [SCRIPT_NAME]

[DESCRIPTION]

## Installation

1. Download the script:
   ```bash
   curl -O https://example.com/[SCRIPT_NAME].sh
   ```

2. Make it executable:

   ```bash
   chmod +x [SCRIPT_NAME].sh
   ```

3. Optionally, move to a directory in your PATH:

   ```bash
   sudo mv [SCRIPT_NAME].sh /usr/local/bin/[SCRIPT_NAME]
   ```

## Usage

```bash
[SCRIPT_NAME] [OPTIONS]
```

### Options

- `-h, --help` - Show help message and exit
- `-v, --verbose` - Enable verbose output for debugging
- `-n, --dry-run` - Preview changes without making them
- `-b, --backup` - Create backups before modifying files

### Examples

Basic usage:

```bash
[SCRIPT_NAME]
```

Dry run with verbose output:

```bash
[SCRIPT_NAME] --dry-run --verbose
```

Run with backups enabled:

```bash
[SCRIPT_NAME] --backup
```

## Requirements

- Bash 4.0 or later
- Standard Unix utilities (grep, sed, awk, etc.)

## Configuration

The script uses the following environment variables (if set):

- `[RELEVANT_ENV_VARS]` - Description

## Troubleshooting

### Common Issues

1. **Permission denied**: Ensure the script has execute permissions
2. **Command not found**: Check that required utilities are installed

### Debug Mode

Run with `--verbose` flag to see detailed execution information:

```bash
[SCRIPT_NAME] --verbose
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

[LICENSE_TYPE]

## Changelog

- v1.0.0 - Initial release

```

---

## How to Use This Command

Run this command with: `/create-bash-script <script-name> [description]`

This command generates a production-ready bash script with standardized structure, error handling, and common flags (--help, --verbose, --dry-run, --backup).

Examples:
- `/create-bash-script backup-databases "Automated database backup with rotation"`
- `/create-bash-script deploy-app "Deploy application to production servers"`
- `/create-bash-script cleanup-logs`

The command will create:
1. An executable bash script: `/Users/larah/.dotfiles/.scripts/<script-name>/<script-name>.sh`
2. A comprehensive README file: `/Users/larah/.dotfiles/.scripts/<script-name>/README.md`
3. A changelog file: `/Users/larah/.dotfiles/.scripts/<script-name>/CHANGELOG.md`

Both files will follow best practices and include all standard flags and proper error handling. The scripts directory will be created if it doesn't exist.
