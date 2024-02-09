# vim: ts=2:sts=2:sw=2

[private]
default:
  @just --list

# link dotfiles, idempotent, removes stale links
stow:
	@stow --verbose --target=$HOME --restow */

# remove all links
unstow:
	@stow --verbose --target=$HOME --delete */

[private]
gen-packages:
	sed '/^#/d;s/+//;s/^[[:space:]]*//;/^[[:space:]]*$/d' packages.md > /tmp/pkglist

# install packages from "packages.md"
install-packages: gen-packages
	paru -S --noconfirm - < /tmp/pkglist

# use "localectl" to create keyboard config
conf-keyboard:
	sudo rm /etc/X11/xorg.conf.d/00-keyboard.conf
	localectl set-x11-keymap us,ru,ua pc105 qwerty grp:win_space_toggle,caps:ctrl_modifier
	sudo sed -i '$i\Option "AutoRepeat" "200 28"' /etc/X11/xorg.conf.d/00-keyboard.conf
