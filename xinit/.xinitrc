# Source the .Xresources file
xrdb ~/.Xresources

# Source the files in the xinitrc.d directory
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Set background image
feh --bg-scale ~/dotfiles/wallpapers/background.jpg

# Start the window manager
exec i3

# vim:ft=sh