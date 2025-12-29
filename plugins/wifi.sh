#!/bin/sh

# 1. Get the Wi-Fi interface (e.g., en0)
WIFI_DEV=$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')

# 2. Use ipconfig to get the summary, and grep for the SSID line
# ipconfig getsummary prints a clean list of details for the interface
SSID=$(ipconfig getsummary "$WIFI_DEV" | awk -F ' SSID : '  '/ SSID : / {print $2}')

if [ -n "$SSID" ]; then
  # --- CONNECTED ---
  sketchybar --set "$NAME" label="$SSID" \
             --set wifiPopup icon="􀙇" \
             --set wifiPopup icon.color=0xff94e2d5 \
             --set wifiPopup icon.font.size=19
else
  # --- DISCONNECTED ---
  sketchybar --set "$NAME" label="Not Connected" \
             --set wifiPopup icon="􀙈" \
             --set wifiPopup icon.color=0xfff38ba8 \
             --set wifiPopup icon.font.size=19
fi
