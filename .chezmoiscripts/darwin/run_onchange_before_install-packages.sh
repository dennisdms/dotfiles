#!/bin/bash
set -e

eval "$(/opt/homebrew/bin/brew shellenv)"

export HOMEBREW_NO_ENV_HINTS=1

brew bundle --quiet --file=- <<'EOF'
# CLI tools
brew "git"
brew "gh"
brew "ghq"
brew "fzf"
brew "starship"
brew "bat"
brew "eza"
brew "git-delta"
brew "chezmoi"
brew "atuin"
brew "uv"
brew "pnpm"
brew "node"
brew "typescript-language-server"
brew "jq"
brew "bash"
brew "zoxide"
brew "herdr"
brew "cloudflared"
brew "pi-coding-agent"
brew "sops"
brew "age"
brew "colima", start_service: true
brew "docker"
brew "docker-compose"

# Apps
cask "obsidian"
cask "spotify"
cask "moonlight"
EOF
