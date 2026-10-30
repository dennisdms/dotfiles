# AGENTS.md

`chezmoi`-managed dotfiles shared between a MacBook Air (M1, macOS) and a CachyOS (Arch) Linux desktop.

## Purpose
- Back up configs, apps, and packages across the user's machines.
- Back up packages and apps even if only one machine uses them; skip single-machine configs and fine-grained settings like screen layouts or resolutions.
- The user may also work from here to inspect the system or make local config changes and installs that stay out of chezmoi. When it's unclear whether a change belongs in the repo, ask.

## Working here
- For managed files, edit the chezmoi source here, not the generated file in `$HOME`.
- Keep it simple and declarative.
- Comments are sparse: a file header and section labels, not line-by-line explanations.
- Scripts live in `.chezmoiscripts/{common,darwin,linux}/`; OS-only scripts and files are gated in `.chezmoiignore`, not with templates.

## Cross-OS parity
Keep both machines equivalent where it makes sense. When you add or change a package, app, or config for one OS, ask whether the user wants the equivalent on the other, naming the proposed counterpart (e.g. pacman/paru package ↔ Homebrew formula/cask, and the per-OS config path). Apply it to the other OS only after explicit sign-off. For things that only make sense on one OS, skip the question and say why.

## Security
This is a public repo. Commit only content safe to publish: no API keys, tokens, passwords, hostnames, IPs, logins, emails, or other personally identifiable information. Secrets live in unmanaged files on each machine and are read at runtime. Run a security review of every change before committing.

## Git
Commit and push directly to `main` (no PRs or branches), and only after the user explicitly signs off on the push.
