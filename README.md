# Claude Toolbox 🧰

> Transform Claude Code from a general-purpose assistant into your personal team of domain experts with specialized agents, automated commands, and battle-tested workflows.

[![Agents](https://img.shields.io/badge/Agents-19-blue)](./agents)
[![Commands](https://img.shields.io/badge/Commands-12-green)](./commands)
[![Templates](https://img.shields.io/badge/Templates-4-purple)](./templates)
[![Hooks](https://img.shields.io/badge/Hooks-0-orange)](./hooks)

## 🎯 Core Components

The Claude Toolbox consists of three fundamental building blocks that work together to enhance productivity and expertise. Each component serves a distinct purpose in the ecosystem, though they frequently collaborate to deliver comprehensive solutions. These tools have been developed through extensive practical application and refined based on real-world usage patterns.

### Specialized Agents

Domain expertise becomes accessible through specialized agents that bring deep knowledge and proven methodologies to every interaction. These agents understand the nuances of their respective fields and apply established best practices automatically. Rather than generic assistance, each agent operates with the depth and precision of a seasoned professional in their domain.

#### 🏗️ Software Engineering Specialists

Software development demands diverse expertise across multiple disciplines, which these specialized agents provide. Each engineering agent brings focused knowledge that addresses specific technical challenges while maintaining awareness of broader architectural considerations. The collection spans from type system mastery to version control automation, ensuring comprehensive coverage of modern development needs.

- **[TypeScript Engineer](./agents/typescript-engineer.md)**: Advanced type systems, React patterns, performance optimization.
- **[Python Engineer](./agents/python-engineer.md)**: Pythonic design, async patterns, testing strategies.
- **[Software Architect](./agents/software-architect.md)**: System design, scalability planning, architectural patterns.
- **[Git Workflow Manager](./agents/git-workflow-manager.md)**: Branching strategies, merge conflict resolution, automation.
- **[CLI Developer](./agents/cli-developer.md)**: Command-line interface design, cross-platform compatibility.

#### 📚 Documentation & Strategy

Clear documentation forms the backbone of successful projects, yet creating it requires specialized knowledge beyond technical writing skills. Documentation strategy encompasses information architecture, user psychology, and content organization principles that make complex systems understandable. These agents apply structured frameworks to ensure documentation serves its intended audience effectively.

- **[Docs Strategy Expert](./agents/docs-strategy-expert.md)**: Information architecture, Diataxis framework, content strategy.
- **[README Expert](./agents/readme-expert.md)**: Converting visitors into users with compelling documentation.

#### 🧠 Thinking & Learning Frameworks

Problem-solving benefits from structured approaches that guide thinking beyond intuitive responses. Various cognitive frameworks offer systematic methods for tackling challenges, whether through critical analysis, creative exploration, or educational design. These agents embody different thinking methodologies, applying them contextually to generate insights that might otherwise remain hidden.

- **[Paul-Elder Framework Expert](./agents/paul-elder-framework-expert.md)**: Critical thinking and intellectual standards.
- **[Design Thinking Expert](./agents/design-thinking-expert.md)**: Human-centered problem solving.
- **[Lateral Thinking Expert](./agents/lateral-thinking-expert.md)**: Creative problem-solving techniques.
- **[Simplex Thinking Expert](./agents/simplex-thinking-expert.md)**: Systematic innovation processes.
- **[Bloom's Taxonomy Expert](./agents/blooms-taxonomy-expert.md)**: Educational design and learning objectives.
- **[Adult Learning Theory Expert](./agents/adult-learning-theory-expert.md)**: Professional training and development.

#### 🔧 Development Tools

Beyond core engineering skills, development work requires specialized tools for automation, quality assurance, and knowledge management. These agents handle the supporting tasks that make development more efficient and reliable. Some focus on preventing common pitfalls, while others extract patterns from existing work to inform future decisions.

- **[Bash Automation Expert](./agents/bash-automation-expert.md)**: macOS automation, file operations, scripting.
- **[Code Quality Pragmatist](./agents/code-quality-pragmatist.md)**: Avoiding over-engineering, maintaining simplicity.
- **[Claude MD Compliance Checker](./agents/claude-md-compliance-checker.md)**: Project guideline validation.
- **[Knowledge Synthesizer](./agents/knowledge-synthesizer.md)**: Cross-agent learning and pattern extraction.
- **[File Topic Analyzer](./agents/file-topic-analyzer.md)**: Content analysis and categorization.
- **[Ultrathink Debugger](./agents/ultrathink-debugger.md)**: Deep debugging and root cause analysis.

### Custom Commands

Repetitive tasks consume valuable time that could be spent on creative problem-solving, which makes automation essential for productivity. Custom commands encapsulate complex operations into simple invocations, reducing both effort and error rates. Each command incorporates best practices and intelligent defaults, ensuring consistent quality across executions.

#### Development Automation

Script creation often involves boilerplate code and standard patterns that experienced developers apply instinctively. These automation commands capture that expertise, generating production-ready code that includes error handling, documentation, and appropriate structure. The result accelerates development while maintaining professional standards that might be overlooked when rushing.

- **[/create-bash-script](./commands/create-bash-script.md)**: Generate production-ready bash scripts with error handling.
- **[/create-python-script](./commands/create-python-script.md)**: Create Python scripts with best practices.
- **[/create-command](./commands/create-command.md)**: Build new custom commands.
- **[/create-prompt](./commands/create-prompt.md)**: Design effective prompts.

#### Code Enhancement

Existing code often harbors opportunities for improvement that become apparent only through systematic review. Enhancement commands analyze code against established patterns and modern practices, suggesting refinements that improve readability, performance, or maintainability. This automated review process catches issues that manual inspection might miss while respecting the original implementation's intent.

- **[/enhance](./commands/enhance.md)**: Improve existing code quality.
- **[/improve-command](./commands/improve-command.md)**: Optimize command implementations.
- **[/update-agent](./commands/update-agent.md)**: Enhance agent capabilities.
- **[/update-command](./commands/update-command.md)**: Refine command functionality.
- **[/update-script](./commands/update-script.md)**: Modernize script implementations.

#### Information Extraction

Understanding complex systems requires distilling essential information from volumes of detail. Information extraction commands analyze repositories, folders, and content to surface key insights that inform decision-making. Rather than manual exploration, these tools provide structured summaries that highlight what matters most for the task at hand.

- **[/git-repo-info](./commands/git-repo-info.md)**: Comprehensive repository analysis.
- **[/folder-readme](./commands/folder-readme.md)**: Generate folder documentation.
- **[/extract-essential-information](./commands/extract-essential-information.md)**: Distill key insights from content.

### Templates

Consistency across extensions ensures the toolbox remains cohesive as it grows. Templates provide standardized structures for creating new components, establishing patterns that make integration seamless. Each template embodies learned best practices, helping contributors avoid common pitfalls while maintaining compatibility with existing tools.

- **[Agent Template](./templates/agent.md)**.
- **[Command Template](./templates/command.md)** (Coming soon).
- **[Hook Template](./templates/hook.md)** (Coming soon).
- **[Prompt Template](./templates/prompt.md)** (Coming soon).

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
