# 1. What to track in the dotfiles repository

Date: 2026-09-24
Status: Accepted

## Context
Fresh CachyOS + Hyprland + Noctalia setup. We need to decide what belongs in the
repo. Rule of thumb: "would I be annoyed to lose this?" -> in. Regenerable, cached,
secret or machine-specific -> out.

## Decision

### Tracked
| Package | Files | Notes |
|---|---|---|
| `hypr` | `hyprland.lua`, `xdph.conf`, `config/*.lua` | Main compositor config. `variables.lua` / `monitors.lua` are machine-specific: external Dell on `HDMI-A-1` is primary, laptop panel `eDP-1` disabled |
| `noctalia` | `config.toml` | Shell config |
| `fish` | `config.fish` | Shell setup |
| `kitty` | `kitty.conf` | Theme file excluded (generated) |
| `alacritty` | `alacritty.toml` | Theme file excluded (generated) |
| `uwsm` | `env` | Session environment variables |
| `btop` | `btop.conf` | Theme file excluded (generated) |
| `micro` | `settings.json`, `colorschemes/` | `syntax/` (664K downloaded) excluded |
| `gtk` | `gtk-3.0/{settings.ini,gtk.css}`, `gtk-4.0/gtk.css` | `noctalia.css` excluded (generated) |
| `qt` | `qt6ct/qt6ct.conf` | `colors/noctalia.conf` excluded (generated) |
| `xsettingsd`, `swash` | config files | Small, annoying to recreate |
| `xdg` | `mimeapps.list`, `user-dirs.dirs` | Default apps, XDG folders |
| `git` | `~/.gitconfig` | Points at `gh` as credential helper; `[user]` name/email live in an untracked `~/.gitconfig.local` (included via `[include]`), created manually per machine |
| — | `dconf.ini` | Text dump of dconf (`make dconf-save`); the binary DB is not tracked |
| — | `packages/pkglist.txt` | `pacman -Qqe`; `aur.txt` is not kept while there are no foreign packages |

### Not tracked
- `~/.config/mozilla/` (96M): Firefox profile with cookies, sessions, logins. Use Firefox Sync.
- `gh/hosts.yml`: auth state; run `gh auth login` on a new machine. (`gh/config.yml` is harmless but also skipped.)
- `pulse/cookie`: per-machine auth blob.
- `~/.claude.json`, `~/.claude/`: credentials and session history. Add only `CLAUDE.md` / `settings.json` / skills explicitly if wanted later.
- `~/.cache`, `~/.viminfo`, `.zcompdump*`: generated.
- `.bashrc`, `.bash_profile`, `.zshrc`, `.bash_logout`: unused (fish) CachyOS defaults.
- `autostart/cachyos-hello.desktop`, `cachyos/`, `cachyos-hello.json`: CachyOS Hello state.
- `menus/`, `dolphinrc`, `kdeglobals`: noisy, rewritten constantly; add only if customised.
- `fish/fish_variables`: rewritten by fish on every change; put settings in `config.fish`.
- Noctalia-generated theme files (`**/noctalia.*`, `themes/noctalia.*`): produced by Noctalia's template processor; tracking them would make Noctalia write into the repo.

## Rules
1. Secrets never go in the repo, even if it is private.
2. Don't commit generated files.
3. Keep machine-specific settings (monitor names, GPU env vars) isolated so a second machine is easy.
4. Check `git status` and `.gitignore` before committing.

## Consequences
A new machine is bootstrapped with: install packages from the list, `make stow`,
`make dconf-load`, `gh auth login`, sign in to Firefox Sync, and creating
`~/.gitconfig.local` with:
```
[user]
	name = Your Name
	email = you@example.com
```
Adding a new app = new package directory + entry in the `Makefile` and this ADR.

Since this repo is public, commits use GitHub's private noreply email
(`git config user.email "<id>+<username>@users.noreply.github.com"`, set
locally per clone via `.git/config`, not tracked) instead of the real address
in `~/.gitconfig.local`.
