#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export PATH=$HOME/bin:/usr/local/bin:/usr/local/go/bin:$PATH:$GOPATH/bin:$HOME/.local/bin:

# set key repeat rate
xset r rate 225 50

# set refresh rate on main monitor
xrandr --output DP-4 --mode 2560x1440 --rate 165

#remap caps-lock
setxkbmap -option caps:escape &

# restore wal
wal -R

# exec i3
exec i3
