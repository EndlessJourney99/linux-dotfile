#!/bin/bash

# detect monitors
# HYPR_INSTANCE=$1

INTERNAL="eDP-1"
EXTERNAL="HDMI-A-1"

if hyprctl monitors | grep -q "$EXTERNAL"; then
    # external monitor connected -> disable laptop screen
    # echo "HDMI hotplug script with external monitor ran at $(date)" >> /tmp/hdmi-hook.log
    hyprctl keyword monitor "$INTERNAL, disable"
    hyprctl keyword monitor "$EXTERNAL, 2560x1440@100, 0x0, 1"
else
    # external monitor disconnected -> re-enable laptop screen
    # echo "HDMI hotplug script with internal monitor only ran at $(date)" >> /tmp/hdmi-hook.log
    hyprctl keyword monitor "$INTERNAL, 3072x1920@120, 0x0, 2"
    hyprctl keyword monitor "$EXTERNAL, 2560x1440@100, 1536x0, 1"
fi


# Example: run xrandr to auto-switch display
# kitty
# waypaper --restore
