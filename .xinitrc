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

# gnome-keyring support
# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# set wallpaper
sh ~/.fehbg

# minimal compositor for shadows and stuff
xcompmgr -c -t-5 -l-5 -r4.2 -o.55 -f -D 2 &

# notifications
dunst &

# use xbindkeys
xbindkeys

# disable touchpad while typing
syndaemon -t -k -i 2 -d &

# start the power manager
xfce4-power-manager &

# setup external screen if connected
if `xrandr | grep "HDMI1 connected" -q`
then
	echo "done" > ~/.bla
	setup-hd &
fi

exec i3
