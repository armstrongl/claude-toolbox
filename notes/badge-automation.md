# Badge Automation System

The Claude Toolbox includes an automated system to keep README badge counts accurate and up-to-date. This eliminates manual maintenance when adding or removing agents, commands, and templates.

## How It Works

The system consists of three components that work together:

### 1. Badge Update Script (`scripts/update-badges.sh`)

Scans the repository directories and updates badge counts in README.md:

- **Agents**: Counts `.md` files in `agents/` directory
- **Commands**: Counts `.md` files in `commands/` directory
- **Templates**: Counts `.md` files in `templates/` directory
- **Hooks**: Counts `.md` files in `hooks/` directory

The script provides colored output for clear feedback during updates.

### 2. Git Pre-Commit Hook (`.githooks/pre-commit`)

Automatically runs before each commit to detect when badge updates are needed:

- Monitors staged changes for `.md` files in tracked directories
- Runs the badge update script when relevant changes are detected
- Stages the updated README.md for inclusion in the commit
- Prevents commits if badge updates fail

### 3. Setup Script (`scripts/setup-hooks.sh`)

Configures Git to use the custom hooks directory:

- Sets `core.hooksPath` to `.githooks`
- Ensures proper permissions on hook files
- Tests the badge update functionality
- Provides setup verification

## Setup Instructions

### Initial Setup

Run the setup script to configure automatic updates:

```bash
./scripts/setup-hooks.sh
```

This one-time setup:

- Configures Git to use custom hooks
- Sets proper permissions
- Tests the system
- Enables automatic badge updates on commits

### Manual Updates

Update badges manually anytime:

```bash
./scripts/update-badges.sh
```

Use this when:

- Testing badge accuracy
- Updating after bulk file operations
- Troubleshooting the automation

## Features

### Safety Mechanisms

- **Change Detection**: Only updates when changes are actually needed
- **Error Handling**: Robust error checking with clear failure messages
- **Commit Integration**: Seamlessly integrates with Git workflow

### Smart Detection

The system intelligently detects when updates are necessary:

- **File Changes**: Monitors additions and deletions of `.md` files
- **Directory Scope**: Only tracks relevant directories (agents, commands, templates, hooks)
- **Staged Changes**: Works with Git's staging area for commit integration

### User Experience

- **Colored Output**: Clear visual feedback with status colors
- **Progress Indicators**: Shows what's happening at each step
- **Minimal Overhead**: Fast execution with minimal impact on workflow
- **Silent Success**: Quiet operation when no changes are needed

## Troubleshooting

### Disable Automation

Temporarily disable the pre-commit hook:

```bash
git config --unset core.hooksPath
```

Re-enable by running `./scripts/setup-hooks.sh` again.

### Manual Badge Updates

If automation fails, update badges manually by editing README.md:

```markdown
[![Agents](https://img.shields.io/badge/Agents-[COUNT]-blue)](./agents)
[![Commands](https://img.shields.io/badge/Commands-[COUNT]-green)](./commands)
[![Templates](https://img.shields.io/badge/Templates-[COUNT]-purple)](./templates)
[![Hooks](https://img.shields.io/badge/Hooks-[COUNT]-orange)](./hooks)
```

Replace `[COUNT]` with actual file counts from each directory.

### Common Issues

**Hook Not Running**:

- Verify Git configuration: `git config core.hooksPath`
- Check hook permissions: `ls -la .githooks/pre-commit`
- Re-run setup: `./scripts/setup-hooks.sh`

**Badge Update Fails**:

- Run manual update to see detailed error: `./scripts/update-badges.sh`
- Check README.md syntax around badge lines
- Use Git to restore previous version if needed: `git checkout HEAD -- README.md`

**Incorrect Counts**:

- Verify directory structure matches expected layout
- Check for non-`.md` files that shouldn't be counted
- Run manual count: `find agents/ -name "*.md" -type f | wc -l`
- Check each directory: `find hooks/ -name "*.md" -type f | wc -l`

## File Structure

```
claude-toolbox/
├── .githooks/
│   └── pre-commit              # Git hook for automatic updates
├── scripts/
│   ├── update-badges.sh        # Core badge update functionality
│   └── setup-hooks.sh          # One-time setup configuration
├── notes/
│   └── badge-automation.md     # This documentation
└── README.md                   # Target file for badge updates
```

## Benefits

This automation system provides several advantages:

- **Accuracy**: Eliminates human error in manual badge updates
- **Efficiency**: Removes repetitive maintenance tasks
- **Consistency**: Ensures badges reflect actual repository state
- **Integration**: Works seamlessly with existing Git workflows
- **Reliability**: Includes error handling and change detection

The system runs transparently in the background, keeping documentation accurate without disrupting development flow.
