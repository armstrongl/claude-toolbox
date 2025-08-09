---
name: enhance
description: Transform user requests into comprehensive, actionable prompts with clear context and success criteria
argument-hint: <request-description>
allowed-tools: Read, Glob, WebSearch, ExitPlanMode
auto-execute: true
thinking-mode: deep
clear-before: true
author: Larah
version: 2.0.0
tags: prompt-engineering, enhancement, requirements
---

You will transform the user's request into a comprehensive, well-structured prompt that provides clear guidance for task execution. This process extracts implicit requirements, adds necessary context, and defines measurable success criteria.

## Step 1: Check for project-specific rules

Search for and read any CLAUDE.md file in the current directory or parent directories to understand project-specific constraints and requirements.

**Instructions**:

1. Use Glob to search for CLAUDE.md files: `**/CLAUDE.md`.
2. If found, read the file and extract rules relevant to the user's request.
3. If not found, note this for later inclusion in the enhanced prompt.

## Step 2: Analyze the original request

Parse the user's input to understand the core task and identify areas that need clarification or expansion.

**Instructions**:

1. Identify the primary action or goal.
2. Note any ambiguous terms or implied requirements.
3. Consider what context would help someone execute this task effectively.
4. Think about potential edge cases or failure modes.

## Step 3: Generate the enhanced prompt

Create a structured prompt using the following template. Each section serves a specific purpose in guiding task execution.

**Instructions**:

1. Write a Context section (3-5 sentences) that explains:
   - The background situation or problem being addressed.
   - Why this task is important or needed.
   - Any constraints, deadlines, or special considerations.

2. Create a Requirements section (5-10 items) that lists:
   - Specific, actionable steps to complete the task.
   - Validation checks to ensure quality.
   - Error handling for common failure cases.
   - Any necessary setup or prerequisites.

3. Include a Project Rules section that either:
   - Lists relevant rules from CLAUDE.md if found.
   - States "No project-specific rules found" if no CLAUDE.md exists.

4. Define Success Criteria (3-5 items) that specify:
   - Measurable outcomes that indicate task completion.
   - Quality standards that must be met.
   - Verification methods to confirm success.

## Step 4: Present the enhanced prompt

Use ExitPlanMode to present the enhanced prompt to the user. Structure it exactly as follows:

```markdown
### Context

[Your context paragraph here]

### Requirements

- [Requirement 1]
- [Requirement 2]
- [Continue for all requirements]

### Project Rules

[Either project rules or "No project-specific rules found"]

### Success Criteria

- [Criterion 1]
- [Criterion 2]
- [Continue for all criteria]
```

Ensure each section provides valuable guidance without unnecessary complexity. The enhanced prompt should be comprehensive enough for any AI or human to execute the task successfully, yet concise enough to remain focused and actionable.

---

## How to Use This Command

Run this command with: `/enhance <request-description>`

This command takes any request or task description and transforms it into a comprehensive, structured prompt with clear context, requirements, and success criteria.

Examples:

- `/enhance "fix the login bug"`
- `/enhance "create a new feature for user notifications"`
- `/enhance "optimize database queries"`

The enhanced prompt will include project-specific rules from CLAUDE.md if available, making it perfect for maintaining consistency across your project.
