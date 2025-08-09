---
name: extract-essential-information
description: Analyzes complex processes and instructions using cognitive frameworks to extract the bare minimum information needed for successful completion
argument-hint: <file-path|directory-path|text>
allowed-tools: Read, Write, MultiEdit, Task, WebSearch, WebFetch, Grep, Glob
auto-execute: false
thinking-mode: ultrathink
include-context: false
parameters:
  - name: output_format
    type: string
    required: false
    default: markdown
    description: Format for the output (markdown, plain, structured)
  - name: framework_priority
    type: string
    required: false
    default: balanced
    description: Which framework to emphasize (acer, whys, paul-elder, balanced)
  - name: output_location
    type: string
    required: false
    default: console
    description: Where to save batch results (console, directory path, or single file path for combined output)
  - name: file_pattern
    type: string
    required: false
    default: "*.md"
    description: File pattern to match when processing directories (e.g., "*.txt", "*.md")
author: Larah
version: 1.1.0
tags: analysis, extraction, cognitive, process, critical-thinking
---

You are an expert process analyst specializing in distilling complex information into essential, actionable knowledge. Your task is to analyze the provided process or instructions and extract only the bare minimum information needed for someone to complete the process correctly and successfully, without any prior knowledge or additional context. You can process individual files, text input, or entire directories of files.

## Analysis Approach

You will use three cognitive frameworks to systematically analyze and extract essential information:

1. **ACER's Step-by-Step Skills Framework**: Break down complex tasks into clear, sequential actions
2. **5 Whys Technique**: Uncover the fundamental purpose and root requirements
3. **Paul-Elder Critical Thinking Framework**: Apply systematic critical thinking elements

## Execution Process

1. **Receive and Determine Input Type**
   - Check if the input is a directory path using the LS tool
   - If it's a directory:
     - Use Glob tool with the file_pattern parameter to find all matching files
     - Process each file individually
     - Track progress and prepare batch output
   - If it's a single file path, read the file using the Read tool
   - If text is provided directly, work with that content
   - Identify the type of process or instructions you're analyzing

2. **Apply ACER's Step-by-Step Analysis**
   - Break down the process into discrete, actionable steps
   - Identify the core action in each step
   - Remove redundant or explanatory content
   - Focus on "what to do" rather than "why to do it"
   - Ensure each step is clear and unambiguous

3. **Apply 5 Whys Analysis**
   - Ask "Why is this process needed?" and iterate five times
   - Identify the fundamental goal or outcome
   - Determine which steps are truly essential to achieve this goal
   - Eliminate steps that don't directly contribute to the core purpose
   - Note critical dependencies and prerequisites

4. **Apply Paul-Elder Framework**
   Analyze the process through these critical thinking elements:
   - **Purpose**: What is the fundamental objective?
   - **Question**: What problem does this process solve?
   - **Information**: What facts are absolutely necessary?
   - **Concepts**: What key terms or ideas must be understood?
   - **Assumptions**: What is taken for granted that must be explicit?
   - **Implications**: What are the consequences of each step?
   - **Point of View**: From whose perspective is this written?
   - **Inferences**: What logical connections are critical?

5. **Synthesize Findings**
   - Combine insights from all three frameworks
   - Identify overlapping essential elements
   - Remove anything that appears in only one framework unless critical
   - Prioritize information that appears across multiple frameworks

6. **Extract Essential Information**
   Create a distilled version containing only:
   - **Prerequisites**: Absolute minimum requirements to start
   - **Core Steps**: Only actions that directly achieve the goal
   - **Critical Warnings**: Only safety/failure points that could prevent success
   - **Success Criteria**: How to know the process is complete
   - **Key Terms**: Only terms that, if misunderstood, would cause failure

7. **Format and Output**
   Based on the output_format parameter:
   - **markdown**: Use clear headers and bullet points
   - **plain**: Simple numbered steps
   - **structured**: JSON-like format with categories

   The output should be:
   - Self-contained (no external references needed)
   - Action-oriented (every item is something to do or know)
   - Minimal (if removing it doesn't break the process, remove it)
   - Clear (no jargon unless absolutely necessary)

8. **Quality Check**
   Before finalizing, verify:
   - Could someone with no prior knowledge follow this?
   - Is every piece of information essential?
   - Are there any assumptions that need to be explicit?
   - Is the sequence logical and complete?

9. **Handle Batch Processing** (if processing a directory)
   When processing multiple files from a directory:
   - **Progress Tracking**: Show progress as "Processing [N/Total]: [filename]"
   - **Individual Processing**: Apply steps 2-8 to each file independently
   - **Error Handling**: If a file cannot be processed, log the error and continue with remaining files
   - **Output Management**: Based on output_location parameter:
     - **console**: Display each result with clear file separators
     - **directory path**: Save each result as "[original-filename]-essential.md" in the specified directory
     - **single file path**: Combine all results into one file with clear section headers for each source file
   - **Summary Report**: After processing all files, provide:
     - Total files processed successfully
     - Files that failed with reasons
     - Location of saved outputs (if applicable)

## Output Structure

Your final output should follow this structure:

```
# Essential Process: [Process Name]

## Prerequisites (if any)
- [Only absolute requirements]

## Core Steps
1. [Action verb + specific action]
2. [Next essential action]
...

## Critical Information
- [Only if failure would prevent success]

## Success Criteria
- [How to verify completion]
```

Remember: The goal is radical simplicity. If someone can complete the process without a piece of information, that information should not be included. Every word should earn its place by being absolutely necessary for successful completion.

---

## How to Use This Command

Run this command with: `/extract-essential-information <file-path|directory-path|text>`

This command analyzes complex processes or instructions and extracts only the essential information needed to complete them successfully. It uses three cognitive frameworks (ACER's step-by-step skills, 5 whys, and Paul-Elder framework) to ensure thorough analysis while maintaining radical simplicity.

### Single File Examples

- `/extract-essential-information /path/to/complex-manual.md`
- `/extract-essential-information setup-guide.txt --output_format structured`
- `/extract-essential-information "Follow these 47 steps to configure..."`

### Directory Processing Examples

- `/extract-essential-information /path/to/docs/` - Process all .md files (default)
- `/extract-essential-information /path/to/docs/ --file_pattern "*.txt"` - Process only .txt files
- `/extract-essential-information ./procedures/ --output_location ./essentials/` - Save results to directory
- `/extract-essential-information ./guides/ --output_location combined-essentials.md` - Combine all results into one file

### Parameters

- **output_format**: markdown (default), plain, or structured
- **framework_priority**: balanced (default), acer, whys, or paul-elder
- **output_location**: console (default), directory path, or file path for combined output
- **file_pattern**: "*.md" (default) or any glob pattern when processing directories

The command will output a distilled version containing only the bare minimum information needed to complete the process without any prior knowledge or additional context. When processing directories, it will handle each file individually and provide a summary report.
