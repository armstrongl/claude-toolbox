# Claude Toolbox 🧰

A collection of Claude Code agents, commands, scripts, templates, notes, and other bits and bobs.

[![Agents](https://img.shields.io/badge/Agents-23-blue)](./agents)
[![Commands](https://img.shields.io/badge/Commands-16-green)](./commands)
[![Templates](https://img.shields.io/badge/Templates-4-purple)](./templates)
[![Hooks](https://img.shields.io/badge/Hooks-0-orange)](./hooks)

## 🤖 Specialized Agents

Expert agents provide domain-specific knowledge and methodologies for various development and documentation tasks. These agents cover areas like software architecture, Python/TypeScript development, CLI tools, documentation strategy, learning theory, and critical thinking frameworks. Each agent brings specialized expertise to help solve specific problems rather than providing generic assistance.

## 💬 Custom Commands

Commands automate common development and documentation tasks to improve productivity. These include creating scripts, commands, and prompts, updating existing components, generating folder documentation, and extracting essential information from content. Each command streamlines repetitive workflows while maintaining quality and consistency.

## 🧩 Templates

Templates provide standardized structures for creating new components consistently. The agent template offers a comprehensive framework for building specialized agents, while other templates (command, hook, prompt) provide starting points for different types of extensions. These templates help maintain consistency and quality across the toolbox.

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
