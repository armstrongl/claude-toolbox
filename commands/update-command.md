---
name: update-command
description: Update Claude Code Commands to conform to current template standards, accepting single commands, multiple commands, directories, or all global commands.
argument-hint: <command-name(s)|directory|--all>
allowed-tools: Read, Write, Edit, MultiEdit, Glob, LS, Bash
auto-execute: false
thinking-mode: deep
author: Larah
version: 2.0.0
tags: tooling, automation, command-maintenance, refactoring, batch-processing
---

You are Claude Code. You will update Claude Code Commands to conform to current template standards and improve their clarity, precision, and effectiveness. This command can process single commands, multiple commands, entire directories, or all global commands in a batch operation.

## Process Overview

Based on the provided arguments, you will determine the scope of commands to update, then systematically process each command file to meet current standards. The goal is to produce commands that are clearer, more maintainable, and follow best practices while preserving their original functionality.

## Step 1: Parse arguments and determine scope

Analyze the provided arguments to determine which commands need updating.

**Instructions**:

1. Check the argument format:
   - Single command: A single command name (e.g., `analyze-code`)
   - Multiple commands: Space or comma-separated list (e.g., `analyze-code generate-tests` or `analyze-code,generate-tests`)
   - Directory path: A path to a directory containing commands (e.g., `./project-commands/`)
   - All flag: `--all` to process all commands in the global directory
2. Build a list of command files to process:
   - For single/multiple commands: Construct paths as `/Users/larah/.claude/commands/[command-name].md`
   - For directory: Use Glob to find all `.md` files in the specified directory
   - For --all: Use Glob to find all `.md` files in `/Users/larah/.claude/commands/`
3. Validate that command files exist:
   - Use LS or Glob to verify file existence
   - Report any missing commands
   - Continue with available commands

**Expected Output**:
A list of valid command file paths to process, with clear reporting of any issues found.

## Step 2: Process each command file

Iterate through the list of command files, updating each one according to the standard process.

**Instructions**:

1. For each command file in the list:
   - Read the complete file content
   - Extract frontmatter and process instructions
   - Track the command name for progress reporting
2. Create a processing summary structure to track:
   - Total commands to process
   - Successfully updated commands
   - Failed updates with reasons
   - Skipped commands (e.g., already conforming to standards)
3. Report progress periodically for batch operations:
   - Show "Processing [N/Total]: [command-name]"
   - Indicate completion status for each command

**Expected Output**:
Clear progress tracking and status updates during batch processing.

## Step 3: Analyze frontmatter compliance

For each command, examine its frontmatter against current template standards.

**Instructions**:

1. Check for required fields that must always be present:
   - name (must be kebab-case)
   - description (must be a complete sentence)
   - allowed-tools (must list specific tools)
2. Identify deprecated or incorrectly formatted fields
3. Note any missing beneficial fields based on the command's purpose
4. Validate field values against these rules:
   - Boolean fields: true/false (not yes/no or other variants)
   - Lists: Properly formatted arrays for parameters and tags
   - Tool permissions: Correct syntax for restricted Bash commands
5. Consider if the command might already be compliant:
   - If no changes needed, mark as skipped
   - Continue to next command in batch

**Expected Output**:
For each command, a list of frontmatter issues to fix or confirmation that it's already compliant.

## Step 4: Improve process instructions

Analyze and enhance each command's process instructions for clarity and effectiveness.

**Instructions**:

1. Evaluate the current instructions for:
   - Clarity and precision of language
   - Logical flow and organization
   - Completeness of step descriptions
   - Appropriate level of detail
2. Identify areas needing improvement:
   - Vague or ambiguous instructions
   - Missing error handling
   - Unclear decision points
   - Inconsistent formatting
3. Plan specific improvements while preserving core functionality
4. Add importance indicators like "IMPORTANT" or "CRITICAL" to the instructions if they are critical to the command's success.
5. For batch operations:
   - Apply consistent formatting across all commands
   - Ensure similar commands follow similar patterns

**Expected Output**:
Clear improvement plan for each command's instructions.

## Step 5: Update and save commands

Rewrite each command with improved frontmatter and process instructions.

**Instructions**:

1. For each command requiring updates:
   - Create properly formatted frontmatter
   - Rewrite process instructions for clarity
   - Preserve the command's core purpose and functionality
2. Save the updated command:
   - Overwrite the original file
   - Ensure proper markdown formatting
   - Validate YAML frontmatter syntax
3. Handle errors gracefully:
   - If a command fails to update, log the error
   - Continue processing remaining commands
   - Report all errors at the end

**Expected Output**:
Successfully updated command files with proper formatting and improved clarity.

## Step 6: Generate batch processing report

Create a comprehensive summary of all updates performed.

**Instructions**:

1. Generate a summary report including:
   - Total commands processed
   - Number successfully updated
   - Number skipped (already compliant)
   - Number failed with reasons
2. For updated commands, list key improvements:
   - Frontmatter corrections made
   - Major instruction clarifications
   - Consistency improvements
3. For failed commands, provide:
   - Command name
   - Specific error encountered
   - Suggested manual intervention if needed
4. Format the report clearly:
   - Use markdown formatting
   - Group by status (updated, skipped, failed)
   - Include timestamps if processing many commands

**Expected Output**:
A comprehensive, well-formatted report summarizing all command updates.

---

## How to Use This Command

Run this command with various argument formats:

### Single Command

`/update-command analyze-code`
Updates a single command file.

### Multiple Commands

`/update-command analyze-code generate-tests search-todos`
`/update-command analyze-code,generate-tests,search-todos`
Updates multiple specified commands.

### Directory of Commands

`/update-command ./project-commands/`
Updates all `.md` files in the specified directory.

### All Global Commands

`/update-command --all`
Updates all commands in `/Users/larah/.claude/commands/`.

The command will:

1. Determine which commands to update based on arguments
2. Process each command file systematically
3. Update frontmatter to current standards
4. Improve clarity and precision of instructions
5. Save updated commands back to their original locations
6. Provide a comprehensive summary of all changes

Note: Since this command modifies existing files, auto-execute is disabled. You'll need to review and approve the changes before they're saved. For large batch operations, you may want to backup your commands directory first.
