#!/bin/bash

TOUCHPAD_DEVICE_PATH_14="/sys"$(/home/endless_journey/.config/hypr/scripts/extract-touchpad-path.sh)"/inhibited"
echo $TOUCHPAD_DEVICE_PATH_14

if [[ -f $TOUCHPAD_DEVICE_PATH_14 ]]; then
    if grep -q "1" "$TOUCHPAD_DEVICE_PATH_14"; then
        echo 0 > $TOUCHPAD_DEVICE_PATH_14
    else
        echo 1 > $TOUCHPAD_DEVICE_PATH_14
    fi
fi

