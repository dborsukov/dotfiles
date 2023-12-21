#!/bin/bash

set -e
BUILDDIR=$(pwd)
USERNAME=$(id -u -n 1000)

OK() { printf '{{ Foreground "#00cc00" "%s" }}\n' "$1" | gum format -t template; }
INFO() { printf '{{ Foreground "#00cccc" "%s" }}\n' "$1" | gum format -t template; }
WARNING() { printf '{{ Foreground "#cc9900" "%s" }}\n' "$1" | gum format -t template; }
CRITICAL() { printf '{{ Color "#ffffff" "#ff0000" "%s" }}\n' "$1" | gum format -t template; }

if [ ! -f "/sbin/paru" ] || [ ! -f "/sbin/gum" ]; then
	CRITICAL "This scripts requires 'paru' and 'gum' to be installed!"
	exit 0
fi

install_packages() {
	INFO "$(printf "Installing %s packages" "$2")"
	if ! pkgs=$(sed '/^#/d;s/+//;s/^[[:space:]]*//' "$1" 2>&1); then
		WARNING "$(printf "Package spec file is missing: '%s'" "$1")"
		return
	fi
	# shellcheck disable=SC2086
	if ! paru -S --noconfirm $pkgs; then
		WARNING "$(printf "Failed to install %s packages" "$2")"
	fi
}

install_packages "pkgs_base.md" "base"

paru -S --noconfirm --needed go
GOPATH=/home/$USERNAME/.go go install github.com/doronbehar/pistol/cmd/pistol@latest

INFO "Choose optional packages"

PLUS_PKGS=$(gum choose --no-limit "Printing" "Bluetooth" "Virtualization")

for item in $PLUS_PKGS; do
	case "$item" in
	"Printing")
		install_packages "pkgs_print.md" "printing"
		sudo systemctl enable --now cups
		;;
	"Bluetooth")
		install_packages "pkgs_bluetooth.md" "bluetooth"
		sudo systemctl enable --now bluetooth
		;;
	"Virtualization")
		install_packages "pkgs_virt.md" "virtualization"
		sudo systemctl enable --now libvirtd
		;;
	esac
done

INFO "Linking configs"

if [ ! -d "/home/$USERNAME/.config" ]; then mkdir "/home/$USERNAME/.config"; fi

ln -s "$BUILDDIR/dotconfig/dunst"			"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/fish"			"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/fontconfig"		"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/git"				"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/i3"				"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/i3blocks"		"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/kitty"			"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/lf"				"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/mimeapps.list"	"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/mpv"				"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/nsxiv"			"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/nvim"			"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/paru"			"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/rofi"			"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/xsettingsd"		"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/zathura"			"/home/$USERNAME/.config/"
ln -s "$BUILDDIR/.Xresources"				"/home/$USERNAME/.Xresources"
ln -s "$BUILDDIR/.xinitrc"					"/home/$USERNAME/.xinitrc"

INFO "Applying X11 input settings"
localectl set-x11-keymap us,ru,ua pc105 qwerty grp:alt_shift_toggle,caps:ctrl_modifier

INFO "Changing shell to Fish"
chsh -s "$(which fish)"

OK "Installation completed!"
