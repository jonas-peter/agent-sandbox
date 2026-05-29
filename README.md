# Universal Agent Sandbox

Portable sandboxing setup for Claude Code and OpenCode that can be used from any project directory.

## Installation

```bash
# Symlink this directory to your home directory
ln -s agent-sandbox ~/.agent-sandbox

# Make scripts executable
chmod +x ~/.agent-sandbox/start-claude.sh ~/.agent-sandbox/start-opencode.sh
```

## Usage

Navigate to any project directory and run:

```bash
# Start Claude Code in current directory
~/.agent-sandbox/start-claude.sh

# Start OpenCode in current directory
~/.agent-sandbox/start-opencode.sh
```

The scripts will mount your current working directory as `/workspace` inside the container.

## Optional: Add to PATH

For easier access, add this to your `~/.bashrc` or `~/.zshrc`:

```bash
export PATH="$HOME/.agent-sandbox:$PATH"
```

Then you can simply run:

```bash
start-claude.sh
start-opencode.sh
```
