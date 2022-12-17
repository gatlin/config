#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# refresh rate
xset r rate 250 60

# background color
xsetroot -solid black &

# status bar
slstatus &

# input configuration
setxkbmap -option ctrl:swapcaps
setxkbmap -option compose:ralt
xbindkeys
#ibus-daemon -drxR

source /etc/X11/Xsession &
dbus-update-activation-environment --systemd DISPLAY
# here we go!
exec dwm
