#!/bin/sh
# shellcheck disable=SC1090

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xsetroot -cursor_name left_ptr
xrandr -s 1920x1080 -r 60
xrdb -merge ~/.Xresources
~/.fehbg

exec ssh-agent dbus-launch bspwm
