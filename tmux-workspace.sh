#!/bin/bash

# Workspace base directory - adjust this path as needed
WORKSPACE="${WORKSPACE:-$HOME/workspace}"

SESSION_NAME="workspace"

# Check if session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Session '$SESSION_NAME' already exists. Attaching..."
    tmux attach-session -t "$SESSION_NAME"
    exit 0
fi

# Create new session with first window named "relayer"
tmux new-session -d -s "$SESSION_NAME" -n "relayer" -c "$WORKSPACE/relayer"
tmux split-window -h -t "$SESSION_NAME:relayer" -c "$WORKSPACE/relayer"

# Create additional windows
tmux new-window -t "$SESSION_NAME" -n "infra" -c "$WORKSPACE/infra"
tmux split-window -h -t "$SESSION_NAME:infra" -c "$WORKSPACE/infra"

tmux new-window -t "$SESSION_NAME" -n "e2e" -c "$WORKSPACE/proof-api-e2e"
tmux split-window -h -t "$SESSION_NAME:e2e" -c "$WORKSPACE/proof-api-e2e"

# Select the first window and first pane
tmux select-window -t "$SESSION_NAME:relayer"

# Attach to the session (with -c to set working directory for new windows)
tmux attach-session -t "$SESSION_NAME" -c "$WORKSPACE"
