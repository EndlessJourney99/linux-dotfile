#!/bin/bash
number_of_monitor=`xrandr | grep -w connected  | awk -F'[ +]' '{print $1}' | wc -l`

monitor_input=$(($1%$number_of_monitor))
if [ $monitor_input -eq 0 ]; then
    monitor_input=$number_of_monitor
fi

moniotor=`xrandr | grep -w connected  | awk -F'[ +]' '{print $1}' | sed "$monitor_input!d"`

current_workspace=`hyprctl activeworkspace -j | jq '.id'`
hyprctl dispatch moveworkspacetomonitor "$current_workspace" "$moniotor"