#!/bin/bash
set -e

if ! command -v apt-get &>/dev/null; then
  echo "unsupported distro: needs apt (Ubuntu)" >&2
  exit 1
fi

# Docker and Tailscale apt repos
codename="$(sed -n 's/^VERSION_CODENAME=//p' /etc/os-release)"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
echo "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $codename stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo curl -fsSL "https://pkgs.tailscale.com/stable/ubuntu/$codename.noarmor.gpg" -o /usr/share/keyrings/tailscale-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/ubuntu $codename main" \
  | sudo tee /etc/apt/sources.list.d/tailscale.list >/dev/null

# CLI tools
sudo apt-get update
sudo apt-get install -y \
  git \
  curl \
  ca-certificates \
  zsh \
  gh \
  fzf \
  starship \
  bat \
  eza \
  git-delta \
  atuin \
  zoxide \
  jq \
  zip \
  unzip \
  build-essential \
  nodejs \
  npm \
  age \
  shellcheck \
  tailscale \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# Ubuntu names the bat binary batcat
mkdir -p "$HOME/.local/bin"
ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"

# npm packages
sudo npm install -g pnpm
sudo npm install -g --ignore-scripts @earendil-works/pi-coding-agent

# uv
if ! command -v uv &>/dev/null && [ ! -x "$HOME/.local/bin/uv" ]; then
  curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
fi

# herdr
if ! command -v herdr &>/dev/null && [ ! -x "$HOME/.local/bin/herdr" ]; then
  curl -fsSL https://herdr.dev/install.sh | sh
fi
