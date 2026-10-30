#!/bin/bash
set -e

# VPN
sudo systemctl enable --now tailscaled nordvpnd
sudo usermod -aG nordvpn "$USER"

# Docker
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

# Virtualization
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt "$USER"

# Power profile
sudo systemctl enable --now power-profiles-daemon
powerprofilesctl set performance

# Ollama
sudo systemctl enable --now ollama
