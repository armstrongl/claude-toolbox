---
name: create-python-script
description: Generate production-ready Python 3 scripts with standardized structure, error handling, and common arguments
argument-hint: <script-name> [description]
allowed-tools: Edit, Read, Bash, Write, MultiEdit, Bash(mkdir*), Bash(chmod*)
auto-execute: false
thinking-mode: deep
author: Larah
version: 1.0.0
tags: python, scripting, automation, development
---

You are Claude Code. You will create production-ready Python 3 scripts following best practices and standardized patterns. The user will provide a script name and optionally a description of what the script should do.

## Python Scripting Guidelines

### 1. Script Structure

Always use this standard structure:

- Shebang line: `#!/usr/bin/env python3`
- Module docstring with description, author, version
- Standard library imports first, then third-party, then local imports
- Type hints for all functions and methods
- Logging configuration
- Argument parser setup with standard arguments
- Main function that orchestrates the script
- Entry point guard: `if __name__ == "__main__":`

### 2. Error Handling

- Use proper exception handling with try/except blocks
- Log errors with appropriate context
- Use custom exceptions for domain-specific errors
- Return meaningful exit codes using sys.exit()
- Implement proper cleanup in finally blocks or using context managers

### 3. Standard Arguments

Every script must implement these arguments:

- `--help` / `-h`: Display usage information (automatic with argparse)
- `--verbose` / `-v`: Enable verbose output (can be used multiple times for more verbosity)
- `--quiet` / `-q`: Suppress non-error output
- `--dry-run` / `-n`: Show what would be done without executing
- `--version`: Display version information

### 4. Best Practices

- Follow PEP 8 style guide
- Use type hints for better code clarity
- Implement logging instead of print statements
- Use pathlib for file operations
- Add docstrings for all functions and classes
- Use argparse for command-line argument parsing
- Implement proper signal handling for graceful shutdown
- Use context managers for resource management

### 5. Documentation

- Add comprehensive docstrings following Google or NumPy style
- Document all functions, classes, and modules
- Include usage examples in docstrings
- Maintain type hints for all parameters and return values
- Keep a changelog in script comments

## Process Instructions

1. Parse the user's input to extract:
   - Script name (required)
   - Script purpose/description (optional)
   - Any specific requirements mentioned

2. Generate the Python script with the following components:

   a. **Header Section**:
      - Shebang line
      - Module docstring with description, usage, author, version
      - License information if applicable

   b. **Imports Section**:
      - Standard library imports (sys, os, logging, argparse, etc.)
      - Type hint imports (typing, Optional, List, etc.)
      - Third-party imports if needed
      - Local imports if applicable

   c. **Configuration Section**:
      - Define constants (uppercase with underscores)
      - Set up logging format
      - Define version string
      - Set default configuration values

   d. **Custom Exceptions**:
      - Define script-specific exception classes
      - Include helpful error messages

   e. **Utility Functions**:
      - Logging setup function
      - Input validation functions
      - Any task-specific utility functions
      - All with proper type hints and docstrings

   f. **Argument Parser**:
      - Create ArgumentParser with description
      - Add all standard arguments
      - Add any script-specific arguments
      - Implement mutual exclusivity where needed
      - Set appropriate defaults and types

   g. **Main Logic Functions**:
      - Separate concerns into focused functions
      - Use type hints for all parameters and returns
      - Include comprehensive docstrings
      - Implement proper error handling

   h. **Main Function**:
      - Parse arguments
      - Configure logging based on verbosity
      - Validate inputs
      - Execute core functionality
      - Handle exceptions gracefully
      - Return appropriate exit codes

   i. **Entry Point**:
      - Standard `if __name__ == "__main__":` guard
      - Call main() and handle keyboard interrupts

3. Generate a README.md file for the script containing:
   - Script name and purpose
   - Installation instructions
   - Usage examples
   - Argument descriptions
   - Requirements/dependencies
   - Configuration options
   - Troubleshooting section
   - Development setup

4. Unless otherwise specified, save both files to the default scripts directory:
   - Ensure the directory `/Users/larah/.dotfiles/.scripts/` exists (create if needed)
   - Script: `/Users/larah/.dotfiles/.scripts/<script-name>/<script-name>.py` with executable permissions (chmod +x)
   - README: `/Users/larah/.dotfiles/.scripts/<script-name>/README.md`
   - requirements.txt: `/Users/larah/.dotfiles/.scripts/<script-name>/requirements.txt` (if third-party dependencies)

5. Update the `/Users/larah/.dotfiles/.scripts/README.md` file to include the new script name and description.

6. If verbose mode was requested, also display:
   - Summary of what was created
   - Next steps for the user
   - Tips for customization

## Python Style Guide

### Naming Conventions

- Script names: lowercase with hyphens (e.g., `process-data.py`)
- Functions: lowercase with underscores (e.g., `parse_arguments()`)
- Classes: PascalCase (e.g., `DataProcessor`)
- Constants: uppercase with underscores (e.g., `DEFAULT_TIMEOUT`)
- Variables: lowercase with underscores

### Formatting

- Use 4 spaces for indentation (PEP 8 standard)
- Maximum line length: 88 characters (Black formatter default)
- Two blank lines between top-level definitions
- One blank line between method definitions
- Imports grouped and sorted with isort conventions

### Type Hints

- Use type hints for all function signatures
- Import from typing module as needed
- Use Optional[] for nullable types
- Use Union[] for multiple possible types

### Comments and Docstrings

- Use Google or NumPy style docstrings
- Start docstrings with a one-line summary
- Include Args, Returns, Raises sections
- Use inline comments sparingly and only when necessary

## Script Template

```python
#!/usr/bin/env python3
"""
[SCRIPT_NAME] - [DESCRIPTION]

This script [DETAILED_DESCRIPTION].

Usage:
    [SCRIPT_NAME] [OPTIONS]

Examples:
    # Basic usage
    [SCRIPT_NAME]

    # With verbose output
    [SCRIPT_NAME] -v

    # Dry run mode
    [SCRIPT_NAME] --dry-run

Author: [AUTHOR]
Version: 1.0.0
Date: [DATE]
"""

import sys
import os
import logging
import argparse
import signal
from pathlib import Path
from typing import Optional, List, Dict, Any
from datetime import datetime

# Constants
SCRIPT_NAME = Path(__file__).name
SCRIPT_DIR = Path(__file__).parent.absolute()
VERSION = "1.0.0"
DEFAULT_LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"


class ScriptError(Exception):
    """Base exception for script-specific errors."""
    pass


def setup_logging(verbosity: int, quiet: bool) -> None:
    """
    Configure logging based on verbosity level.

    Args:
        verbosity: Verbosity level (0=normal, 1=verbose, 2+=debug)
        quiet: If True, suppress all non-error output
    """
    if quiet:
        log_level = logging.ERROR
    elif verbosity == 0:
        log_level = logging.INFO
    elif verbosity == 1:
        log_level = logging.DEBUG
    else:
        log_level = logging.DEBUG
        # Also log from external libraries
        logging.getLogger().setLevel(logging.DEBUG)

    logging.basicConfig(
        level=log_level,
        format=DEFAULT_LOG_FORMAT,
        handlers=[
            logging.StreamHandler(sys.stderr)
        ]
    )


def parse_arguments() -> argparse.Namespace:
    """
    Parse command-line arguments.

    Returns:
        Parsed arguments namespace
    """
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )

    # Standard arguments
    parser.add_argument(
        "-v", "--verbose",
        action="count",
        default=0,
        help="Increase verbosity (can be used multiple times)"
    )

    parser.add_argument(
        "-q", "--quiet",
        action="store_true",
        help="Suppress all non-error output"
    )

    parser.add_argument(
        "-n", "--dry-run",
        action="store_true",
        help="Show what would be done without executing"
    )

    parser.add_argument(
        "--version",
        action="version",
        version=f"{SCRIPT_NAME} {VERSION}"
    )

    # Script-specific arguments
    # TODO: Add your custom arguments here

    # Validate mutual exclusivity
    args = parser.parse_args()
    if args.quiet and args.verbose:
        parser.error("--quiet and --verbose are mutually exclusive")

    return args


def signal_handler(signum: int, frame: Any) -> None:
    """
    Handle interrupt signals gracefully.

    Args:
        signum: Signal number
        frame: Current stack frame
    """
    logging.info("\nInterrupt received, shutting down gracefully...")
    # TODO: Add cleanup code here if needed
    sys.exit(130)  # 128 + SIGINT


def validate_inputs(args: argparse.Namespace) -> None:
    """
    Validate command-line inputs.

    Args:
        args: Parsed command-line arguments

    Raises:
        ScriptError: If validation fails
    """
    # TODO: Add your input validation logic here
    pass


def main() -> int:
    """
    Main script execution.

    Returns:
        Exit code (0 for success, non-zero for errors)
    """
    # Parse arguments
    args = parse_arguments()

    # Setup logging
    setup_logging(args.verbose, args.quiet)
    logger = logging.getLogger(__name__)

    # Log startup
    logger.debug(f"Starting {SCRIPT_NAME} v{VERSION}")
    logger.debug(f"Arguments: {vars(args)}")

    try:
        # Validate inputs
        validate_inputs(args)

        # Main logic
        logger.info("Executing main logic...")

        if args.dry_run:
            logger.info("[DRY-RUN] Would perform main action")
            # TODO: Show what would be done
        else:
            # TODO: Implement your main logic here
            logger.info("Performing main action...")
            pass

        logger.info("Script completed successfully")
        return 0

    except ScriptError as e:
        logger.error(f"Script error: {e}")
        return 1
    except KeyboardInterrupt:
        logger.info("\nInterrupted by user")
        return 130
    except Exception as e:
        logger.exception(f"Unexpected error: {e}")
        return 2


if __name__ == "__main__":
    # Setup signal handlers
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    # Execute main function
    sys.exit(main())
```

## README Template

```markdown
# [SCRIPT_NAME]

[DESCRIPTION]

## Features

- Production-ready Python script with proper error handling
- Comprehensive logging with adjustable verbosity
- Dry-run mode for safe testing
- Type hints for better code clarity
- Well-documented with docstrings
- Follows PEP 8 style guidelines

## Requirements

- Python 3.7 or later
- No external dependencies (uses only standard library)

## Installation

1. Download the script:
   ```bash
   curl -O https://example.com/[SCRIPT_NAME].py
   ```

2. Make it executable:

   ```bash
   chmod +x [SCRIPT_NAME].py
   ```

3. Optionally, move to a directory in your PATH:

   ```bash
   sudo mv [SCRIPT_NAME].py /usr/local/bin/[SCRIPT_NAME]
   ```

## Usage

```bash
[SCRIPT_NAME] [OPTIONS]
```

### Options

- `-h, --help` - Show help message and exit
- `-v, --verbose` - Increase verbosity (can be used multiple times)
- `-q, --quiet` - Suppress all non-error output
- `-n, --dry-run` - Show what would be done without executing
- `--version` - Display version information

### Examples

Basic usage:

```bash
[SCRIPT_NAME]
```

Verbose output:

```bash
[SCRIPT_NAME] -v
```

Very verbose output (debug mode):

```bash
[SCRIPT_NAME] -vv
```

Dry run mode:

```bash
[SCRIPT_NAME] --dry-run
```

Quiet mode (errors only):

```bash
[SCRIPT_NAME] --quiet
```

## Configuration

The script can be configured using environment variables:

- `[RELEVANT_ENV_VAR]` - Description of what it does

## Development

### Setting up the development environment

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/[SCRIPT_NAME].git
   cd [SCRIPT_NAME]
   ```

2. Create a virtual environment:

   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install development dependencies:

   ```bash
   pip install -r requirements-dev.txt
   ```

### Running tests

```bash
python -m pytest tests/
```

### Code style

This project uses:

- Black for code formatting
- isort for import sorting
- mypy for type checking
- pylint for linting

Run all checks:

```bash
make lint
```

## Troubleshooting

### Common Issues

1. **Permission denied**: Ensure the script has execute permissions (`chmod +x`)
2. **Python not found**: Check that Python 3 is installed and in your PATH
3. **Module not found**: Ensure you're using Python 3.7 or later

### Debug Mode

For detailed debugging information, use double verbose flag:

```bash
[SCRIPT_NAME] -vv
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

[LICENSE_TYPE]

## Changelog

### [1.0.0] - [DATE]

- Initial release
- Basic functionality implemented
- Standard argument parsing
- Comprehensive logging

## Authors

- [AUTHOR_NAME] - Initial work

## Acknowledgments

- Thanks to contributors and testers

```

---

## How to Use This Command

Run this command with: `/create-python-script <script-name> [description]`

This command generates a production-ready Python 3 script with standardized structure, error handling, type hints, and common arguments (--help, --verbose, --quiet, --dry-run, --version).

Examples:
- `/create-python-script process-logs "Analyze and process application log files"`
- `/create-python-script data-migration "Migrate data between database systems"`
- `/create-python-script file-organizer`

The command will create:
1. An executable Python script: `/Users/larah/.dotfiles/.scripts/<script-name>/<script-name>.py`
2. A comprehensive README file: `/Users/larah/.dotfiles/.scripts/<script-name>/README.md`
3. A requirements.txt file (if needed): `/Users/larah/.dotfiles/.scripts/<script-name>/requirements.txt`

The generated script follows Python best practices including PEP 8 style, type hints, proper logging, and comprehensive error handling. The scripts directory will be created if it doesn't exist.
