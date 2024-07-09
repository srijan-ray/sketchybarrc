#!/bin/sh

# The wifi_change event supplies a $INFO variable in which the current SSID
# is passed to the script.

INFO="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}' | xargs networksetup -getairportnetwork | sed "s/Current Wi-Fi Network: //")"
INFO_LENGTH="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}' | xargs networksetup -getairportnetwork | sed "s/Current Wi-Fi Network: //" | wc -m | grep -o '[0-9]*')"
if [[ "$INFO_LENGTH" = "78" ]]; then
    sketchybar --set $NAME label="Not Connected" 
    sketchybar --set wifiPopup icon="􀙈" 
    sketchybar --set wifiPopup icon.color=0xfff38ba8 
    sketchybar --set wifiPopup icon.font.size=19 
else
    sketchybar --set $NAME label="${INFO}" 
    sketchybar --set wifiPopup icon.color=0xff94e2d5 
    sketchybar --set wifiPopup icon="􀙇" 
    sketchybar --set wifiPopup icon.font.size=19 
fi
