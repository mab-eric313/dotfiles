#!/bin/bash

export $(dbus-launch)
export XDG_CURRENT_DESKTOP=qtile
export XDG_SESSION_TYPE=x11
export XDG_SESSION_DESKTOP=qtile
export QT_QPA_PLATFORMTHEME=gtk2

start() {
	if ! pgrep -f "$1";
	then
		"$@"&
	fi
}
#start conky -dc $HOME/.config/awesome/system-overview
# start feh --bg-fill "/home/eric/Pictures/Wallpaper/360671.png" &
start feh --bg-fill "/home/eric/Pictures/Wallpaper/Thirty_Years'_War.jpg"
# start feh --bg-fill --geometry 1366x768+1000-1500 "/home/eric/Pictures/Wallpaper/arnold_bocklin-self-portrait_with_fiddling_death-1872-obelisk-art-history-1.jpg"
start /usr/libexec/at-spi-bus-launcher --launch-immediately &
start /usr/libexec/at-spi2-registryd &
start xfsettingsd &
start nm-applet & 
start blueman-applet &
start /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
start start-pulseaudio-x11 &
start light-locker & 
#start mintreport-tray &
#start mintupdate-launcher &
start /usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd &
start xiiccd &
start xfce4-power-manager &
#start volumeicon &
start /opt/abdownloadmanager/bin/ABDownloadManager --background & 
start xdg-desktop-portal &
start xdg-desktop-portal-gtk &

python3 $HOME/.config/qtile/batteryLimit.py &
