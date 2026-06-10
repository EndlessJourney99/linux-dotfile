#!/usr/bin/sh

LOCK_SCREEN_PRIMARY_PATH="/home/endless_journey/.config/hypr/hyprlock/primary-screen.conf"
LOCK_SCREEN_DEFAULT_PATH="/home/endless_journey/.config/hypr/hyprlock/default.conf"


HYPRLOCK_CONFIGURATION_FILE="/home/endless_journey/.config/hypr/hyprlock.conf"
MONITOR_FILE="/sys/class/drm/card1-HDMI-A-1/status"

# Check if the file exists first
if [ -f "$MONITOR_FILE" ]; then
    # Read the file content
    STATUS=$(cat "$MONITOR_FILE")


    # STATUS value will be the previous one at this point when this script was triggered by udev rules, which means it did not updated to the new value yet.
    # Which also means, if it is "disconnected" -> mean we just plug the display port in. If it is "connected" -> mean we just unplugged it.
    if [ "$STATUS" = "connected" ]; then
        echo "source = $LOCK_SCREEN_DEFAULT_PATH" > $HYPRLOCK_CONFIGURATION_FILE 
        # Add your commands here (like resetting Hyprland or Hyprlock)
    else
        echo "source = $LOCK_SCREEN_PRIMARY_PATH" > $HYPRLOCK_CONFIGURATION_FILE 
    fi
else
    echo "Error: The monitor file does not exist."
fi

hyprlock
