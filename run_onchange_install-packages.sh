#!/bin/sh

sudo apt update

# update git
sudo apt install -y git

# install rustup
if ! command -v rustup >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

source "$HOME/.cargo/env"

# cargo packages
for crate in eza bat zoxide starship uv git-delta; do
  command -v "$crate" >/dev/null 2>&1 || cargo install "$crate" --locked
done

# SDKMAN!
if ! command -v sdk >/dev/null 2>&1; then
  curl -s "https://get.sdkman.io" | bash
fi

if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# maven
if ! sdk list maven | grep -q "installed"; then
  sdk install maven
fi

# nvm
export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install --lts

# fzf
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --all --no-update-rc
fi

# copyq
if ! command -v copyq >/dev/null 2>&1; then
  sudo apt update

  sudo apt install -y software-properties-common

  if ! grep -Rq "hluk/copyq" /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null; then
    sudo add-apt-repository -y ppa:hluk/copyq
    sudo apt update
  fi

  sudo apt install -y copyq
fi

# flameshot
if ! command -v flameshot >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y flameshot
fi
