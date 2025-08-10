---
name: generate-readme
description: Generates a comprehensive, professional README file for any repository, project, or subfolder following industry best practices and documentation psychology principles.
argument-hint: [path]
allowed-tools: Bash(git:*), Bash(npm:*), Bash(yarn:*), Bash(pip:*), Bash(cargo:*), Edit, Read, Write, MultiEdit, Grep, Glob, Task, WebFetch, WebSearch, LS
thinking-mode: deep
auto-execute: false
parameters:
  - name: path
    type: string
    required: false
    default: .
    description: Path to the repository, project, or subfolder to analyze (defaults to current directory)
  - name: style
    type: string
    required: false
    default: comprehensive
    description: README style - comprehensive, minimal, or technical
  - name: audience
    type: string
    required: false
    default: developers
    description: Primary target audience - developers, executives, or mixed
author: Larah
version: 1.0.0
tags: documentation, readme, automation, best-practices, marketing
---

CRITICAL: You are about to generate a perfect README that serves as the front door to a project. This README must accomplish three objectives: quickly communicate value, lower the barrier to entry, and build confidence through professionalism.

Begin by launching the readme-expert agent to leverage specialized documentation expertise for creating a world-class README. Use the Task tool with subagent_type: readme-expert to analyze the project and generate initial README structure and content recommendations.

## Phase 1: Project Analysis and Understanding

First, perform a comprehensive analysis of the target directory specified in the path parameter. Read key files to understand the project's nature, purpose, and architecture. Search for existing documentation, configuration files, and code structure.

Examine these critical files if they exist:

1. Any existing README files to understand current documentation.
2. Package configuration files (package.json, Cargo.toml, pyproject.toml, go.mod) to identify the technology stack and dependencies.
3. Configuration files (.env.example, config files) to understand setup requirements.
4. License file to determine licensing terms.
5. Contributing guidelines or code of conduct files.
6. Source code entry points (main files, index files) to understand project structure.
7. Test files to understand testing approach.
8. CI/CD configuration files to understand build and deployment processes.

Analyze the codebase structure to determine:

- Primary programming language and frameworks.
- Project type (library, application, CLI tool, API, etc.).
- Key features and functionality.
- Target audience and use cases.
- Development status and maturity.

## Phase 2: Information Architecture Design

Based on your analysis, design the README's information architecture following the conversion funnel principle: awareness, interest, consideration, trial, and adoption.

Structure the README with these essential sections in order:

1. Project banner or logo (visual hook).
2. Compelling one-line description (tagline).
3. Badge section (social proof and technical credentials).
4. Problem statement (the why before the what).
5. Solution overview (what the project does).
6. Key features (benefits, not just features).
7. Quick start guide (five-minute rule).
8. Installation instructions (progressive disclosure).
9. Usage examples (storytelling through code).
10. API reference or documentation links.
11. Configuration options.
12. Contributing guidelines.
13. License and credits.
14. Community and support information.

## Phase 3: Content Generation

### Opening Section Creation

Create a compelling opening that captures attention within seconds. Generate or suggest a project logo or banner image. Write a single-sentence tagline that is specific yet broad enough for the target audience.

Generate appropriate badges based on the project:

- Build status (if CI/CD exists).
- Test coverage (if tests exist).
- Version or release badges.
- License badge.
- Download/star statistics (for existing projects).
- Documentation status.
- Language/framework version compatibility.

### Problem and Solution Articulation

Write the problem statement using concrete scenarios, not abstract descriptions. Use specific examples that readers will recognize from their own experience. Explain why existing solutions fall short and why this project needs to exist.

Present the solution by explaining what users can accomplish, not just what features exist. Transform technical features into user benefits. Use clear, jargon-free language accessible to the broadest possible audience.

### Quick Start Guide Creation

Create a quick start section following the five-minute rule. Provide the absolute shortest path from zero to experiencing value. Use copy-pasteable code that works without modification. Include working defaults or demo modes that don't require configuration.

Write sequential steps that are:

1. Immediately actionable.
2. Guaranteed to work.
3. Demonstrative of core value.
4. Free from unnecessary complexity.
5. Building confidence through early success.

### Code Examples and Usage

Create code examples that tell a story with clear beginning, middle, and end. Include comments that explain why, not what. Provide multiple examples that build upon each other, demonstrating progressive enhancement.

Format examples for maximum clarity:

- Syntax highlighting.
- Consistent indentation.
- Descriptive variable names.
- Realistic but simple scenarios.
- Expected output included.

### Progressive Disclosure Implementation

Implement progressive disclosure throughout the document. Start with simple use cases, then reveal complex scenarios. Use collapsible HTML details elements for advanced topics. Organize information so readers can exit when they have what they need.

Create sections like:

- Basic usage (always visible).
- Advanced configuration (collapsible).
- Alternative installation methods (collapsible).
- Troubleshooting (collapsible).
- API reference details (linked or collapsible).

## Phase 4: Visual Enhancement

Include visual proof of the project's functionality. For applications, include screenshots of key interfaces. For CLI tools, include terminal recordings or output examples. For libraries, show code execution GIFs. For APIs, include request/response examples.

Position visuals strategically:

- First visual immediately after the tagline.
- Screenshots in feature descriptions.
- GIFs in usage examples.
- Diagrams for architecture explanation.

## Phase 5: Trust Building

Build trust through transparency about:

- Project maturity and stability.
- Known limitations or unsuitable use cases.
- Maintenance commitment and response times.
- Security considerations.
- Performance characteristics.
- Compatibility requirements.

Include community elements:

- Links to discussions or forums.
- Contribution guidelines.
- Code of conduct.
- Support channels.
- Roadmap or future plans.

## Phase 6: Optimization and Polish

Optimize for different audiences by using clear section headers that allow scanning. Provide executive summaries for decision-makers. Include technical details for implementers. Add deployment guides for DevOps teams.

Ensure the README works as both:

- A linear narrative for first-time readers.
- A reference document for returning users.
- A marketing document that sells the project.
- A technical guide that enables implementation.

Apply final polish:

- Check all links work correctly.
- Verify code examples are accurate.
- Ensure consistent formatting throughout.
- Proofread for clarity and correctness.
- Validate markdown syntax.
- Optimize images for web viewing.

## Phase 7: File Generation

Write the complete README.md file to the target directory. If a README already exists, create a backup first (README.md.backup). Ensure proper markdown formatting with appropriate heading levels. Include table of contents for longer documents.

After creating the README, verify its effectiveness by checking:

- Does it answer "Is this relevant to my needs?" immediately?
- Can someone get started within five minutes?
- Does it build confidence through professionalism?
- Is information progressively disclosed?
- Are different audiences served appropriately?

Generate a summary report indicating:

- Sections created.
- Key features highlighted.
- Improvements over existing documentation.
- Suggestions for additional documentation needs.
- Recommended visual assets to create.

Remember: The README is the front door to the project. It deserves the same care as the code itself. A great README doesn't just document; it advocates, teaches, and builds community.

---

## How to Use This Command

Run this command with: `/generate-readme [path]`

This command analyzes a repository, project, or subfolder and generates a comprehensive, professional README following industry best practices and documentation psychology principles.

Examples:

- `/generate-readme` - Generates README for current directory
- `/generate-readme /path/to/project` - Generates README for specified project
- `/generate-readme . --style minimal` - Creates a minimal README
- `/generate-readme . --audience executives` - Optimizes for executive readers

The command will:

1. Analyze your project structure and code
2. Identify key features and purposes
3. Generate appropriate badges and visuals
4. Create compelling, well-structured documentation
5. Include all essential sections following best practices
6. Optimize for your target audience

Note: If a README already exists, it will be backed up before the new one is created.
