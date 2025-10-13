#!/bin/bash

USER=endless_journey
HYPR_SIG=$(hyprctl instances | grep 'instance' | awk '{print $2}' | awk '{print substr($0, 1, length($0)-1)}')
HYPR_SIG_TEST=$(hyprctl instances)

echo "$HYPR_SIG_TEST" >> /tmp/hdmi-wrapper.log

export XDG_RUNTIME_DIR=/run/user/$(id -u $USER)

sudo -u $USER /home/$USER/.config/ml4w/scripts/hdmi-hotplug.sh "$HYPR_SIG"
