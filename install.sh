#!/bin/bash

BUILDDIR=$(pwd)
USERNAME=$(id -u -n 1000)

LINK() {
        rm -rf "$2:?"/"$1"
        ln -sf "$1" "$2"
}

set -e
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

dev_pkgs="lazygit"
env_pkgs="wofi mako wlogout swaylock-effects swayidle wl-clipboard hyprpaper polkit-kde-agent hyprpicker-git"    
fms_pkgs="lf poppler ffmpegthumbnailer thunar thunar-archive-plugin file-roller"    
font_pkgs="ttf-jetbrains-mono-nerd ttf-ms-fonts"
hypr_pkgs="hyprland pipewire wireplumber pamixer xdg-desktop-portal-hyprland-git"    
media_pkgs="mpv zathura zathura-cb zathura-djvu zathura-pdf-mupdf viewnior"
misc_pkgs="firefox keepassxc telegram-desktop"
term_pkgs="xterm kitty neovim fd ripgrep pacman-contrib"
theme_deps_pkgs="gtk-engine-murrine ghome-themes-extra qt5-wayland qt6-wayland nwg-look-bin"
theme_pack_pkgs="papirus-icon-theme bibata-cursor-theme"

if ! yay -S --noconfirm "$dev_pkgs" \
                        "$env_pkgs" \
                        "$fms_pkgs" \
                        "$font_pkgs" \
                        "$hypr_pkgs" \
                        "$media_pkgs" \
                        "$misc_pkgs" \
                        "$term_pkgs" \
                        "$theme_deps_pkgs" \
                        "$theme_pack_pkgs" \
                        2>&1 | tee -a $LOG; then
    printf "%s Failed to install packages, check the install.log\n" "$RED"
    exit 1
fi

printf "%s All necessary packages installed successfully." "$GREEN"

############################################  CONFIGS  ############################################

printf "Linking configs \n"

mkdir "/home/$USERNAME/.config"

LINK "$BUILDDIR/dotconfig/git"          "/home/$USERNAME/.config"
LINK "$BUILDDIR/dotconfig/hypr"         "/home/$USERNAME/.config"
LINK "$BUILDDIR/dotconfig/kitty"        "/home/$USERNAME/.config"
LINK "$BUILDDIR/dotconfig/lf"           "/home/$USERNAME/.config"
LINK "$BUILDDIR/dotconfig/mako"         "/home/$USERNAME/.config"
LINK "$BUILDDIR/dotconfig/nvim"         "/home/$USERNAME/.config"
LINK "$BUILDDIR/dotconfig/swaylock"     "/home/$USERNAME/.config"
LINK "$BUILDDIR/dotconfig/waybar"       "/home/$USERNAME/.config"
LINK "$BUILDDIR/dotconfig/wlogout"      "/home/$USERNAME/.config"

###########################################  BLUETOOTH  ###########################################

read -n1 -rep "${CAT} OPTIONAL - Install Bluetooth packages? (y/n)" BLUETOOTH
if [[ $BLUETOOTH =~ ^[Yy]$ ]]; then
    printf "Installing Bluetooth Packages...\n"
    pkgs="bluez bluez-utils blueman"
    if ! yay -S --noconfirm "$pkgs" 2>&1 | tee -a $LOG; then
       	printf "%s Failed to install bluetooth packages, check the install.log" "$RED"    
    printf "Activating Bluetooth Services...\n"
    sudo systemctl enable --now bluetooth.service
    sleep 2
    fi
else
    printf "%s No bluetooth packages installed..\n" "$YELLOW"
fi

###########################################  PRINTING  ############################################

read -n1 -rep "${CAT} OPTIONAL - Install printing packages? (y/n)" PRINTING
if [[ $PRINTING =~ ^[Yy]$ ]]; then
    printf "Installing printing packages...\n"
    pkgs="cups gutenprint foomatic-db-gutenprint-ppds"
    if ! yay -S --noconfirm "$pkgs" 2>&1 | tee -a $LOG; then
       	printf "%s Failed to install printing packages, check the install.log" "$RED"    
    printf "Activating printing services...\n"
    sudo systemctl enable --now cups
    sleep 2
    fi
else
    printf "%s No printing packages installed..\n" "$YELLOW"
fi

########################################  VIRTUALIZATION  #########################################

read -n1 -rep "${CAT} OPTIONAL - Install virtualization packages? (y/n)" VIRTUALIZATION
if [[ $VIRTUALIZATION =~ ^[Yy]$ ]]; then
    printf "Installing virtualization packages...\n"
    pkgs="qemu virt-manager virt-viewer vde2 dmidecode dnsmasq bridge-utils openbsd-netcat libguestfs"
    if ! yay -S --noconfirm "$pkgs" 2>&1 | tee -a $LOG; then
       	printf "%s Failed to install virtualization packages, check the install.log" "$RED"
    printf "Activating virtualization services...\n"
    sudo systemctl enable --now libvirtd
    sleep 2
    fi
else
    printf "%s No virtualization packages installed..\n" "$YELLOW"
fi
    
printf "\n%s Installation Completed.\n" "$GREEN"
