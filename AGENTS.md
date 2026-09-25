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
├── run_once_install-homebrew.sh.tmpl
├── run_onchange_install-packages.sh.tmpl
├── run_onchange_install-toolchains.sh
├── AGENTS.md
├── CLAUDE.md
└── .gitignore
```

## Chezmoi naming
- Files prefixed with `dot_` map into the home directory with a leading dot.
- Example: `dot_zshrc` becomes `~/.zshrc` and `dot_config/starship.toml` becomes `~/.config/starship.toml`.
- `run_once_*` scripts run once.
- `run_onchange_*` scripts rerun when their contents change.
- Files ending in `.tmpl` are rendered as Go templates; a `run_` script that renders empty is skipped (used to gate scripts by OS).

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
- `run_once_install-homebrew.sh.tmpl` — macOS-only one-time bootstrap that installs Homebrew when it is missing; renders empty (skipped) on Linux.
- `run_onchange_install-packages.sh.tmpl` — OS-specific CLI tool install: Homebrew on macOS, pacman on CachyOS/Arch; fails on unsupported OSes.
- `run_onchange_install-toolchains.sh` — shared script that installs Rust (`rustup`), SDKMAN, and Claude Code via their official installers.

## Notes for agents
- Keep this repo simple and declarative.
- Prefer updating the mapped chezmoi source file instead of editing generated files in `$HOME`.
- When documenting changes, refer to both the source path in this repo and the target path it manages when useful.
- Exclude `.gitignore`d files and directories from repository structure and file inventories.
