---
name: create-prompt
description: Generate optimized AI prompts for Claude Code with prompt engineering best practices.
argument-hint: <prompt-purpose>
allowed-tools: Bash(mkdir*), Edit, Read, Write, Task
auto-execute: false
thinking-mode: deep
parameters:
  - name: prompt_name
    type: string
    required: true
    description: Filename for the prompt (without .md extension).
  - name: complexity
    type: string
    required: false
    default: standard
    description: Complexity level - simple, standard, or advanced.
  - name: output_dir
    type: string
    required: false
    default: ~/.claude/prompts/
    description: Directory to save the prompt file.
author: Larah
version: 1.0.0
tags: prompt-engineering, ai-tools, automation
---

You are Claude Code. You will generate a highly optimized AI prompt based on the user's requirements. The prompt must implement modern prompt engineering and context engineering best practices.

## Step 1: Parse the prompt purpose

Analyze the user's prompt purpose to understand:

- The main objective or task the prompt should accomplish.
- The target audience or use case.
- Any specific constraints or requirements.
- The desired output format or style.

## Step 2: Ensure output directory exists

Create the output directory if it doesn't exist:

1. Check if the specified output directory exists.
2. If not, create it using: `mkdir -p ${output_dir}`

## Step 3: Generate the optimized prompt

Create a prompt that follows these essential principles:

1. **Structure and clarity**:
   - Begin with a clear role definition ("You are...").
   - State the primary objective explicitly.
   - Break complex tasks into numbered steps.
   - Use complete sentences throughout.
   - End all list items with periods.

2. **Precision and specificity**:
   - Use precise, action-oriented language.
   - Avoid ambiguous terms like "maybe," "possibly," or "could."
   - Define all technical terms and acronyms.
   - Specify exact formats for outputs.

3. **Context engineering**:
   - Include relevant background information.
   - Provide examples of desired outputs.
   - Specify edge cases and how to handle them.
   - Include constraints and boundaries.

4. **Modern AI optimization**:
   - Use chain-of-thought prompting for complex reasoning.
   - Include few-shot examples where appropriate.
   - Structure information hierarchically.
   - Use markdown formatting for readability.

5. **Supplementary information**:
   - Add a "Key principles" section for important guidelines.
   - Include a "Common pitfalls" section if relevant.
   - Provide resource links or references.
   - Add usage notes or tips.

## Step 4: Format the prompt file

Structure the prompt file with these sections:

```markdown
# ${prompt_name}

## Purpose

[Clear statement of what this prompt accomplishes]

## Prompt

[The main prompt text following all best practices]

## Usage Notes

- When to use this prompt.
- Expected inputs and outputs.
- Any prerequisites or setup required.

## Examples

### Example 1: [Scenario]

Input: [Sample input]
Expected Output: [Sample output]

### Example 2: [Different scenario]

Input: [Sample input]
Expected Output: [Sample output]

## Configuration

- Complexity level: ${complexity}
- Best suited for: [Use cases]
- Not recommended for: [Anti-patterns]
```

## Step 5: Save the prompt file

Write the generated prompt to: `${output_dir}${prompt_name}.md`

Confirm successful creation and provide the user with:

1. The full path to the created prompt file.
2. A brief summary of the prompt's purpose.
3. Suggestions for testing or using the prompt.

---

## How to Use This Command

Run this command with: `/create-prompt <prompt-purpose>`

This command generates optimized AI prompts for Claude Code, implementing prompt engineering best practices.

Examples:

- `/create-prompt "Generate a prompt for code review and analysis"`
- `/create-prompt "Create a prompt for writing comprehensive test suites"`
- `/create-prompt "Build a prompt for refactoring legacy code"`

The generated prompt will be saved to `~/.claude/prompts/` by default. You can customize the output directory and complexity level through parameters.

Parameters:

- `prompt_name`: The filename for your prompt (required)
- `complexity`: Choose from simple, standard, or advanced (default: standard)
- `output_dir`: Custom directory path (default: ~/.claude/prompts/)
