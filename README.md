# dotfiles

CachyOS + Hyprland + Noctalia, managed with [GNU stow](https://www.gnu.org/software/stow/).

Each top-level directory is a stow package that mirrors `$HOME`
(e.g. `hypr/.config/hypr/hyprland.lua` -> `~/.config/hypr/hyprland.lua`).
`.stowrc` sets `--target=$HOME` and `--no-folding`, so only files are symlinked and
generated files (Noctalia themes, `fish_variables`) never end up in the repo.

## Usage
    sudo pacman -S stow
    make stow          # link everything
    make restow        # after adding files
    make unstow
    make dconf-load    # restore dconf settings
    make pkg-save      # refresh package list
    sudo pacman -S --needed - < packages/pkglist.txt   # on a fresh install

## Decisions
See [docs/adr](docs/adr).
