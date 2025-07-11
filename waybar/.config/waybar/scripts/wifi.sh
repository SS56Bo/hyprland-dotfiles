interface = "wlan0"

state = $(nmcli -t -f DEVICE.STATE dev | grep "^interface" | cut -d: -f2)

