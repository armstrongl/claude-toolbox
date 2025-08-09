---
name: update-script
description: Update an existing script in the .scripts directory along with its README and CHANGELOG files
argument-hint: <script-name> [changes-description]
allowed-tools: Edit, Read, Bash, Write, MultiEdit, Glob, Grep, LS
auto-execute: false
thinking-mode: deep
author: Larah
version: 1.0.0
tags: bash, scripting, automation, maintenance, documentation
---

You are Claude Code. You will update existing scripts in the .dotfiles/.scripts directory along with their associated README and CHANGELOG files. The user will provide the script name and optionally a description of the changes.

## Process Instructions

1. **Parse User Input**:
   - Extract the script name (required)
   - Extract the changes description (optional)
   - If no description provided, ask the user what changes they want to make

2. **Locate the Script**:
   - Check if the script exists in `/Users/larah/.dotfiles/.scripts/<script-name>/`
   - If not found, check in `/Users/larah/.dotfiles/.scripts/` directly
   - If still not found, search for the script using Glob tool
   - Error if script cannot be found

3. **Analyze Current Script**:
   - Read the existing script file
   - Identify the current version from the script header
   - Understand the script's purpose and structure
   - Note any existing patterns or conventions used

4. **Gather Update Requirements**:
   - If the user hasn't specified what to update, ask for clarification
   - Determine what parts of the script need modification
   - Plan the changes to ensure they maintain script integrity

5. **Update the Script**:
   - Make the requested changes to the script
   - Increment the version number in the script header
   - Update the "Date" field in the header to today's date
   - Ensure all changes follow the existing code style
   - Preserve all existing functionality unless explicitly asked to remove

6. **Update README.md**:
   - Locate the README.md file in the same directory as the script
   - Update any relevant sections based on the changes:
     - Usage examples if CLI changed
     - Options/flags if new ones added
     - Requirements if dependencies changed
     - Configuration if new settings added
   - Keep all other sections intact

7. **Update CHANGELOG.md**:
   - Locate or create CHANGELOG.md in the same directory
   - Add a new entry at the top with:
     - Version number (incremented from script)
     - Date (today's date)
     - Type of change (Added/Changed/Fixed/Removed)
     - Description of changes
   - Follow Keep a Changelog format:

     ```markdown
     ## [1.1.0] - 2025-08-03
     ### Changed
     - Description of what was changed
     ### Added
     - New features or functionality
     ```

8. **Validation**:
   - If it's a bash script, check syntax with `bash -n`
   - Ensure version numbers match across all files
   - Verify no accidental deletions or corruptions

9. **Summary**:
   - Report what files were updated
   - Show the new version number
   - List the key changes made
   - Suggest testing the script

## Version Increment Rules

- **Major (X.0.0)**: Breaking changes, complete rewrites
- **Minor (1.X.0)**: New features, significant additions
- **Patch (1.0.X)**: Bug fixes, minor improvements

Default to patch version increment unless the changes warrant minor/major.

## Important Guidelines

1. **Preserve Functionality**: Never break existing features unless explicitly requested
2. **Maintain Style**: Follow the existing code style and conventions
3. **Document Changes**: Always update documentation to reflect changes
4. **Backup Safety**: The original files are in git, but be careful with edits
5. **Test Recommendations**: Always recommend testing after updates

## Error Handling

- If script not found: Help user locate it or suggest creating new one
- If no README/CHANGELOG: Create them following standard templates
- If syntax errors introduced: Rollback changes and report issue
- If version conflicts: Use the highest version found + increment

---

## How to Use This Command

Run this command with: `/update-script <script-name> [changes-description]`

This command updates an existing script in your .scripts directory along with its documentation.

Examples:

- `/update-script backup-databases "Add support for PostgreSQL"`
- `/update-script deploy-app "Fix error handling in deployment phase"`
- `/update-script cleanup-logs` (will ask what changes you want)

The command will:

1. Find your script in the .scripts directory
2. Make the requested updates
3. Increment the version number
4. Update the README if needed
5. Add an entry to the CHANGELOG
6. Validate the changes

All changes preserve existing functionality unless you explicitly request removal.
