#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# reload X settings
xrdb -merge ~/.Xresources &

# set wallpaper
sh ~/.fehbg

# minimal compositor for shadows and stuff
# compton --config /home/arjen/.config/compton.conf -b &

# notifications
dunst &

# use xbindkeys
xbindkeys

# rofi menu
rofi -key-run SuperL-r -fuzzy

# disable touchpad while typing
syndaemon -t -k -i 2 -d &

# start the power manager
# xfce4-power-manager &

# yeah for logitech keyboard only
invertfn

# root pointy cursor looks better
xsetroot -cursor_name left_ptr

# compose key
setxkbmap -option compose:ralt

exec xmonad
#exec startxfce4
#sxhkd -f 100 &
#exec bspwm
