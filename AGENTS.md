# AGENTS.md

## Purpose
This repository is a small `chezmoi`-managed dotfiles setup for shell, editor, Git, prompt, and Claude configuration.

## Structure
```text
chezmoi/
├── dot_claude/
│   ├── CLAUDE.md
│   ├── executable_herdr-session-title.sh
│   ├── executable_statusline-command.sh
│   └── modify_settings.json
├── dot_config/
│   ├── Code/
│   │   └── User/
│   │       └── settings.json
│   ├── environment.d/
│   │   └── gaming.conf
│   ├── ghostty/
│   │   └── config.ghostty
│   ├── herdr/
│   │   └── config.toml
│   ├── MangoHud/
│   │   └── MangoHud.conf
│   └── starship.toml
├── dot_docker/
│   └── modify_config.json
├── dot_local/
│   └── share/
│       └── applications/
│           └── dev.herdr.Herdr.desktop
├── README.md
├── dot_gitconfig
├── dot_ideavimrc
├── dot_vimrc
├── dot_zshrc
├── run_once_before_install-homebrew.sh.tmpl
├── run_onchange_before_install-packages.sh.tmpl
├── run_onchange_install-toolchains.sh
├── AGENTS.md
├── CLAUDE.md
├── .chezmoiignore
└── .gitignore
```

## Chezmoi naming
- Files prefixed with `dot_` map into the home directory with a leading dot.
- Example: `dot_zshrc` becomes `~/.zshrc` and `dot_config/starship.toml` becomes `~/.config/starship.toml`.
- `run_once_*` scripts run once.
- `run_onchange_*` scripts rerun when their contents change.
- `run_*_before_*` scripts run before any files are applied; plain `run_*` scripts run interleaved with files in alphabetical target order.
- `modify_*` scripts receive the current target file on stdin and print the new contents; used for files an app also writes to.
- Files ending in `.tmpl` are rendered as Go templates; a `run_` script that renders empty is skipped (used to gate scripts by OS).

## File descriptions
- `README.md` — quick notes for adding, editing, applying, and bootstrapping the chezmoi repo.
- `AGENTS.md` — repository guidance for coding agents, including structure, chezmoi naming, and file inventory.
- `CLAUDE.md` — Claude entrypoint that imports shared repository context from `@AGENTS.md`.
- `.chezmoiignore` — keeps repo-only docs (`AGENTS.md`, `CLAUDE.md`, `README.md`) from being applied into `$HOME`, skips `.local/share/applications`, `.config/MangoHud`, and `.config/environment.d` on non-Linux systems, and skips `.docker` on non-macOS systems.
- `.gitignore` — local ignore rules for repo-specific, non-versioned files.
- `dot_claude/CLAUDE.md` — global Claude instructions (`~/.claude/CLAUDE.md`): says Claude usually runs inside herdr and should read `herdr --skill` before herdr-related actions, without using herdr unprompted.
- `dot_claude/modify_settings.json` — chezmoi `modify_` script that uses `jq` to deep-merge managed Claude settings (plugin enablement, fullscreen TUI, custom status line command, empty attribution, SessionStart/Stop hooks for the herdr session title) into `~/.claude/settings.json`, keeping keys Claude Code writes itself; hook lists are unioned per event so hooks other tools register (e.g. herdr's session-resume hook) survive.
- `dot_claude/executable_herdr-session-title.sh` — Claude Code SessionStart/Stop hook that reads the session title (`/rename` name, else the generated title) from the transcript and reports it to herdr as `$title1..$title3` pane tokens, word-wrapped at 22 columns with an ellipsis on overflow; no-op outside herdr.
- `dot_claude/executable_statusline-command.sh` — shell script that renders Claude status line details such as model, effort, thinking mode, session name, context usage, and rate-limit windows.
- `dot_config/Code/User/settings.json` — VS Code user settings (Linux path): Gruvbox Dark theme, VSCodeVim config mirroring `dot_vimrc`/`dot_ideavimrc` mappings, a 10-tab limit with wrapped tabs, built-in AI features disabled, the ShellCheck extension pointed at the system `shellcheck` binary (`shellcheck-bin`), and SQLTools set to run drivers under the system Node runtime.
- `dot_config/environment.d/gaming.conf` — Linux-only systemd user session environment (`~/.config/environment.d/gaming.conf`, picked up after re-login): `MANGOHUD=1` to load the MangoHud Vulkan layer in every game, and `__GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1` so the NVIDIA driver keeps its shader cache.
- `dot_config/MangoHud/MangoHud.conf` — Linux-only MangoHud overlay config (`~/.config/MangoHud/MangoHud.conf`): compact top-left HUD with fps, frametime graph, GPU/VRAM, CPU, RAM, network (`enp42s0`), Wine and resolution; an fps limit cycling 144 → 60 → unlimited on Shift_L+F1, HUD toggle on Shift_R+F12, and a blacklist of non-game Vulkan apps.
- `dot_config/ghostty/config.ghostty` — Ghostty terminal config: Gruvbox Dark theme, a 200x50 default window size, and ctrl+backspace mapped to delete the previous word.
- `dot_config/herdr/config.toml` — herdr config (same path on Linux and macOS): skips onboarding, sets the prefix to ctrl+space and a full keymap (agent picker on prefix+space/ctrl+alt+space, ctrl+alt+j/k agents, ctrl+alt+n/p workspaces, ctrl+alt+w workspace picker, ctrl+alt+1..9 and ctrl+alt+[/] tabs, alt+h/j/k/l pane focus, prefix+g/G/ctrl+g worktrees, prefix+v/s splits, prefix+m resize, settings moved to prefix+comma), adds a prefix+shift+c custom command that opens the focused pane's directory in VS Code, uses symbol status indicators, shows the wrapped Claude session title rows for claude agents in the sidebar, and sets the Gruvbox theme.
- `dot_docker/modify_config.json` — macOS-only chezmoi `modify_` script that uses `jq` to merge `cliPluginsExtraDirs` (Homebrew's `/opt/homebrew/lib/docker/cli-plugins`) into `~/.docker/config.json` so `docker compose` finds the Homebrew plugin, keeping keys Docker writes itself.
- `dot_local/share/applications/dev.herdr.Herdr.desktop` — Linux-only desktop entry (`~/.local/share/applications/`) that launches herdr in its own Ghostty window with the thin KDE server-side titlebar instead of the GTK header (`--class=dev.herdr.Herdr`, `--window-decoration=server`).
- `dot_config/starship.toml` — Starship prompt config with a compact single-line prompt and Git status modules.
- `dot_gitconfig` — Git defaults and aliases, including `delta` integration, rebase-oriented pull behavior, pruning, fast-forward-only merge, and short aliases.
- `dot_ideavimrc` — IdeaVim settings and JetBrains action mappings for navigation, debugging, rename, find, and error traversal.
- `dot_vimrc` — base Vim configuration: search behavior, indentation, line numbers, status UI, and a clear-search mapping.
- `dot_zshrc` — shell environment setup for SSH agent, SDKMAN, Claude, Homebrew, pnpm, fzf, atuin, cargo, zoxide, word-deletion and ctrl+arrow word-navigation bindings, aliases, a `scratch` function for timestamped scratch folders, and Starship.
- `run_once_before_install-homebrew.sh.tmpl` — macOS-only one-time bootstrap that installs Homebrew when it is missing, run before files are applied; renders empty (skipped) on Linux.
- `run_onchange_before_install-packages.sh.tmpl` — OS-specific CLI tool install, run before files are applied so `jq` exists for the `modify_` scripts: Homebrew on macOS (CLI formulae including herdr, jq, and Colima with the Docker and Docker Compose CLIs, starting Colima as a login service, plus the Obsidian and Spotify casks); pacman (plus jq, Tailscale, Docker with Compose and Buildx, Obsidian, spotify-launcher, MangoHud, nvtop, and power-profiles-daemon) and paru for AUR packages (NordVPN, VS Code, ShellCheck, herdr) plus a list of VS Code extensions (Vim, Error Lens, EditorConfig, Gruvbox, ShellCheck, Even Better TOML, SQLTools) on CachyOS/Arch, enabling the VPN and Docker daemons, adding the user to the `docker` group, and setting the persistent `performance` power profile; fails on unsupported OSes.
- `run_onchange_install-toolchains.sh` — shared script that installs Rust (`rustup`), SDKMAN, and Claude Code via their official installers.

## Notes for agents
- Keep this repo simple and declarative.
- Prefer updating the mapped chezmoi source file instead of editing generated files in `$HOME`.
- When documenting changes, refer to both the source path in this repo and the target path it manages when useful.
- Exclude `.gitignore`d files and directories from repository structure and file inventories.

## Cross-OS parity (CachyOS ↔ macOS)
This repo targets both CachyOS (Arch) and macOS; keep installs and configs equivalent on both where it makes sense.
- When adding or changing a package, app, extension, or config for one OS, ask the user whether they also want the equivalent change on the other OS (e.g. a pacman/paru package on CachyOS → a Homebrew formula/cask on macOS, and vice versa).
- **Always ask before applying the change to the other OS. Never do it without explicit sign-off**, even if the equivalent seems obvious.
- When asking, name the proposed equivalent (package name, install method, config path) so the user can confirm or correct it.
- Skip the question for things that only make sense on one OS, but mention that you skipped it and why. Examples:
  - macOS-only software or settings (e.g. Homebrew bootstrap, macOS-only casks/apps).
  - Linux/CachyOS-only software or settings (e.g. systemd services, pacman/paru, Linux-only daemons).
  - Tools with no reasonable equivalent on the other OS.
- Config files that live at different paths per OS (e.g. VS Code user settings: `~/.config/Code/User/settings.json` on Linux vs `~/Library/Application Support/Code/User/settings.json` on macOS) need an OS-aware mapping; propose one rather than duplicating content silently.
