#!/usr/bin/env bash

source $(dirname $0)/config.sh

vol_lvl=$(pactl list sinks | grep '^[[:space:]]Volume:')
vol_lvl=${vol_lvl##*Volume:}
vol_lvl=${vol_lvl%\%*}
vol_lvl=${vol_lvl#*\/[[:space:]]}
vol_lvl=${vol_lvl%\%*}
vol_stat=$(pacmd list-sinks | grep muted)
vol_stat=${vol_stat##*muted}
vol_stat=${vol_stat#*:[[:space:]]}

if [ $vol_lvl -lt 1 ] || [ $vol_stat == "yes" ]; then
    ICON="volume0.xbm"
elif [ $vol_lvl -lt 35 ]; then
    ICON="volume25.xbm"
elif [ $vol_lvl -lt 60 ]; then
    ICON="volume50.xbm"
elif [ $vol_lvl -lt 85 ]; then
    ICON="volume75.xbm"
else
    ICON="volume100.xbm"
fi

if [ $vol_lvl -gt 100 ]; then
    vol_ovr=$(( $(($vol_lvl - 100)) * 2 ))
    PERCBAR=$(echo 100\
        | gdbar -bg $bar_bg -fg $foreground -h 3 -w 50 -s o)
    PERCBAR_ovr=$(echo "$vol_ovr"\
        | gdbar -bg $bar_bg -fg "#ff0000" -h 3 -w 25 -s o)
else
    PERCBAR=$(echo "$vol_lvl"\
        | gdbar -bg $bar_bg -fg $foreground -h 3 -w 50 -s o)
    PERCBAR_ovr=$(echo 0\
        | gdbar -bg $bar_bg -fg "#ff0000" -h 3 -w 25 -s o)
fi

ICON='^i(.xmonad/dzen2/'"$ICON)"
echo "$ICON $PERCBAR$PERCBAR_ovr"
