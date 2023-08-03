#!/usr/bin/env sh

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

if [ "$SSID" = "" ]; then
  sketchybar --set $NAME label="Disconnected" icon=󱛅 icon.color=0xffed8796
  sketchybar --set wifiPopup icon.color=0xffed8796
else
  sketchybar --set $NAME label="$SSID (${CURR_TX}Mbps)" icon=󱚽 icon.color=0xff7dc4e4
  sketchybar --set wifiPopup icon.color=0xff7dc4e4

fi





