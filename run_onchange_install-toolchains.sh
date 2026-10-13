#!/bin/bash
set -e

# Rust — official installer
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# SDKMAN — official installer; needs Bash 4+, so use Homebrew's bash on macOS (/bin/bash is 3.2)
if [ ! -d "$HOME/.sdkman" ]; then
  sdkman_bash=bash
  [ -x /opt/homebrew/bin/bash ] && sdkman_bash=/opt/homebrew/bin/bash
  curl -s "https://get.sdkman.io" | "$sdkman_bash"
fi

# Claude Code — official installer
if ! command -v claude &>/dev/null && [ ! -x "$HOME/.local/bin/claude" ]; then
  curl -fsSL https://claude.ai/install.sh | bash
fi
