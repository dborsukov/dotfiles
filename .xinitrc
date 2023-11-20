#!/bin/sh

setxkbmap -model pc105 -layout us,ru,ua -option grp:alt_shift_toggle -option caps:ctrl_modifier
xrandr -s 1920x1080 -r 60 
xset r rate 200 25

udisksctl mount -t ntfs -b /dev/sda1
udisksctl mount -t ntfs -b /dev/sdc3

dunst &
i3-layouts &
lxsession &
megasync &
nm-applet &
udiskie &
unclutter --root &
xss-lock --transfer-sleep-lock -- i3lock --nofork &
nitrogen --restore &

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

exec i3
