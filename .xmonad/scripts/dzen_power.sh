#!/bin/bash

source $(dirname $0)/config.sh
XPOS="1890"
WIDTH="30"
LINES=2

p_pwr="^i($HOME/.xmonad/dzen2/shutdown.xbm)"
p_slp="^i($HOME/.xmonad/dzen2/sleep.xbm)"
p_rbt="^i($HOME/.xmonad/dzen2/reboot.xbm)"

if [ $(pgrep dzen_power.sh | wc -w) -le 2 ]; then
    (echo $p_pwr;
    echo $p_slp;
    echo $p_rbt;
    sleep 5)\
        | dzen2 -sa c -fg $foreground -bg $background -h $HEIGHT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -fn 'Open Sans:Regular:size=9' -e 'onstart=uncollapse;button3=exit'
fi