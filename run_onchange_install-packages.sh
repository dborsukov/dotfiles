#!/bin/bash
# vim: set ts=4 sw=4 expandtab:

if ! command -v nala &> /dev/null; then
    sudo apt install -y nala
fi

sudo nala install -y            \
    fish                        \
    tmux                        \
    wget                        \
    eza                         \
    zoxide                      \
                                \
    mpv                         \
    peazip                      \
    keepassxc                   \
                                \
    zfsutils-linux              \
