#!/bin/bash

source $(dirname $0)/config.sh

BAT=$(head -n 1 /sys/class/power_supply/BAT*/capacity)
	if [[ $BAT -gt 100 ]]; then
		BAT=100
	fi
color=""

if [[ $BAT -lt 10 ]]; then
	ICON="battery10.xbm"
	color="^fg($warning)"
	notify-send "Warning, battery level below 10 percent" -u critical -t 30000
elif [[ $BAT -lt 20 ]]; then
	ICON="battery20.xbm"
	color="^fg($warning)"
elif [[ $BAT -lt 30 ]]; then
	ICON="battery30.xbm"
	color="^fg($notify)"
elif [[ $BAT -lt 40 ]]; then
	ICON="battery40.xbm"
	color="^fg($notify)"
elif [[ $BAT -lt 50 ]]; then
	ICON="battery50.xbm"
elif [[ $BAT -lt 60 ]]; then
	ICON="battery60.xbm"
elif [[ $BAT -lt 70 ]]; then
	ICON="battery70.xbm"
elif [[ $BAT -lt 80 ]]; then
	ICON="battery80.xbm"
elif [[ $BAT -lt 90 ]]; then
	ICON="battery90.xbm"
else
	ICON="battery90.xbm"
fi

ICON='^i(/home/somaulte/.xmonad/dzen2/'"$ICON)"
echo "$color$ICON $BAT%^fg()"
