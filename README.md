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

## How It Works

1. **Dynamic Mounting**: The scripts capture `$PWD` (current directory) and pass it to Docker Compose as `WORKSPACE_DIR`
	2. **Credential Persistence**: Uses Docker named volumes (`docker-claude-sandbox-data`, `docker-opencode-sandbox-data`) for API keys and config
	3. **Same as Official**: Replicates the symlink approach from `docker sandbox run claude`

	## Customization

	### Data Hiding (Optional)

	If you want to hide real data from the agent in a specific project, create a `.claude/sandboxing/docker-compose.yaml` override in that project with:

	```yaml
	services:
	claude:
	volumes:
	- ${WORKSPACE_DIR}:/workspace:z
- ${WORKSPACE_DIR}/data-mock:/workspace/data:z  # Override with mock data
	```

	### Block Specific Directories (Optional)

	To block access to specific directories (e.g., `.sessions`), add to `docker-compose.yaml`:

	```yaml
	services:
	claude:
	tmpfs:
	- /workspace/.sessions:rw,size=2m,mode=0000
	```

	## Volume Management

	View stored credentials:
	```bash
	docker volume inspect docker-claude-sandbox-data
	docker volume inspect docker-opencode-sandbox-data
	```

	Remove credentials (force re-authentication):
	```bash
	docker volume rm docker-claude-sandbox-data
	docker volume rm docker-opencode-sandbox-data
	```

	## Differences from Project-Specific Setup

	**Old approach** (`.claude/sandboxing/`):
	- Lives in each project's `.claude/sandboxing/` directory
	- Mounts `../..` (relative to script location)
	- Must be set up for each project

	**New approach** (`~/.agent-sandbox/`):
	- Lives in your home directory
	- Mounts `$PWD` (wherever you run it from)
- One setup, works for all projects

Both use the same Docker volumes for credentials, so they share API keys.
