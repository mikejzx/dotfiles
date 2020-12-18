#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults and keymaps
[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

# Start scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Key input rate adjustment.
xset r rate 200 25 &

# Swap caps-lock and escape.
setxkbmap -option caps:swapescape &

# Turn on numlock if it's not on yet
numlockx on &

# Allows us to use some bound multimedia keys
xbindkeys &

# Start the GPU fan controller.
gpu-fancurve &

# Start gpg agent
gpg-agent &

# Try fix Vsync
export __GL_SYNC_TO_VBLANK=1

# Start Fluxbox session
exec startfluxbox
