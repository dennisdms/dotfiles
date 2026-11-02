#!/bin/bash
set -e

# Tailscale
sudo systemctl enable --now tailscaled

# Docker
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

# Login shell
if [ "$(getent passwd "$USER" | cut -d: -f7)" != "$(command -v zsh)" ]; then
  sudo chsh -s "$(command -v zsh)" "$USER"
fi
