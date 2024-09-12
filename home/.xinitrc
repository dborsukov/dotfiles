#!/bin/sh

xrandr -s 1920x1080 -r 60
xsetroot -cursor_name left_ptr
xset s off -dpms # do not turn off display

~/.fehbg
xrdb -merge ~/.Xresources & xrdbpid=$!

autostart="dunst dwmblocks unclutter nm-applet blueman-applet mega-cmd-server /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1"

for program in $autostart; do
	pidof -sx "$program" || "$program" &
done >/dev/null 2>&1

# Ensure that xrdb has finished running before moving on
[ -n "$xrdbpid" ] && wait "$xrdbpid"

dbus-update-activation-environment --all
dbus-launch --exit-with-session ssh-agent dwm
