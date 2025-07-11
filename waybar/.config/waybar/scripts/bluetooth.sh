#!/bin/bash

# Nerd Font icons
icon_off=""       # nf-md-bluetooth_off
icon_on=""        # nf-fa-bluetooth
icon_connected="" # nf-md-bluetooth_connect

# Check if Bluetooth is powered on
powered=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [[ "$powered" != "yes" ]]; then
    echo "{\"text\": \"$icon_off Bluetooth Off\", \"tooltip\": \"Bluetooth is powered off\"}"
    exit 0
fi

# Get connected devices
connected_devices=$(bluetoothctl info | grep "Name:" | awk -F': ' '{print $2}')

if [[ -n "$connected_devices" ]]; then
    # Multiple devices could be connected; join with commas
    devices=$(echo "$connected_devices" | paste -sd "," -)
    echo "{\"text\": \"$icon_connected $devices\", \"tooltip\": \"Connected to: $devices\"}"
else
    echo "{\"text\": \"$icon_on No Devices\", \"tooltip\": \"Bluetooth is on but no devices are connected\"}"
fi
