#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

udisksctl mount -t ntfs -b /dev/sda1
udisksctl mount -t ntfs -b /dev/sdc3

xsetroot -cursor_name left_ptr
xrandr -s 1920x1080 -r 60
xrdb -merge ~/.Xresources

exec bspwm
