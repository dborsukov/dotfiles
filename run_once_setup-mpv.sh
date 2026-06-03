#!/bin/bash

mkdir -p ~/.config/mpv/scripts

# uosc
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tomasklaen/uosc/HEAD/installers/unix.sh)"
# thumbfast
wget -P ~/.config/mpv/scripts https://raw.githubusercontent.com/po5/thumbfast/refs/heads/master/thumbfast.lua
# autoload
wget -P ~/.config/mpv/scripts https://raw.githubusercontent.com/mpv-player/mpv/refs/heads/master/TOOLS/lua/autoload.lua
