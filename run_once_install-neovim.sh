#!/bin/bash
# vim: set ts=4 sw=4 expandtab:

if ! command -v nala &> /dev/null; then
    sudo apt install -y nala
fi

sudo add-apt-repository ppa:neovim-ppa/unstable -y

sudo nala update

sudo nala install -y            \
    neovim                      \
                                \
    nodejs                      \
    npm                         \
                                \
    python3                     \
    python3-pip                 \
    python3-venv                \
                                \
    fzf                         \
    fd-find                     \
    ripgrep                     \
