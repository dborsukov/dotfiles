#!/bin/bash

sudo apt update && sudo apt install -y curl wget unzip

mkdir -p ~/.config/mpv/scripts

# uosc
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tomasklaen/uosc/HEAD/installers/unix.sh)"

# misc
wget -P ~/.config/mpv/scripts https://raw.githubusercontent.com/po5/thumbfast/refs/heads/master/thumbfast.lua
wget -P ~/.config/mpv/scripts https://raw.githubusercontent.com/mpv-player/mpv/refs/heads/master/TOOLS/lua/autoload.lua
