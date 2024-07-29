#!/bin/bash

start() {
	if ! pgrep -f "$1";
	then
		"$@"&
	fi
}
#start conky -dc $HOME/.config/awesome/system-overview
start feh --bg-fill "/home/eric/Pictures/Wallpaper/360671.png" &
start /usr/libexec/at-spi-bus-launcher --launch-immediately &
start /usr/libexec/at-spi2-registryd &
start xfsettingsd &
start nm-applet & 
start blueman-applet &
start /opt/freedownloadmanager/fdm --hidden &
start /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
start start-pulseaudio-x11 &
start light-locker & 
#start mintreport-tray &
#start mintupdate-launcher &
start /usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd &
start xiiccd &
start xfce4-power-manager &
start picom &
#start volumeicon &
