#!/bin/bash

monitor="$1"

if [ ${#monitor} -eq 0 ]; then
    echo "Please provide a monitor name"
    exit 1
fi

hyprctl keyword monitor "$monitor,disable" 
hyprctl keyword monitor "$monitor,enable" 

waypaper --restore
