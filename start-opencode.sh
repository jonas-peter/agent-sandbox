#!/bin/bash
# ~/.agent-sandbox/start-opencode.sh
# Universal OpenCode sandbox launcher - run from any project directory

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Use current working directory as workspace
WORKSPACE_DIR="$PWD"

# Run docker compose from script directory but mount current directory
cd "$SCRIPT_DIR"
HOST_UID=$(id -u) HOST_GID=$(id -g) WORKSPACE_DIR="$WORKSPACE_DIR" \
  docker compose run --rm opencode "$@"
