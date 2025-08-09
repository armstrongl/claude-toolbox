---
name: git-repo-info
description: Check git history, information, and status of the current or specified repository.
argument-hint: [repo-path]
auto-execute: true
parameters:
  - name: commit_count
    type: number
    required: false
    default: 10
    description: Number of recent commits to display in the history.
  - name: show_branches
    type: boolean
    required: false
    default: true
    description: Whether to show all branches or just the current branch.
  - name: show_remotes
    type: boolean
    required: false
    default: true
    description: Whether to display remote repository information.
author: Larah
version: 1.0.0
tags: git, repository, status, history, info
---

This command provides comprehensive information about a git repository including its current status, recent commit history, branch information, and remote configuration. Execute this command to get a quick overview of the repository state without running multiple individual git commands.

First, determine the target repository location. If an argument is provided, treat it as the path to the repository and change to that directory. If no argument is provided, use the current working directory.

## Repository Status Check

1. Display the current working directory to confirm the repository location.
2. Run `git status` to show:
   - Current branch name
   - Any uncommitted changes (staged and unstaged)
   - Untracked files
   - Whether the branch is ahead or behind the remote

## Repository Information

3. Display basic repository information:
   - Run `git config --get remote.origin.url` to show the remote repository URL
   - Run `git rev-parse --show-toplevel` to show the repository root directory
   - Run `git rev-parse --git-dir` to show the .git directory location

## Branch Information

4. If show_branches parameter is true:
   - Run `git branch -a -v` to list all local and remote branches with their latest commit
   - Run `git branch --show-current` to highlight the current branch
   - Run `git branch -r --merged` to show remote branches that have been merged

## Commit History

5. Display recent commit history:
   - Run `git log --oneline --graph --decorate -n [commit_count]` to show a visual graph of recent commits
   - Include commit hashes, messages, and branch/tag decorations
   - Use the commit_count parameter to control how many commits to display

## Remote Repository Information

6. If show_remotes parameter is true:
   - Run `git remote -v` to list all configured remotes with their URLs
   - Run `git ls-remote --heads origin` to show all remote branches
   - Run `git fetch --dry-run` to check for any updates available from the remote

## Repository Statistics

7. Provide repository statistics:
   - Run `git rev-list --all --count` to show total number of commits
   - Run `git shortlog -sn --all` to show commit counts by author
   - Run `git log --since="1 month ago" --oneline | wc -l` to show commits in the last month

## Stash Information

8. Check for any stashed changes:
   - Run `git stash list` to show any stashed work
   - If stashes exist, display count and most recent stash message

## Tag Information

9. Display tag information:
   - Run `git tag -n1` to list all tags with their messages
   - Run `git describe --tags --abbrev=0` to show the most recent tag if available

Format all output clearly with section headers to make the information easy to scan. If any git command fails (indicating it's not a git repository), report this clearly and stop execution.

---

## How to Use This Command

Run this command with: `/git-repo-info [repo-path]`

This command provides comprehensive git repository information including status, history, branches, and remote configuration.

Examples:

- `/git-repo-info` - Check information for the current repository
- `/git-repo-info /path/to/repo` - Check information for a specific repository
- `/git-repo-info ~/projects/myapp` - Check a repository in your home directory

The command will display:

- Current status and uncommitted changes
- Recent commit history (default: 10 commits)
- Branch information (local and remote)
- Remote repository configuration
- Repository statistics and author contributions
- Any stashed changes
- Tag information

You can customize the output using parameters when defining the command in your configuration.
