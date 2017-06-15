#!/bin/bash

source $(dirname $0)/config.sh
XPOS="1600"
WIDTH="100"

b_rem=$(acpi -b)
b_rem=${b_rem##*,[[:space:]]}
b_rem=${b_rem:0:5}

b_crg_c=$(< /sys/class/power_supply/BAT*/charge_now)
b_crg_f=$(< /sys/class/power_supply/BAT*/charge_full)
b_crg=$(( $(( $b_crg_c * 100 )) / $b_crg_f ))

b_stt=$(< /sys/class/power_supply/BAT*/status)

if [ $(pgrep dzen_battery.sh | wc -w) -le 2 ]; then
    if [ $b_stt == "Full" ] && [ $b_crg -eq 100 ]; then
        LINES=0
        (echo $b_stt;
        sleep 5)\
            | dzen2 -sa c -fg $foreground -bg $background -h $HEIGHT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -fn 'Open Sans:Regular:size=9' -e 'onstart=uncollapse;button3=exit'
    else
        LINES=1
        (echo $b_stt;
        echo $b_rem "remaining";
        sleep 5)\
            | dzen2 -sa c -fg $foreground -bg $background -h $HEIGHT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -fn 'Open Sans:Regular:size=9' -e 'onstart=uncollapse;button3=exit'
    fi
fi