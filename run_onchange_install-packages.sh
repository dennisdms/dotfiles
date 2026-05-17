#!/bin/bash
set -e

# Source brew into PATH — scripts don't inherit shell environment
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# CLI tools
brew install \
  git \
  fzf \
  starship \
  bat \
  eza \
  git-delta \
  chezmoi \
  atuin \
  uv \
  pnpm \
  node \
  zoxide

# Rust — official installer
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# SDKMAN — official installer
if [ ! -d "$HOME/.sdkman" ]; then
  curl -s "https://get.sdkman.io" | bash
fi
