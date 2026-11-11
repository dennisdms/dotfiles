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
  pre-commit \
  chezmoi \
  atuin \
  uv \
  pnpm \
  nodejs \
  jq \
  wl-clipboard \
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
paru -S --needed --noconfirm --mflags --nocheck \
  nordvpn-bin \
  visual-studio-code-bin \
  shellcheck-bin \
  herdr-bin \
  proton-pass-cli-bin \
  pi-coding-agent-bin \
  en-croissant-bin

# tea (Gitea CLI)
if ! command -v tea &>/dev/null && [ ! -x "$HOME/.local/bin/tea" ]; then
  tea_version="$(curl -fsSL https://dl.gitea.com/tea/version.json | jq -r .latest.version)"
  tea_arch="$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/')"
  mkdir -p "$HOME/.local/bin"
  curl -fsSL "https://dl.gitea.com/tea/$tea_version/tea-$tea_version-linux-$tea_arch" -o "$HOME/.local/bin/tea"
  chmod +x "$HOME/.local/bin/tea"
fi
