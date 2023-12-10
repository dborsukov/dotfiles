#!/bin/bash

set -e

BUILDDIR=$(pwd)
USERNAME=$(id -u -n 1000)

LOG="install.log"
RED="$(tput setaf 1)[ERROR]$(tput sgr0)"
GREEN="$(tput setaf 2)[OK]$(tput sgr0)"
YELLOW="$(tput setaf 3)[NOTE]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"

if [ ! -f "/sbin/yay" ]; then
	printf "%s yay is required for this script, now exiting\n" "$RED"
	exit
fi

############################################  PACKAGES  ###########################################

printf "%s Installing packages\n" "$GREEN"

printf "%s Installing pistol for lf\n" "$GREEN"

yay -S --noconfirm --needed go
GOPATH=/home/$USERNAME/.go go install github.com/doronbehar/pistol/cmd/pistol@latest

apps_tier_1="firefox keepassxc telegram-desktop megasync-bin"
apps_tier_2="pcmanfm-gtk3 gvfs ffmpegthumbnailer xarchiver udisks2 udiskie"
apps_tier_3="poppler inetutils"
de_tier_1="xorg-server xorg-xinit xterm xclip i3 i3blocks i3-layouts dunst rofi lxsession-gtk3"
de_tier_2="pactl alsa-utils network-manager-applet lm_sensors sysstat xss-lock"
de_tier_3="nitrogen scrot unclutter"
eyecandy="qt5ct lxappearance-gtk3 kvantum arc-gtk-theme xcursor-human hicolor-icon-theme papirus-icon-theme"
fonts="ttf-jetbrains-mono-nerd"
media="mpv sxiv zathura zathura-cb zathura-djvu zathura-pdf-mupdf"
neovim="neovim fd fzf ripgrep tree-sitter-cli"
term="kitty fish autojump exa lf lazygit"

if ! yay -S --noconfirm \
	$apps_tier_1 \
	$apps_tier_2 \
	$apps_tier_3 \
	$de_tier_1 \
	$de_tier_2 \
	$de_tier_3 \
	$eyecandy \
	$fonts \
	$media \
	$neovim \
	$term \
	2>&1 | tee -a $LOG; then
	printf "%s Failed to install packages, check the install.log\n" "$RED"
	exit 1
fi

printf "%s All necessary packages installed successfully. \n" "$GREEN"

############################################  CONFIGS  ############################################

printf "Linking configs \n"

if [ ! -d "/home/$USERNAME/.config" ]
then
	mkdir "/home/$USERNAME/.config"
fi

ln -s "$BUILDDIR/dotconfig/dunst"          "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/fish"           "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/git"            "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/i3"             "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/i3blocks"       "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/kitty"          "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/lf"             "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/mimeapps.list"  "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/mpv"            "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/nvim"           "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/dotconfig/rofi"           "/home/$USERNAME/.config/"
ln -s "$BUILDDIR/.xinitrc"                 "/home/$USERNAME/.xinitrc"

###########################################  BLUETOOTH  ###########################################

read -n1 -rep "${CAT} OPTIONAL - Install Bluetooth packages? (y/n)" BLUETOOTH
if [[ $BLUETOOTH =~ ^[Yy]$ ]]; then
	printf "Installing Bluetooth Packages...\n"
	pkgs="bluez bluez-utils blueman"
	if ! yay -S --noconfirm $pkgs 2>&1 | tee -a $LOG; then
		printf "%s Failed to install bluetooth packages, check the install.log" "$RED"
		sleep 2
	fi
	printf "Activating Bluetooth Services...\n"
	sudo systemctl enable --now bluetooth.service
else
	printf "%s No bluetooth packages installed..\n" "$YELLOW"
fi

###########################################  PRINTING  ############################################

read -n1 -rep "${CAT} OPTIONAL - Install printing packages? (y/n)" PRINTING
if [[ $PRINTING =~ ^[Yy]$ ]]; then
	printf "Installing printing packages...\n"
	pkgs="cups gutenprint foomatic-db-gutenprint-ppds"
	if ! yay -S --noconfirm $pkgs 2>&1 | tee -a $LOG; then
		printf "%s Failed to install printing packages, check the install.log" "$RED"
		sleep 2
	fi
	printf "Activating printing services...\n"
	sudo systemctl enable --now cups
else
	printf "%s No printing packages installed..\n" "$YELLOW"
fi

########################################  VIRTUALIZATION  #########################################

read -n1 -rep "${CAT} OPTIONAL - Install virtualization packages? (y/n)" VIRTUALIZATION
if [[ $VIRTUALIZATION =~ ^[Yy]$ ]]; then
	printf "Installing virtualization packages...\n"
	pkgs="qemu virt-manager virt-viewer vde2 dmidecode dnsmasq bridge-utils openbsd-netcat libguestfs"
	if ! yay -S --noconfirm $pkgs 2>&1 | tee -a $LOG; then
		printf "%s Failed to install virtualization packages, check the install.log" "$RED"
		sleep 2
	fi
	printf "Activating virtualization services...\n"
	sudo systemctl enable --now libvirtd
else
	printf "%s No virtualization packages installed..\n" "$YELLOW"
fi

printf "\n%s Installation Completed.\n" "$GREEN"

printf "Applying x11 keyboard settings"
localectl set-x11-keymap us,ru,ua pc105 qwerty grp:alt_shift_toggle,caps:ctrl_modifier

printf "Changing shell to fish\n"
chsh -s $(which fish)
