# Chezmoi

To add a file:
`chezmoi add .config`

To edit a file:
`chezmoi edit .config`

To apply a file chezmoi -> local
`chezmoi apply .config`

To apply a file local -> chezmoi
`chezmoi re-add .config`

Chezmoi directory
`~/.local/share/chezmoi`

Bootstrap

Linux:
```bash
command -v chezmoi >/dev/null \
  && chezmoi update \
  || sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:dennisdms/dotfiles.git
```
