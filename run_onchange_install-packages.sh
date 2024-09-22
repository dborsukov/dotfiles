#!/bin/bash
# vim: set ts=4 sw=4 expandtab:

if ! command -v nala &> /dev/null; then
    sudo apt install -y nala
fi

sudo nala install -y            \
    git                         \
    gcc                         \
    make                        \
    wget                        \
                                \
    fish                        \
    tmux                        \
    eza                         \
    zoxide                      \
                                \
    7zip                        \
    unzip                       \
    unrar                       \
    zfsutils-linux              \
                                \
    mpv                         \
    zathura                     \
    zathura-pdf-poppler         \
                                \
    flatpak                     \
    keepassxc                   \
    qbittorrent                 \
    speedcrunch                 \
    gnome-tweaks                \
