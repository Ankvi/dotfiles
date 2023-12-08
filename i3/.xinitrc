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

# autorandr --load $(autorandr | grep "detected" | cut -d " " -f1)
xrandr --output DP-0 --mode 5120x1440 --primary --rate 239.76 --pos 0x1440 --output HDMI-0 --mode 2560x1440 --rate 59.95 --right-of DP-0

numlockx &

xmodmap -e 'keycode 108 = Hyper_R'
xmodmap -e 'add mod5 = Hyper_R'

xmodmap -e 'keykode 135 = Menu'
xmodmap -e 'add mod3 = Menu'

exec i3
