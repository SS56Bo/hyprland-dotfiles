#!/bin/bash

chosen=$(echo -e "Shutdown\nReboot\nLogout\nLock\nSuspend" | rofi -dmenu -p "Power")

case "$chosen" in
  Shutdown) systemctl poweroff ;;
  Reboot) systemctl reboot ;;
  Logout) hyprctl dispatch exit ;;
  Lock) swaylock ;;  # or your preferred lock program
  Suspend) systemctl suspend ;;
esac

