#!/bin/bash

source $(dirname $0)/config.sh

XPOS="1280"
WIDTH="180"
LINES=$(( $(cat $HOME/.xmonad/data/upd.txt | wc -l) + $(cat $HOME/.xmonad/data/orp.txt | wc -l) + 5 ))

if [ $(pgrep dzen_updateindi | wc -w) -le 2 ]; then
(echo "";
      echo "^i($HOME/.xmonad/dzen2/package.xbm)";
      echo "---------------";
      cat .xmonad/data/upd.txt;
      cat .xmonad/data/orp.txt;
      echo "---------------";
      echo "^fg($highlight) ^ca(1,$HOME/.xmonad/scripts/update)Update^ca()";
      sleep 5)\
      | dzen2 -sa c -fg $foreground -bg $background -h $HEIGHT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -fn 'Open Sans:Regular:size=9' -e 'onstart=uncollapse;button3=exit'
fi
