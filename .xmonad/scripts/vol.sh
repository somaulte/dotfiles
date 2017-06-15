#!/bin/bash

sink="alsa_output.pci-0000_22_00.3.analog-stereo"

pactl set-sink-$1 $sink $2

vol_lvl=$(pactl list sinks | grep '^[[:space:]]Volume:')
vol_lvl=${vol_lvl##*Volume:}
vol_lvl=${vol_lvl%\%*}
vol_lvl=${vol_lvl#*\/[[:space:]]}
vol_lvl=${vol_lvl%\%*}

if [[ vol_lvl -gt 150 ]]; then
      pactl set-sink-$1 $sink 150%
fi
