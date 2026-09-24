# 2. Use GNU stow to deploy dotfiles

Date: 2026-09-24
Status: Accepted

## Context
Options considered: GNU stow, chezmoi, bare git repo.

## Decision
GNU stow. The repo lives in `~/repos/dotfiles`; each top-level directory is a package
mirroring `$HOME`, symlinked into place. `.stowrc` sets `--target=$HOME` and
`--no-folding` so that only individual files are linked. Directories stay real, which
keeps app-generated files (e.g. Noctalia themes) out of the repo.

## Consequences
- Simple, no templating, no encryption. If multi-machine templating or secrets
  are needed later, revisit chezmoi.
- Editing `~/.config/...` edits the repo file directly (symlink).
- `make` targets wrap stow, dconf and package-list tasks.
