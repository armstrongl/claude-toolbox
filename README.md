# Claude Toolbox 🧰

A collection of Claude Code agents, commands, scripts, templates, notes, and other bits and bobs.

[![Agents](https://img.shields.io/badge/Agents-22-blue)](./agents)
[![Commands](https://img.shields.io/badge/Commands-16-green)](./commands)
[![Templates](https://img.shields.io/badge/Templates-4-purple)](./templates)
[![Hooks](https://img.shields.io/badge/Hooks-0-orange)](./hooks)

## 🤖 Specialized Agents

| Agent | Description |
|-------|-------------|
| [Adult Learning Theory Expert](agents/adult-learning-theory-expert.md) | Specializes in educational methodologies and adult learning principles for technical documentation and training materials. |
| [Agent Creator](agents/agent-creator.md) | Helps design and build new specialized agents with appropriate expertise and capabilities. |
| [Bash Automation Expert](agents/bash-automation-expert.md) | Provides guidance on shell scripting, automation workflows, and command-line tool development. |
| [Blooms Taxonomy Expert](agents/blooms-taxonomy-expert.md) | Applies educational taxonomy frameworks to structure learning objectives and content organization. |
| [Changelog Manager](agents/changelog-manager.md) | Assists with version control documentation, release notes, and change tracking. |
| [Changelog Master](agents/changelog-master.md) | Advanced changelog creation and management with best practices and automation strategies. |
| [Claude MD Compliance Checker](agents/claude-md-compliance-checker.md) | Ensures documentation follows Claude's markdown formatting and compliance requirements. |
| [CLI Developer](agents/cli-developer.md) | Specializes in command-line interface design, user experience, and tool development. |
| [Code Quality Pragmatist](agents/code-quality-pragmatist.md) | Balances code quality standards with practical development constraints and team productivity. |
| [Design Thinking Expert](agents/design-thinking-expert.md) | Applies human-centered design methodologies to software architecture and user experience. |
| [Docs Dependency Manager](agents/docs-dependency-manager.md) | Manages documentation dependencies, cross-references, and content relationships. |
| [File Topic Analyzer](agents/file-topic-analyzer.md) | Analyzes file content to identify topics, themes, and content organization opportunities. |
| [Git Workflow Manager](agents/git-workflow-manager.md) | Provides guidance on Git workflows, branching strategies, and repository management. |
| [Knowledge Synthesizer](agents/knowledge-synthesizer.md) | Combines information from multiple sources to create comprehensive, coherent documentation. |
| [Lateral Thinking Expert](agents/lateral-thinking-expert.md) | Applies creative problem-solving approaches to technical challenges and system design. |
| [Paul Elder Framework Expert](agents/paul-elder-framework-expert.md) | Uses critical thinking frameworks to analyze problems and evaluate solutions. |
| [Python Engineer](agents/python-engineer.md) | Specializes in Python development, best practices, and code architecture. |
| [Readme Expert](agents/readme-expert.md) | Creates comprehensive, user-friendly README files and project documentation. |
| [Simplex Thinking Expert](agents/simplex-thinking-expert.md) | Applies systematic problem-solving methodologies to complex technical challenges. |
| [Software Architect](agents/software-architect.md) | Provides guidance on system design, architecture patterns, and technical decision-making. |
| [TypeScript Engineer](agents/typescript-engineer.md) | Specializes in TypeScript development, type systems, and modern JavaScript practices. |
| [Ultrathink Debugger](agents/ultrathink-debugger.md) | Advanced debugging methodologies and systematic problem-solving approaches. |

## 💬 Custom Commands

| Command | Description |
|---------|-------------|
| [Analyze Repo Changes Update Docs](commands/analyze-repo-changes-update-docs.md) | Analyzes repository changes and automatically updates relevant documentation. |
| [Create Agent](commands/create-agent.md) | Generates new specialized agent files with appropriate structure and capabilities. |
| [Create Bash Script](commands/create-bash-script.md) | Creates shell scripts with proper error handling, documentation, and best practices. |
| [Create Command](commands/create-command.md) | Generates new command files with standardized structure and functionality. |
| [Create Prompt](commands/create-prompt.md) | Creates prompt templates for consistent AI interactions and workflows. |
| [Create Python Script](commands/create-python-script.md) | Generates Python scripts with proper structure, error handling, and documentation. |
| [Enhance](commands/enhance.md) | Improves existing content by applying best practices and optimization techniques. |
| [Extract Essential Information](commands/extract-essential-information.md) | Pulls key information from content to create summaries and highlights. |
| [Extract Examples](commands/extract-examples.md) | Identifies and extracts code examples and usage patterns from documentation. |
| [Folder Readme](commands/folder-readme.md) | Generates README files for folders to improve navigation and understanding. |
| [Generate Readme](commands/generate-readme.md) | Creates comprehensive README files for projects and repositories. |
| [Git Repo Info](commands/git-repo-info.md) | Extracts and displays repository information and statistics. |
| [Improve Command](commands/improve-command.md) | Enhances existing commands with better functionality and user experience. |
| [Update Agent](commands/update-agent.md) | Updates agent files with new capabilities or improved functionality. |
| [Update Command](commands/update-command.md) | Modifies existing commands to add features or fix issues. |
| [Update Script](commands/update-script.md) | Updates script files with improvements and bug fixes. |

## 🧩 Templates

| Template | Description |
|----------|-------------|
| [Agent Template](templates/agent.md) | Comprehensive framework for building specialized agents with consistent structure and capabilities. |
| [Command Template](templates/command.md) | Standardized structure for creating new command files with proper formatting and organization. |
| [Hook Template](templates/hook.md) | Template for creating Git hooks and automation workflows. |
| [Prompt Template](templates/prompt.md) | Template for creating consistent AI prompt structures and interactions. |

## 🤝 Contributing

The Claude Toolbox thrives through community contributions that expand its capabilities and refine existing features. Every contribution, whether a major feature or minor documentation improvement, strengthens the ecosystem for all users. Contributors bring diverse perspectives and use cases that enrich the toolbox beyond what any individual could envision.

### Ways to Contribute

Multiple avenues exist for contributing to the toolbox, each valuable in its own right. Technical contributions might involve creating new agents or enhancing commands, while non-technical improvements could focus on documentation clarity or example scenarios. The variety of contribution types ensures everyone can participate regardless of their specific expertise.

1. **New Agents**: Add specialized expertise for new domains.
2. **Command Improvements**: Enhance existing commands or create new ones.
3. **Documentation**: Improve guides and examples.
4. **Bug Fixes**: Report and fix issues.
5. **Best Practices**: Share your successful patterns.

### Contribution Process

A structured contribution process ensures quality while minimizing friction for contributors. Clear steps guide contributors from initial idea through successful integration, with checkpoints that maintain toolbox standards. This process balances thoroughness with efficiency, welcoming new contributions while preserving existing functionality.

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/amazing-agent`).
3. Follow the template structure for new additions.
4. Test your changes thoroughly.
5. Submit a pull request with clear description.

## 🛠️ Installation Options

Setting up the Claude Toolbox requires minimal configuration, with multiple installation paths available to suit different preferences. Automated installation handles most setup tasks, while manual installation provides complete control over the process. Both approaches result in the same functional configuration, differing only in the level of user involvement required.

```bash
# Clone and set up
git clone https://github.com/your-username/claude-toolbox.git
cd claude-toolbox
./scripts/install.sh  # Coming soon
```

### Manual Installation

For those preferring direct control over installation, manual setup involves creating the necessary directory structure and copying components into place. This approach allows selective installation of specific components or custom directory locations. The process remains straightforward despite being manual, requiring only basic file system operations.

```bash
# Create Claude configuration directories
mkdir -p ~/.claude/{agents,commands,templates}

# Copy components
cp -r agents/* ~/.claude/agents/
cp -r commands/* ~/.claude/commands/
cp -r templates/* ~/.claude/templates/
```

## 💡 Tips & Tricks

Effective toolbox usage patterns emerge through experience, though certain principles accelerate mastery. Understanding when agents activate automatically versus requiring explicit invocation prevents unnecessary specification. Similarly, recognizing repetitive patterns that benefit from command automation transforms workflows from reactive to proactive.

1. **Let Agents Auto-Engage**: Don't specify agents manually since they activate when needed.
2. **Use Commands for Repetition**: If you do something twice, there's probably a command for it.
3. **Combine Tools**: Chain commands and agents for powerful workflows.
4. **Trust the Expertise**: Agents use proven methodologies worth following their guidance.
5. **Customize for Your Needs**: Create agents for your specific domain or tech stack.

## Common Patterns

Real-world usage patterns demonstrate the toolbox's versatility across different development scenarios. Morning workflows might combine repository analysis with change review, while feature development engages multiple agents collaborating seamlessly. These patterns showcase how individual tools compose into comprehensive solutions that address complex development challenges efficiently.

```bash
# Morning workflow
claude "/git-repo-info && Review yesterday's changes"

# Feature development
claude "Implement user authentication" # Multiple agents collaborate

# Code review preparation
claude "/enhance ./src && /folder-readme ./src"

# Quick fixes
claude "Debug this TypeScript error" # Ultrathink debugger engages
```

---

*Built with ❤️ by noobs, for noobs.*
