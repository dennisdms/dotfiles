#!/bin/bash
set -e

if ! command -v pacman &>/dev/null; then
  echo "unsupported Linux distro: needs pacman (CachyOS/Arch)" >&2
  exit 1
fi

# CLI tools
sudo pacman -S --needed --noconfirm \
  git \
  github-cli \
  ghq \
  fzf \
  starship \
  bat \
  eza \
  git-delta \
  chezmoi \
  atuin \
  uv \
  pnpm \
  nodejs \
  jq \
  npm \
  zoxide \
  zsh \
  zip \
  unzip \
  base-devel \
  paru \
  tailscale \
  cloudflared \
  sops \
  age \
  docker \
  docker-compose \
  docker-buildx \
  qemu-desktop \
  libvirt \
  virt-manager \
  virt-install \
  edk2-ovmf \
  dnsmasq \
  obsidian \
  spotify-launcher \
  nvtop \
  power-profiles-daemon \
  sunshine \
  ollama-cuda

# AUR packages
paru -S --needed --noconfirm \
  nordvpn-bin \
  visual-studio-code-bin \
  shellcheck-bin \
  herdr-bin \
  pi-coding-agent-bin

# VS Code extensions
extensions=(
  vscodevim.vim
  usernamehw.errorlens
  editorconfig.editorconfig
  jdinhlife.gruvbox
  timonwong.shellcheck
  tamasfe.even-better-toml
  mtxr.sqltools
)
for ext in "${extensions[@]}"; do
  code --install-extension "$ext" --force
done
