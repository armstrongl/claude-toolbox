---
name: analyze-repo-changes-update-docs
description: Analyzes git repository changes and systematically updates all documentation files to reflect those changes.
argument-hint: [branch-or-commit-range]
allowed-tools: Bash(git:*), Read, Write, Edit, MultiEdit, Glob, Grep, Task, TodoWrite
auto-execute: false
thinking-mode: deep
parameters:
  - name: doc_patterns
    type: string
    required: false
    default: "**/*.md,**/*.txt,**/README*,**/CHANGELOG*,**/docs/**/*"
    description: Glob patterns for documentation files to update (comma-separated).
  - name: exclude_patterns
    type: string
    required: false
    default: "**/node_modules/**,**/vendor/**,**/.git/**,**/dist/**,**/build/**"
    description: Glob patterns for paths to exclude from documentation updates.
  - name: commit_range
    type: string
    required: false
    default: "HEAD~1..HEAD"
    description: Git commit range to analyze for changes.
author: Larah
version: 1.0.0
tags: git, documentation, automation, analysis, repository-management
---

You will analyze recent changes in a git repository and systematically update all documentation files to reflect those changes. This command ensures documentation stays synchronized with code changes by detecting modifications and intelligently updating relevant documentation sections.

## Process Instructions

1. **Analyze Repository Changes**
   - Use `git status` to check the current repository state and ensure you're in a git repository.
   - Determine the commit range to analyze:
     - If an argument is provided, use it as the commit range.
     - Otherwise, use the commit_range parameter (default: HEAD~1..HEAD).
   - Execute `git log --oneline --no-merges [range]` to get a summary of recent commits.
   - Run `git diff --stat [range]` to see which files have changed.
   - Execute `git diff --name-status [range]` to categorize changes (Added, Modified, Deleted, Renamed).

2. **Extract Detailed Change Information**
   - For each changed file, run `git diff [range] -- [file]` to extract the specific changes.
   - Categorize changes by type:
     - New features or functionality additions.
     - Bug fixes or corrections.
     - Refactoring or code improvements.
     - Configuration or dependency changes.
     - API changes or interface modifications.
     - File deletions or deprecations.
   - Create a comprehensive change summary including:
     - File paths and types of changes.
     - Function/class/method names that were modified.
     - New dependencies or requirements added.
     - Breaking changes or compatibility impacts.

3. **Locate Documentation Files**
   - Use Glob with the doc_patterns parameter to find all documentation files.
   - Filter out files matching exclude_patterns.
   - Prioritize documentation files in this order:
     - README.md or README files in the root directory.
     - CHANGELOG.md or CHANGELOG files.
     - Files in docs/ or documentation/ directories.
     - API documentation files.
     - Configuration documentation.
     - Any other markdown or text documentation files.

4. **Analyze Documentation Relevance**
   - For each documentation file found:
     - Read its current content using the Read tool.
     - Identify sections that might need updates based on the changes:
       - Installation or setup instructions if dependencies changed.
       - Usage examples if APIs or interfaces changed.
       - Configuration sections if config files were modified.
       - Feature lists if new functionality was added.
       - Troubleshooting sections if bugs were fixed.
       - Deprecation notices if features were removed.

5. **Update Documentation Files**
   - For each documentation file requiring updates:
     - Create a TodoWrite task for updating that specific file.
     - Mark the task as in_progress before starting updates.
     - Use MultiEdit to make multiple changes efficiently:
       - Update version numbers or dates where appropriate.
       - Add new features to feature lists or tables of contents.
       - Update code examples to reflect API changes.
       - Add migration notes for breaking changes.
       - Update configuration examples if settings changed.
       - Add or update badges, status indicators, or metrics.
     - Ensure consistency in formatting and style with existing documentation.
     - Mark the task as completed after successful update.

6. **Update Changelog**
   - If a CHANGELOG file exists:
     - Add a new entry with the current date.
     - Organize changes by category (Added, Changed, Fixed, Removed).
     - Include commit references where helpful.
     - Follow the existing changelog format (e.g., Keep a Changelog standard).
   - If no CHANGELOG exists but should, inform the user about creating one.

7. **Generate Update Summary**
   - Create a comprehensive report of all documentation updates made:
     - List of files updated with specific changes.
     - Files that might need manual review.
     - Suggestions for additional documentation improvements.
     - Any inconsistencies or gaps discovered.
   - If any documentation appears significantly outdated, flag it for manual review.

8. **Validate Updates**
   - For each updated file:
     - Ensure no broken links were introduced.
     - Verify code examples are syntactically correct.
     - Check that version numbers are consistent across files.
     - Confirm formatting follows the project's style.
   - Report any validation issues found.

---

## How to Use This Command

Run this command with: `/analyze-repo-changes-update-docs [branch-or-commit-range]`

This command analyzes git repository changes and automatically updates documentation to reflect those changes. It's particularly useful after completing features, fixes, or refactoring.

Examples:

- `/analyze-repo-changes-update-docs` - Analyzes the last commit and updates docs
- `/analyze-repo-changes-update-docs main..feature-branch` - Updates docs based on all changes between main and feature-branch
- `/analyze-repo-changes-update-docs HEAD~5..HEAD` - Updates docs based on the last 5 commits
- `/analyze-repo-changes-update-docs abc123..def456` - Updates docs for changes between two specific commits

The command will:

1. Analyze all code changes in the specified range
2. Identify which documentation files need updates
3. Automatically update relevant sections
4. Generate a summary of all changes made

Note: This command requires you to be in a git repository. It will modify documentation files, so review changes before committing them. The command uses intelligent analysis to determine what needs updating but may benefit from manual review for complex changes.
