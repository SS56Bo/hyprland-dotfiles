#!/bin/bash

# Nerd Font icons
icon_disconnected="睊"  # nf-mdi-wifi_off
icon_connected=""      # nf-fa-wifi
icon_strong="直"        # nf-mdi-wifi_strength_4
icon_medium="盛"        # nf-mdi-wifi_strength_2
icon_weak="益"          # nf-mdi-wifi_strength_1

interface="wlan0"

state=$(nmcli -t -f DEVICE,STATE dev | grep "^$interface" | cut -d: -f2)

if [[ "$state" == "connected" ]] || [[ "$state" == "100" ]]; then
    essid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1 == "yes" {print $2}')
    strength=$(nmcli -t -f ACTIVE,SIGNAL dev wifi | awk -F: '$1 == "yes" {print $2}')

    essid="${essid:-Unknown}"
    strength="${strength:-0}"

    # Choose icon based on signal strength
    if (( strength >= 75 )); then
        icon="$icon_strong"
    elif (( strength >= 40 )); then
        icon="$icon_medium"
    else
        icon="$icon_weak"
    fi

    echo "{\"text\": \"$icon $essid ($strength%)\", \"tooltip\": \"Connected to $essid with $strength% signal\"}"
else
    echo "{\"text\": \"$icon_disconnected Disconnected\", \"tooltip\": \"No active Wi-Fi connection\"}"
fi
