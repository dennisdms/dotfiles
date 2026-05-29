# AGENTS.md

## Purpose
This repository is a small `chezmoi`-managed dotfiles setup for shell, editor, Git, prompt, and Claude configuration.

## Structure
```text
chezmoi/
├── dot_claude/
│   ├── executable_statusline-command.sh
│   └── settings.json
├── dot_config/
│   └── starship.toml
├── README.md
├── dot_gitconfig
├── dot_ideavimrc
├── dot_vimrc
├── dot_zshrc
├── run_once_install-homebrew.sh
├── run_onchange_install-packages.sh
├── AGENTS.md
├── CLAUDE.md
└── .gitignore
```

## Chezmoi naming
- Files prefixed with `dot_` map into the home directory with a leading dot.
- Example: `dot_zshrc` becomes `~/.zshrc` and `dot_config/starship.toml` becomes `~/.config/starship.toml`.
- `run_once_*` scripts run once.
- `run_onchange_*` scripts rerun when their contents change.

## File descriptions
- `README.md` — quick notes for adding, editing, applying, and bootstrapping the chezmoi repo.
- `AGENTS.md` — repository guidance for coding agents, including structure, chezmoi naming, and file inventory.
- `CLAUDE.md` — Claude entrypoint that imports shared repository context from `@AGENTS.md`.
- `.gitignore` — local ignore rules for repo-specific, non-versioned files.
- `dot_claude/settings.json` — user Claude settings synced by chezmoi, including plugin enablement, fullscreen TUI, and a custom status line command.
- `dot_claude/executable_statusline-command.sh` — shell script that renders Claude status line details such as model, effort, thinking mode, session name, context usage, and rate-limit windows.
- `dot_config/starship.toml` — Starship prompt config with a compact single-line prompt and Git status modules.
- `dot_gitconfig` — Git defaults and aliases, including `delta` integration, rebase-oriented pull behavior, pruning, fast-forward-only merge, and short aliases.
- `dot_ideavimrc` — IdeaVim settings and JetBrains action mappings for navigation, debugging, rename, find, and error traversal.
- `dot_vimrc` — base Vim configuration: search behavior, indentation, line numbers, status UI, and a clear-search mapping.
- `dot_zshrc` — shell environment setup for SSH agent, SDKMAN, Claude, Homebrew, pnpm, fzf, atuin, cargo, zoxide, aliases, and Starship.
- `run_once_install-homebrew.sh` — one-time bootstrap script that installs Homebrew when it is missing.
- `run_onchange_install-packages.sh` — package install script for Homebrew CLI tools plus bootstrap for Rust (`rustup`) and SDKMAN.

## Notes for agents
- Keep this repo simple and declarative.
- Prefer updating the mapped chezmoi source file instead of editing generated files in `$HOME`.
- When documenting changes, refer to both the source path in this repo and the target path it manages when useful.
- Exclude `.gitignore`d files and directories from repository structure and file inventories.
