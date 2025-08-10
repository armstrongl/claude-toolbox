---
name: extract-examples
description: Extract code blocks from markdown files and compile them into a comprehensive reference document with table of contents and descriptive headings.
argument-hint: <directory> [--language <lang>] [--output <filename>]
allowed-tools: Read, Write, Glob, Task, MultiEdit
auto-execute: true
parameters:
  - name: directory
    type: string
    required: true
    description: Directory containing markdown files to extract examples from
  - name: language
    type: string
    required: false
    default: all
    description: Specific language identifier to extract (e.g., python, javascript, dataview) or 'all' for all code blocks
  - name: output
    type: string
    required: false
    default: EXAMPLES.md
    description: Output filename for the compiled examples document
  - name: descriptive_headings
    type: boolean
    required: false
    default: true
    description: Whether to analyze code and create descriptive headings instead of generic ones
author: Larah
version: 1.0.0
tags: documentation, code-extraction, markdown, reference-generation
---

This command extracts code blocks from markdown files in a specified directory and compiles them into a single, well-organized reference document. It's particularly useful for creating comprehensive example collections from documentation, tutorial files, or code sample repositories.

## Process

1. **Scan the target directory for markdown files**
   Use the Glob tool to find all markdown files (*.md) in the specified directory. If the directory contains subdirectories, include them in the scan to ensure comprehensive extraction.

2. **Analyze the structure and content**
   Use the Task tool with the advanced-file-analyzer agent to understand the overall structure of the markdown files, identify patterns in how code examples are organized, and determine the types of code blocks present. This analysis helps create a more intelligent extraction and organization strategy.

3. **Extract code blocks from each file**
   For each markdown file found:
   - Read the file content using the Read tool
   - Identify all code blocks based on the language parameter:
     - If language is "all", extract all code blocks regardless of language identifier
     - If a specific language is provided, only extract blocks with that identifier
   - Preserve the exact formatting and content of each code block
   - Note the source file and position of each example
   - Identify any labels or descriptions associated with the code blocks

4. **Create the reference document structure**
   Begin building the output document with:
   - A descriptive header explaining that this is a comprehensive code example reference
   - A brief description of what the document contains and how it was generated
   - The total count of examples extracted and files processed

5. **Generate a table of contents**
   Create a clickable table of contents that:
   - Lists each source file as a section
   - Uses markdown link formatting to enable navigation
   - Shows the file path relative to the scanned directory
   - Optionally includes a count of examples per file

6. **Organize examples by source file**
   For each source file containing code examples:
   - Create a section with the filename as a heading (use ## level)
   - If multiple code blocks exist in the file, number them or use descriptive headings
   - Preserve the language identifier for syntax highlighting
   - Maintain the original order of examples as they appeared in the source

7. **Apply descriptive headings if enabled**
   If descriptive_headings parameter is true:
   - Use the Task tool with advanced-file-analyzer to analyze each code block
   - Generate meaningful headings that describe what each example demonstrates
   - Replace generic headings like "Example 1" with descriptive ones like "Calculate Sum of Values"
   - Ensure consistency in heading format across the document

8. **Format the final document**
   Ensure the output document has:
   - Proper markdown formatting with correct heading levels
   - Code blocks with appropriate language identifiers for syntax highlighting
   - Clear separation between different sections
   - Consistent spacing and structure throughout
   - Clickable navigation if table of contents was generated

9. **Save the compiled document**
   Write the complete reference document to the specified output file (default: EXAMPLES.md) in the current working directory or specified location. Include a note at the end indicating when the extraction was performed and from which directory.

10. **Provide extraction summary**
    After saving, report to the user:
    - Total number of files processed
    - Total number of code examples extracted
    - Types of code languages found (if analyzing all)
    - Location of the output file
    - Any files that were skipped or had issues

## Special Considerations

- **Large directories**: For directories with many files, use the Task tool to handle the extraction in batches to avoid memory issues
- **Nested code blocks**: Handle edge cases where code blocks might contain markdown syntax
- **Inline code**: Optionally extract inline code snippets (single backtick) if they represent complete examples
- **Code block metadata**: Preserve any additional metadata like line numbers, highlighting, or titles if present
- **Empty files**: Skip files that don't contain any code blocks matching the criteria
- **Naming conflicts**: If extracting from multiple directories, ensure source file paths are clearly distinguished

---

## How to Use This Command

Run this command with: `/extract-examples <directory> [--language <lang>] [--output <filename>]`

This command scans a directory for markdown files, extracts all code blocks (or those matching a specific language), and compiles them into a single reference document with a table of contents and descriptive headings.

Examples:

- `/extract-examples ./docs` - Extract all code examples from the docs directory
- `/extract-examples ./tutorials --language python` - Extract only Python code blocks from tutorials
- `/extract-examples ./examples --output ALL_EXAMPLES.md` - Extract all examples to a custom filename
- `/extract-examples "20 Dataview Queries" --language dataview --output DATAVIEW_REFERENCE.md` - Extract DataView queries to a specific file

The command will create a comprehensive reference document containing:

- A table of contents linking to each source file's section
- All extracted code blocks organized by their source file
- Descriptive headings for each code example (when enabled)
- Preserved code formatting and syntax highlighting

Note: The command operates relative to your current working directory. Ensure you have write permissions for creating the output file. Large directories with many files may take some time to process.
