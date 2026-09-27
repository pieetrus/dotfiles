PACKAGES := alacritty btop fish git gtk hypr kitty micro noctalia nvim qt swash uwsm xdg xsettingsd

.PHONY: stow unstow restow dconf-save dconf-load pkg-save
stow:
	stow -v $(PACKAGES)
unstow:
	stow -D -v $(PACKAGES)
restow:
	stow -R -v $(PACKAGES)
dconf-save:
	dconf dump / > dconf.ini
dconf-load:
	dconf load / < dconf.ini
pkg-save:
	pacman -Qqe > packages/pkglist.txt
	pacman -Qqem > packages/aur.txt || true
