# Pre-commit Hook for README Validation

This repository includes a git pre-commit hook that automatically validates the README.md content against the actual repository structure.

## What It Does

The pre-commit hook ensures that:

1. **Specialized Agents** table accurately reflects all `.md` files in the `agents/` directory
2. **Custom Commands** table accurately reflects all `.md` files in the `commands/` directory
3. **Templates** table accurately reflects all non-empty `.md` files in the `templates/` directory

## How It Works

The hook:

- Parses the README.md markdown tables to extract listed items
- Scans the actual directories for `.md` files
- Compares the two lists to find discrepancies
- Only considers files with actual content (non-zero size)
- Converts between filename format (e.g., `adult-learning-theory-expert`) and display names (e.g., `Adult Learning Theory Expert`)

## Usage

### Automatic (Recommended)

The hook runs automatically on every `git commit`. If validation fails, the commit is blocked until the README is updated.

### Manual Validation

You can manually validate the README at any time:

```bash
# Run the pre-commit hook manually
.git/hooks/pre-commit

# Or use the standalone validation script
./scripts/validate-readme.sh
```

### Bypassing the Hook

If you need to commit without validation (not recommended):

```bash
git commit --no-verify
```

## Validation Rules

- **Missing items**: Files that exist in directories but aren't listed in README tables
- **Extra items**: Items listed in README tables that don't correspond to actual files
- **Empty files**: Files with 0 bytes are ignored (not included in validation)

## Troubleshooting

### Common Issues

1. **Missing in README**: Add the missing item to the appropriate table
2. **Extra in README**: Remove the extra item or create the corresponding file
3. **Name mismatches**: Ensure display names in README match the actual file content

### File Naming Convention

The hook expects:

- Filenames: kebab-case (e.g., `adult-learning-theory-expert.md`)
- Display names: Title Case (e.g., `Adult Learning Theory Expert`)

## Maintenance

The hook automatically adapts to:

- New files added to directories
- Files removed from directories
- Changes in file content (non-empty vs empty)

No manual configuration is needed when adding or removing files.
