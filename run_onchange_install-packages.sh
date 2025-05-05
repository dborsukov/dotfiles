#!/bin/bash
# vim: set ts=4 sw=4 expandtab:

sudo apt update

sudo apt install -y                 \
                                    \
    git                             \
    wget                            \
    curl                            \
                                    \
    fish                            \
    tmux                            \
    eza                             \
    zoxide                          \
                                    \
    mpv                             \

flatpak install -y flathub          \
                                    \
    io.github.flattool.Warehouse    \
    com.github.tchx84.Flatseal      \
    com.brave.Browser               \
