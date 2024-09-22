#!/bin/bash

if ! command -v nala &> /dev/null; then
    sudo apt install -y nala
fi

sudo nala update && sudo nala install -y curl

curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash

~/.local/bin/getnf -i IosevkaTerm
