---
name: folder-readme
description: Create and update README files for folders by analyzing their contents, detecting changes, and maintaining accurate documentation.
argument-hint: [folder-path] [--recursive] [--update-only]
allowed-tools: Read, Write, Edit, MultiEdit, Glob, Grep, Task, Bash
auto-execute: false
thinking-mode: deep
max-turns: 20
parameters:
  - name: recursive
    type: boolean
    default: false
    description: Process all subfolders recursively
  - name: update-only
    type: boolean
    default: false
    description: Only update existing READMEs, don't create new ones
  - name: include-structure
    type: boolean
    default: true
    description: Include folder structure visualization
  - name: max-depth
    type: number
    default: 3
    description: Maximum depth for folder structure display
  - name: update-changelog
    type: boolean
    default: true
    description: Update CHANGELOG.md if it exists in the folder
author: Larah
version: 2.0.0
tags: documentation, folder-management, readme-generation, changelog
---

# Folder README Management

This command automatically creates and updates README files for folders by analyzing their contents, structure, and detecting changes since the last update. It maintains accurate documentation that reflects the current state of folders, preserves custom content, and optionally updates CHANGELOG.md files to track significant changes.

## Step 1: Identify target folders and analyze current state

Determine which folders need README processing and analyze their current documentation state.

**Instructions**:

1. Parse command arguments to determine the target:
   - If folder path provided: Use that as the starting point
   - If no path provided: Use the current working directory
   - Validate that the target path exists and is a directory
2. Build list of folders to process:
   - If `recursive` parameter is true: Use Glob to find all subdirectories
   - If `recursive` is false: Process only the target folder
   - Exclude hidden folders (starting with .) unless explicitly included
   - Exclude common build/dependency folders (node_modules, __pycache__, .git, etc.)
3. For each folder, check existing documentation:
   - Look for README.md, readme.md, Readme.md variations
   - Check for CHANGELOG.md if `update-changelog` is true
   - If `update-only` is true: Filter list to only folders with existing READMEs
   - Read existing README content to understand current documentation state
4. Capture baseline state for change detection:
   - Store current file listing and structure
   - Note modification times of existing files
   - Record current README content sections

**Expected Output**:
List of folder paths to process with their current documentation state and baseline information for change detection.

## Step 2: Analyze folder contents and detect changes

Examine each target folder to understand its purpose, contents, and changes since last documentation update.

**Instructions**:

1. For each folder, gather comprehensive information:
   - List all files and immediate subdirectories
   - Categorize files by type/extension
   - Identify key files (config files, main entry points, etc.)
   - Compare with existing README to detect new/removed files
2. Detect changes since last README update:
   - Identify new files or folders added
   - Find files or folders that were removed
   - Note significant structural changes
   - Check for new configuration files or dependencies
   - Look for changes in technology stack or frameworks
3. Analyze folder purpose based on contents:
   - Source code folders (presence of .py, .js, .java files)
   - Documentation folders (mainly .md, .txt files)
   - Configuration folders (config files, dotfiles)
   - Data folders (CSV, JSON, database files)
   - Asset folders (images, fonts, media files)
4. Identify significant changes worth documenting:
   - New major features (new subdirectories, modules)
   - Technology additions (new file types, frameworks)
   - Structural reorganizations
   - Configuration changes
   - Removed functionality

**Expected Output**:
Detailed analysis of each folder including current contents, detected purpose, and a list of significant changes since last update.

## Step 3: Generate updated README content

Create appropriate README content that reflects the current state and highlights important changes.

**Instructions**:

1. Determine README sections based on folder analysis:
   - Standard sections: Title, Description, Contents
   - Code folders: Add Usage, API, Examples sections
   - Documentation folders: Add Navigation, Topics sections
   - Config folders: Add Configuration Details section
   - Data folders: Add Data Format, Schema sections
2. Update existing content with current information:
   - **Title**: Use folder name formatted appropriately
   - **Description**: Update to reflect current purpose and any major changes
   - **What's New**: Add section highlighting recent changes (if updating)
   - **Contents Overview**: Current summary of folder contents
   - **Folder Structure**: Tree visualization if `include-structure` is true
3. Incorporate change information naturally:
   - Mention new additions in relevant sections
   - Update outdated references
   - Remove documentation for deleted items
   - Add notes about deprecated features
4. Format content using proper Markdown:
   - Use appropriate heading levels
   - Format code examples with backticks
   - Use lists for file enumerations
   - Create clear section separators

**Expected Output**:
Complete README content that accurately reflects current folder state and incorporates information about recent changes.

## Step 4: Preserve custom content and merge updates

For folders with existing READMEs, intelligently preserve custom content while updating generated sections.

**Instructions**:

1. Parse existing README structure:
   - Identify auto-generated vs custom sections
   - Look for content between standard markers
   - Detect custom examples, notes, or documentation
   - Find manually added sections or paragraphs
2. Create intelligent merge strategy:
   - Preserve all custom sections and content
   - Update auto-generated sections with fresh data
   - Maintain section ordering where it makes sense
   - Integrate new required sections smoothly
3. Handle conflicting information:
   - Prefer fresh analysis for factual data (file counts, structure)
   - Keep custom descriptions unless clearly outdated
   - Update technical details while preserving explanatory text
   - Flag any major inconsistencies for manual review
4. Apply smart content updates:
   - Update file paths and references
   - Refresh structure visualizations
   - Modernize outdated terminology
   - Preserve markdown formatting preferences

**Expected Output**:
Merged README content that preserves valuable custom documentation while updating factual information and structure.

## Step 5: Create folder structure visualizations

Generate clear visual representations of folder structures when requested.

**Instructions**:

1. Build folder tree visualization:
   - Use ASCII art tree characters (├── │ └──)
   - Respect `max-depth` parameter for depth limiting
   - Highlight new additions with indicators
   - Show key files at each level
2. Format the tree for clarity:

   ```
   folder-name/
   ├── src/
   │   ├── components/ (new)
   │   │   ├── Button.js
   │   │   └── Form.js
   │   └── utils/
   │       └── helpers.js
   ├── tests/
   └── README.md
   ```

3. Make the visualization informative:
   - Mark new folders/files added since last update
   - Indicate important configuration files
   - Show primary file types in each folder
   - Collapse very large directories intelligently
4. Add contextual information:
   - Include brief descriptions for key folders
   - Note the purpose of important files
   - Indicate relationships between folders

**Expected Output**:
Clean, informative folder structure visualization that helps users quickly understand organization and recent changes.

## Step 6: Update CHANGELOG.md if present

When a CHANGELOG.md exists and updates are enabled, add entries for significant changes detected.

**Instructions**:

1. Check for CHANGELOG.md in the folder:
   - Look for CHANGELOG.md, changelog.md variations
   - Read existing content to understand format
   - Identify the latest version or date entry
   - Determine changelog format (Keep a Changelog, conventional, custom)
2. Prepare changelog entry for detected changes:
   - Group changes by type (Added, Changed, Removed, Fixed)
   - Focus on user-visible or significant changes
   - Exclude minor documentation updates
   - Use clear, concise descriptions
3. Format new changelog entry:

   ```markdown
   ## [Unreleased] - 2024-XX-XX

   ### Added
   - New components directory with Button and Form components
   - Configuration for ESLint

   ### Changed
   - Restructured utils folder for better organization

   ### Removed
   - Deprecated legacy helpers
   ```

4. Insert new entry appropriately:
   - Add after header but before previous entries
   - Maintain consistent formatting with existing entries
   - Preserve version numbering scheme if present
   - Use today's date for the entry

**Expected Output**:
Updated CHANGELOG.md with new entry documenting significant changes, maintaining existing format and style.

## Step 7: Write updates to files

Save the generated content to README and optionally CHANGELOG files.

**Instructions**:

1. Update README.md files:
   - Write new content for folders without READMEs
   - Apply merged content for existing READMEs
   - Ensure proper UTF-8 encoding
   - Preserve file permissions
2. Update CHANGELOG.md if applicable:
   - Only update if file exists and `update-changelog` is true
   - Insert new entry at appropriate position
   - Maintain existing formatting
   - Skip if no significant changes detected
3. Add metadata to track updates:
   - Include subtle generation timestamp
   - Add marker for last auto-update
   - Note which sections are auto-maintained
   - Keep metadata unobtrusive
4. Validate all file updates:
   - Verify markdown syntax correctness
   - Ensure no content was lost
   - Check that formatting is consistent
   - Confirm changes were applied correctly

**Expected Output**:
Successfully updated documentation files with accurate, current information and proper formatting.

## Step 8: Generate comprehensive summary report

Create a detailed summary of all documentation updates and changes detected.

**Instructions**:

1. Compile execution statistics:
   - Number of folders processed
   - READMEs created vs updated
   - CHANGELOGs updated
   - Significant changes detected
2. Create detailed action log:

   ```markdown
   # Documentation Update Summary

   Processed 5 folders with 12 significant changes detected

   ## Folders Updated:
   ✅ /src - Updated README (3 new files detected)
   ✅ /src/components - Created new README
   ✅ /tests - Updated README and CHANGELOG
   ⚠️  /docs - README updated with structural changes
   ⏭️  /build - Skipped (no changes detected)
   ```

3. Highlight important findings:
   - Major structural changes
   - New technologies or frameworks detected
   - Removed or deprecated components
   - Folders needing manual review
4. Provide actionable next steps:
   - Custom sections that may need updating
   - Detected inconsistencies to review
   - Suggestions for improving documentation
   - Maintenance recommendations

**Expected Output**:
Comprehensive summary report showing all actions taken, changes detected, and recommendations for maintaining documentation quality.

---

## How to Use This Command

Run this command with: `/folder-readme [folder-path] [options]`

This command automatically creates and maintains README files for your project folders, detecting changes and keeping documentation current.

Examples:

- `/folder-readme` - Generate/update README for current folder
- `/folder-readme ./src --recursive` - Process src folder and all subfolders  
- `/folder-readme . --recursive --update-only` - Update only existing READMEs recursively
- `/folder-readme ./docs --update-changelog=false` - Update README only, skip CHANGELOG

The command intelligently:

- Detects changes since last documentation update
- Preserves custom content when updating
- Updates CHANGELOG.md with significant changes
- Creates consistent, current documentation
- Analyzes folder purpose from contents

This ensures your documentation stays synchronized with your actual folder structure and contents.