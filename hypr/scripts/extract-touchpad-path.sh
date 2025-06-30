#!/bin/sh

cat /proc/bus/input/devices | awk '
  BEGIN { in_block = 0; sysfs = ""; name = "" }
  /^I:/ { in_block = 1; sysfs = ""; name = "" }
  /^N: Name=/ { name = $0 }
  /^S: Sysfs=/ { sysfs = $0 }
  /^$/ {
    if (in_block && name ~ /[Tt]ouchpad/) {
      print sysfs
    }
    in_block = 0
  }
' | cut -d= -f2
