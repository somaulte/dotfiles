#!/usr/bin/env bash

source $(dirname $0)/config.sh

ICON='^i(.xmonad/dzen2/cpu.xbm)'
cpuA=$(top -bn 2 | grep Cpu | tail -n 4)

cpu0=$(echo $cpuA | grep Cpu0)
cpu0=${cpu0%%\[*}
cpu0=${cpu0##*[[:space:]]}

cpu1=$(echo $cpuA | grep Cpu1)
cpu1=${cpu1%%\[*}
cpu1=${cpu1##*[[:space:]]}

cpu2=$(echo $cpuA | grep Cpu2)
cpu2=${cpu2%%\[*}
cpu2=${cpu2##*[[:space:]]}

cpu3=$(echo $cpuA | grep Cpu3)
cpu3=${cpu3%%\[*}
cpu3=${cpu3##*[[:space:]]}

if [ $cpu0 -lt 13 ]; then
    cor0="▁"
elif [ $cpu0 -lt 26 ]; then
    cor0="▂"
elif [ $cpu0 -lt 39 ]; then
    cor0="▃"
elif [ $cpu0 -lt 52 ]; then
    cor0="▄"
elif [ $cpu0 -lt 65 ]; then
    cor0="▅"
elif [ $cpu0 -lt 78 ]; then
    cor0="▆"
elif [ $cpu0 -lt 91 ]; then
    cor0="▇"
else
    cor0="█"
fi

if [ $cpu1 -lt 13 ]; then
    cor1="▁"
elif [ $cpu1 -lt 26 ]; then
    cor1="▂"
elif [ $cpu1 -lt 39 ]; then
    cor1="▃"
elif [ $cpu1 -lt 52 ]; then
    cor1="▄"
elif [ $cpu1 -lt 65 ]; then
    cor1="▅"
elif [ $cpu1 -lt 78 ]; then
    cor1="▆"
elif [ $cpu1 -lt 91 ]; then
    cor1="▇"
else
    cor1="█"
fi

if [ $cpu2 -lt 13 ]; then
    cor2="▁"
elif [ $cpu2 -lt 26 ]; then
    cor2="▂"
elif [ $cpu2 -lt 39 ]; then
    cor2="▃"
elif [ $cpu2 -lt 52 ]; then
    cor2="▄"
elif [ $cpu2 -lt 65 ]; then
    cor2="▅"
elif [ $cpu2 -lt 78 ]; then
    cor2="▆"
elif [ $cpu2 -lt 91 ]; then
    cor2="▇"
else
    cor2="█"
fi

if [ $cpu3 -lt 13 ]; then
    cor3="▁"
elif [ $cpu3 -lt 26 ]; then
    cor3="▂"
elif [ $cpu3 -lt 39 ]; then
    cor3="▃"
elif [ $cpu3 -lt 52 ]; then
    cor3="▄"
elif [ $cpu3 -lt 65 ]; then
    cor3="▅"
elif [ $cpu3 -lt 78 ]; then
    cor3="▆"
elif [ $cpu3 -lt 91 ]; then
    cor3="▇"
else
    cor3="█"
fi

echo "$ICON $cpu0$cpu1$cpu2$cpu3"