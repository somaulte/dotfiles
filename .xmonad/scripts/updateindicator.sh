#!/bin/bash

source $(dirname $0)/config.sh

upd=$(cat $HOME/.xmonad/data/upd.txt | wc -l)
orp=$(cat $HOME/.xmonad/data/orp.txt | wc -l)
list=$(( $upd + $orp ))
ICON='^i(/home/somaulte/.xmonad/dzen2/archupdate.xbm)'

if [[ $list -ne 0 ]]; then
   if [[ $upd -ne 0 ]] && [[ $orp -ne 0 ]]; then
      echo "$ICON ^fg(#00cc00)+$upd^fg() ^fg(#cc0000)-$orp^fg()"
   elif [[ $upd -eq 0 ]] && [[ $orp -ne 0 ]]; then
      echo "$ICON ^fg(#cc0000)-$orp^fg()"
   elif [[ $upd -ne 0 ]] && [[ $orp -eq 0 ]]; then
      echo "$ICON ^fg(#00cc00)+$upd^fg()"
   fi
fi