# vim: set ts=4 sts=4 sw=4

.PHONY: default stow unstow bootstrap

default:
	@echo "Available commands: stow, unstow, bootstrap"

# idempotent, removes stale links
stow:
	mkdir -p $(HOME)/.config
	mkdir -p $(HOME)/.local/bin
	stow --verbose --target=$(HOME) --restow home
	sudo stow --verbose --target=/etc --restow etc
	stow --verbose --target=$(HOME)/.config --restow xdg_config
	stow --verbose --target=$(HOME)/.local/bin --restow scripts

unstow:
	stow --verbose --target=$(HOME) --delete home
	sudo stow --verbose --target=/etc --delete etc
	stow --verbose --target=$(HOME)/.config --delete xdg_config
	stow --verbose --target=$(HOME)/.local/bin --delete scripts

bootstrap: stow
	# packages
	sudo apt update
	grep -v '^#' pkglist.txt | xargs sudo apt install -y
	# services
	sudo systemctl enable bluetooth
	sudo systemctl enable NetworkManager
	sudo systemctl enable systemd-timesyncd
	# suckless software
	git clone https://github.com/dborsukov/suckless ~/.suckless && cd ~/.suckless
	cd dwm && sudo make clean install && cd ..
	cd dmenu && sudo make clean install && cd ..
	cd dwmblocks && sudo make clean install && cd ..
