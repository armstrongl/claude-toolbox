---
name: update-agent
description: Update existing Claude sub-agents to conform to the standardized agent template format while preserving their core functionality and custom content.
argument-hint: <agent-name-or-path>
allowed-tools: Read, Write, Edit, MultiEdit, Glob, Task, LS
auto-execute: false
thinking-mode: deep
parameters:
  - name: agent_identifier
    type: string
    required: true
    description: Name of the agent (without .md) or full path to the agent file.
  - name: backup
    type: boolean
    required: false
    default: true
    description: Create a backup of the original agent file before updating.
  - name: preserve_custom
    type: boolean
    required: false
    default: true
    description: Preserve custom sections not in the standard template.
  - name: agents_dir
    type: string
    required: false
    default: /Users/larah/.claude/agents/
    description: Directory where agents are stored.
author: Larah
version: 1.0.0
tags: agent-update, standardization, template-conformance, refactoring
---

You are Claude Code. You will update an existing Claude sub-agent to conform to the standardized agent template format from `/Users/larah/.claude/templates/agent.md`. The update process preserves the agent's core functionality while restructuring it to match the template's organization and format.

## Step 1: Locate and read the agent file

Determine the agent file to update:

1. If the agent_identifier is a full path and ends with .md, use it directly.
2. If it's just a name, construct the path: `${agents_dir}${agent_identifier}.md`.
3. Verify the file exists using the LS tool.
4. If the file doesn't exist, check for similar names using Glob in the agents directory.
5. Read the entire agent file content.

## Step 2: Create backup if requested

If backup parameter is true:

1. Create a backup filename: `${original_filename}.backup-${timestamp}.md`.
2. Copy the original content to the backup file.
3. Inform the user of the backup location.

## Step 3: Parse existing agent structure

Analyze the current agent file to extract:

1. **Metadata from frontmatter**:
   - Extract name, description, examples, model, and color if present.
   - Note any custom frontmatter fields for preservation.

2. **Role and expertise statements**:
   - Identify introductory statements about the agent's role.
   - Look for expertise claims and specialization descriptions.

3. **Philosophy or principles**:
   - Find sections describing beliefs, values, or approaches.
   - Extract bullet points or numbered lists of principles.

4. **Methodology or process**:
   - Identify step-by-step processes or phases.
   - Extract action items and specific steps.

5. **Tools and techniques**:
   - Find mentions of specific tools, utilities, or approaches.
   - Extract toolkit items or technical capabilities.

6. **Working principles**:
   - Identify how the agent approaches tasks.
   - Extract execution strategies and quality standards.

7. **Output formatting**:
   - Find preferences for structuring results.
   - Extract formatting guidelines.

8. **Scenario adaptations**:
   - Identify context-specific behaviors.
   - Extract conditional approaches.

9. **Communication style**:
   - Find interaction patterns and explanation approaches.
   - Extract documentation standards.

10. **Critical rules**:
    - Identify non-negotiable principles.
    - Extract safety and quality standards.

11. **Custom content**:
    - Identify any sections not matching standard categories.
    - Mark for preservation if preserve_custom is true.

## Step 4: Map content to template structure

Load the template from `/Users/larah/.claude/templates/agent.md` and map extracted content:

1. **Frontmatter mapping**:
   - Ensure name is in kebab-case.
   - Format description to start with "Use this agent when...".
   - Add "USE PROACTIVELY" if found in original or appropriate.
   - Create or enhance examples with context, user message, assistant response, and commentary.
   - Set appropriate model based on complexity.
   - Choose or preserve terminal color.

2. **Role definition mapping**:
   - Construct role statement from extracted expertise.
   - Create superlative expertise claim if missing.
   - Identify and set the domain field.

3. **Philosophy section**:
   - Map existing principles to 5-7 philosophy items.
   - Ensure each principle is a complete thought.
   - Add missing fundamental beliefs if needed.

4. **Methodology section**:
   - Organize existing process into 3-5 clear phases.
   - Name each phase descriptively.
   - Ensure 4-6 specific steps per phase.
   - Make steps concrete and actionable.

5. **Toolkit section**:
   - List 6-10 specific tools or techniques.
   - Include both technical tools and mental models.
   - Preserve all valuable tools from original.

6. **Working Principles**:
   - Extract 5-6 execution principles.
   - Focus on how tasks are approached.
   - Ensure principles are actionable.

7. **Output Preferences**:
   - Map formatting preferences to 5-6 items.
   - Include structure and organization preferences.
   - Add standard preferences if missing.

8. **Scenario Adaptations**:
   - Create 4-5 scenario-specific adaptations.
   - Map existing conditional behaviors.
   - Add common scenarios if missing.

9. **Communication Style**:
   - Extract 5-6 communication principles.
   - Include explanation and documentation approaches.
   - Ensure clarity in user interaction.

10. **Critical Principles**:
    - List 5-7 non-negotiable rules.
    - Include safety and quality standards.
    - Preserve all critical rules from original.

11. **Closing Statement**:
    - Create or adapt motivational closing.
    - Reinforce agent's commitment and approach.

## Step 5: Handle gaps and missing content

For any template sections without corresponding original content:

1. **Infer from context**:
   - Use the agent's name and description to infer missing sections.
   - Generate appropriate content based on the agent's purpose.
   - Maintain consistency with existing content tone.

2. **Apply intelligent defaults**:
   - Add standard best practices for the domain.
   - Include common methodologies for the agent type.
   - Use typical communication patterns.

3. **Mark generated content**:
   - Keep track of which sections were generated vs. extracted.
   - Ensure generated content aligns with original intent.

## Step 6: Preserve custom content

If preserve_custom is true:

1. Identify sections in the original not in the template.
2. Determine the best location for custom content:
   - After the main template sections.
   - Or integrated into the most relevant section.
3. Add a separator comment: `## Additional Custom Content`.
4. Include the custom sections with original formatting.

## Step 7: Format and validate

Ensure the updated agent:

1. **Follows template structure exactly**:
   - Correct frontmatter format.
   - All required sections present.
   - Proper markdown formatting.

2. **Maintains consistency**:
   - Terminology consistent throughout.
   - Tone and style unified.
   - No contradictions between sections.

3. **Preserves functionality**:
   - All original capabilities represented.
   - No loss of important instructions.
   - Enhanced clarity and organization.

## Step 8: Write the updated agent file

Save the updated agent:

1. Write the new content to the original file path.
2. Verify the write was successful.
3. If there were errors, restore from backup if available.

## Step 9: Generate update report

Provide the user with a comprehensive report:

1. **Summary of changes**:
   - Sections added or restructured.
   - Content that was preserved.
   - Any custom content retained.

2. **Improvements made**:
   - Enhanced organization.
   - Clarified instructions.
   - Standardized formatting.

3. **Validation results**:
   - Confirmation of template conformance.
   - Any warnings or notes.
   - Backup file location if created.

4. **Testing suggestions**:
   - Key functionalities to verify.
   - Scenarios to test.
   - Comparison points with original behavior.

---

## How to Use This Command

Run this command with: `/update-agent <agent-name-or-path>`

This command updates existing Claude sub-agents to conform to the standardized template from `/Users/larah/.claude/templates/agent.md` while preserving their core functionality.

Examples:

- `/update-agent typescript-engineer` - Updates the typescript-engineer agent to match the template
- `/update-agent /custom/path/my-agent.md` - Updates an agent at a specific path
- `/update-agent code-reviewer --backup false` - Updates without creating a backup
- `/update-agent researcher --preserve_custom false` - Updates and removes non-standard sections

The command will:

1. Read your existing agent configuration
2. Parse and extract all relevant content
3. Map it to the standardized template structure
4. Fill any gaps with intelligent defaults
5. Preserve custom sections (if requested)
6. Create a backup before updating (by default)

Parameters:

- `agent_identifier`: The agent name or full path (required)
- `backup`: Whether to create a backup file (default: true)
- `preserve_custom`: Whether to keep non-standard sections (default: true)
- `agents_dir`: Directory where agents are stored (default: /Users/larah/.claude/agents/)

Note: The update process is designed to be non-destructive. Your agent's core functionality will be preserved while gaining better organization and standardization.
