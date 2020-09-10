#!/bin/sh
# Source the .Xresources file
xrdb ~/.Xresources

# Source the files in the xinitrc.d directory
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Monitor Layout
xrandr --output DVI-D-0 --off --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --mode 3840x2160 --pos 0x0 --rotate normal --output DP-3 --off --output DP-4 --mode 2560x1440 --pos 3840x1184 --rotate normal --output DP-5 --off &

# Power Save Disable
xset s off &
xset -dpms &

# Start Dropbox
dropbox start &

# Start the window manager
exec i3

# vim:ft=sh