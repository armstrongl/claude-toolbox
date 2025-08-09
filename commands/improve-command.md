---
name: improve-command
description: Analyze and improve one or more existing Claude Code commands by optimizing their structure, enhancing documentation, and applying best practices.
argument-hint: <command-pattern> [improvement-type]
allowed-tools: Read, Edit, MultiEdit, Glob, Grep, Task
auto-execute: false
thinking-mode: deep
max-turns: 20
author: Larah
version: 1.0.0
tags: command-improvement, optimization, maintenance
parameters:
  - name: improvement-scope
    type: string
    required: false
    default: comprehensive
    choices: comprehensive, documentation, structure, performance, frontmatter
    description: Specific aspect of commands to improve
  - name: apply-changes
    type: boolean
    required: false
    default: false
    description: Apply improvements directly or just provide suggestions
  - name: backup
    type: boolean
    required: false
    default: true
    description: Create backup copies before modifying commands
---

# Improve Existing Commands

This command analyzes one or more existing Claude Code commands to identify areas for improvement, then either suggests or applies enhancements. The command evaluates command structure, documentation quality, frontmatter optimization, and adherence to best practices, helping maintain a high-quality command library.

## Step 1: Locate and validate target commands

Find all commands matching the specified pattern or path.

**Instructions**:

1. Parse input arguments to determine:
   - Command name pattern or specific command paths.
   - Improvement type if specified (comprehensive by default).
   - Whether to search in default location (`~/.claude/commands/`) or specified path.
2. Use Glob to find matching command files (*.md).
3. Validate each file:
   - Ensure it has proper YAML frontmatter.
   - Verify it's a valid command file structure.
   - Check file permissions for editing.
4. If backup parameter is true and apply-changes is true:
   - Create `.backup` directory if it doesn't exist.
   - Plan backup strategy for all files to be modified.
5. Report found commands and their current status.

**Expected Output**:
List of valid command files to analyze with basic validation status.

## Step 2: Analyze command structure and quality

Perform comprehensive analysis of each command file.

**Instructions**:

1. For each command, analyze frontmatter:
   - Check for required fields (name, description, allowed-tools).
   - Identify missing optional fields that could be beneficial.
   - Validate field values and formats.
   - Check for deprecated or incorrect field usage.
   - Check for invalid frontmatter configurations.
2. Analyze command content:
   - Evaluate documentation clarity and completeness.
   - Check for proper step structure and formatting.
   - Assess instruction specificity and actionability.
   - Check for missing or incorrect tool usage.
   - Check for style and formatting issues.
   - Assess the overall quality and effectiveness of the command.
   - Review example usage and help sections.
   - Review for workflow improvement opportunities.
3. Based on improvement-scope parameter:
   - **comprehensive**: Analyze all aspects.
   - **documentation**: Focus on content clarity and completeness.
   - **structure**: Examine step organization and flow.
   - **performance**: Check tool usage and execution efficiency.
   - **frontmatter**: Concentrate on metadata optimization.
4. Create improvement profile for each command.

**Expected Output**:
Detailed analysis report for each command with specific improvement areas identified.

## Step 3: Generate improvement recommendations

Create specific, actionable improvements for each command.

**Instructions**:

1. For frontmatter improvements:
   - Suggest missing beneficial fields (thinking-mode, max-turns, parameters).
   - Recommend optimal tool permissions based on actual usage.
   - Propose better command names or descriptions if needed.
   - Add helpful tags for organization.
2. For documentation improvements:
   - Enhance unclear instructions with specific details.
   - Add missing examples or use cases.
   - Improve step descriptions and expected outputs.
   - Standardize formatting and structure.
3. For structural improvements:
   - Reorganize steps for better flow.
   - Combine redundant steps.
   - Add missing validation or error handling steps.
   - Improve section organization.
4. For performance improvements:
   - Optimize tool usage (remove unnecessary tools and add useful tools).
   - Suggest more efficient approaches.
   - Recommend appropriate execution settings.
5. Prioritize improvements by impact and ease of implementation.

**Expected Output**:
Prioritized list of specific improvements for each command.

## Step 4: Create or apply improvements

Either generate improvement suggestions or apply them directly.

**Instructions**:

1. If apply-changes is false (default):
   - Generate detailed improvement report for each command.
   - Include before/after comparisons for key changes.
   - Provide code snippets for manual application.
   - Explain rationale for each suggestion.
2. If apply-changes is true:
   - Create backups if backup parameter is true:

     ```
     cp command.md .backup/command.md.backup-[timestamp]
     ```

   - Apply improvements using MultiEdit for efficiency:
     - Update frontmatter fields.
     - Enhance documentation sections.
     - Restructure content as needed.
     - Standardize formatting.
   - Track all changes made for reporting
3. Ensure improvements maintain command functionality.
4. Validate modified commands still parse correctly.

**Expected Output**:
Improvement report or successfully applied changes with change log.

## Step 5: Validate improvements

Ensure all improvements maintain or enhance command quality.

**Instructions**:

1. For each improved command:
   - Verify YAML frontmatter is valid.
   - Check that all required fields are present.
   - Ensure descriptions are clear and accurate.
   - Validate tool permissions match usage.
2. Test improvements conceptually:
   - Confirm steps flow logically.
   - Verify instructions are actionable.
   - Check examples are relevant and correct.
3. Compare before/after:
   - Ensure no functionality was lost.
   - Confirm improvements address identified issues.
   - Verify formatting consistency.
4. Generate quality score comparison if applicable.

**Expected Output**:
Validation report confirming improvement success and quality enhancement.

## Step 6: Generate comprehensive improvement report

Provide detailed summary of all improvements made or suggested.

**Instructions**:

1. Create summary report including:

   ```
   === COMMAND IMPROVEMENT REPORT ===
   Date: [current date]
   Commands analyzed: [count]
   Improvement scope: [scope parameter]
   Changes applied: [yes/no]

   SUMMARY:
   - Total improvements identified: [count]
   - Critical issues fixed: [count]
   - Documentation enhanced: [count]
   - Structure optimized: [count]

   DETAILED IMPROVEMENTS:
   [For each command:]
   Command: [name]
   - Improvements made/suggested: [list]
   - Impact level: [high/medium/low]
   - Status: [applied/suggested]
   ```

2. Include specific examples of key improvements.
3. If changes were applied:
   - List all modified files
   - Provide backup locations
   - Include rollback instructions if needed
4. Suggest next steps:
   - Additional improvements to consider
   - Testing recommendations
   - Maintenance schedule

**Expected Output**:
Comprehensive improvement report with all changes documented and next steps outlined.

---

## How to Use This Command

Run this command with: `/improve-command <command-pattern> [improvement-type]`

This command analyzes existing Claude Code commands and either suggests or applies improvements to enhance their quality and effectiveness.

Examples:

- `/improve-command analyze-*` - Improve all commands starting with "analyze-"
- `/improve-command my-command documentation` - Focus on improving documentation for my-command
- `/improve-command "*" frontmatter` - Optimize frontmatter for all commands

Parameters:

- `improvement-scope`: Choose what to improve (comprehensive, documentation, structure, performance, frontmatter)
- `apply-changes`: Set to true to apply improvements directly (default: false for safety)
- `backup`: Create backups before modifying (default: true)

The command will analyze your commands and either provide detailed suggestions or apply improvements directly based on your preferences.
