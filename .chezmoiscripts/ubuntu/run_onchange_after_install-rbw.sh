#!/bin/bash
set -e

# rbw (apt on 26.04+, cargo otherwise; runs after the Rust toolchain install)
command -v rbw &>/dev/null && exit 0
if apt-cache show rbw &>/dev/null; then
  sudo apt-get install -y rbw
else
  sudo apt-get install -y pinentry-curses
  "$HOME/.cargo/bin/cargo" install --locked rbw
fi
