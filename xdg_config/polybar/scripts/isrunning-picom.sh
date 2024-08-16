#!/bin/sh

case "$1" in
--toggle)
        if [ "$(pgrep -x picom)" ]; then
                notify-send -i picom "Picom: Disabled"
                pkill picom
        else
                notify-send -i picom "Picom: Enabled"
                picom
        fi
        ;;
*)
        pgrep -x picom
        ;;
esac
