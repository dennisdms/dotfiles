#!/bin/bash
set -e

command -v herdr &>/dev/null || exit 0

# owner/repo@ref; bump a ref to upgrade, chezmoi reruns this when the list changes
# (removing an entry doesn't uninstall it: run `herdr plugin uninstall <id>`)
plugins=(
  # reviewr: code-review pane, toggled with prefix+d
  persiyanov/herdr-reviewr@v0.49.0
)

for p in "${plugins[@]}"; do
  herdr plugin install "${p%@*}" --ref "${p#*@}" --yes
done
