#!/bin/bash
set -e

# herdr owns its integration files and bumps their version on upgrade, so reinstall
# on every apply instead of storing a copy that would go stale
command -v herdr &>/dev/null || exit 0

# pi: agent state extension in ~/.pi/agent/extensions/herdr-agent-state.ts
if command -v pi &>/dev/null; then
  mkdir -p "$HOME/.pi/agent/extensions"
  herdr integration install pi >/dev/null
fi
