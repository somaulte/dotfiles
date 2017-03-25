#!/bin/bash

pactl set-sink-$1 0 $2

vol_lvl=$(pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

if [[ vol_lvl -gt 150 ]]; then
      pactl set-sink-$1 0 150%
fi
