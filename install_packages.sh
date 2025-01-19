#!/bin/bash

if ! command -v nala &> /dev/null; then
    sudo apt install -y nala
fi

sudo nala install -y            \
    eza                         \
    fish                        \
    tmux                        \
    zoxide                      \
                                \
    mpv                         \
    keepassxc                   \
                                \
    zfsutils-linux              \
