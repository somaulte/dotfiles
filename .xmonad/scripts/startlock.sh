#!/bin/bash

i3lock -n -i /home/somaulte/.xmonad/scripts/icons/startlock.png &

if pgrep -x "xss-lock" > /dev/null; then
  pkill xss-lock
  exec xss-lock /home/somaulte/.xmonad/scripts/lock
else
  exec xss-lock /home/somaulte/.xmonad/scripts/lock
fi
