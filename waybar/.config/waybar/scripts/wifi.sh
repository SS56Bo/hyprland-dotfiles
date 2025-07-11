#!/bin/bash

# Nerd Font icons
icon_connected=""      # nf-fa-wifi


interface="wlan0"

state=$(nmcli -t -f DEVICE,STATE dev | grep "^$interface" | cut -d: -f2)

if [[ "$state" == "connected" ]] || [[ "$state" == "100" ]]; then
    essid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1 == "yes" {print $2}')
    strength=$(nmcli -t -f ACTIVE,SIGNAL dev wifi | awk -F: '$1 == "yes" {print $2}')

    essid="${essid:-Unknown}"
    strength="${strength:-0}"

    echo "{\"text\": \"$icon $essid ($strength%)\", \"tooltip\": \"Connected to $essid with $strength% signal\"}"
else
    echo "{\"text\": \"$icon_disconnected Disconnected\", \"tooltip\": \"No active Wi-Fi connection\"}"
fi
