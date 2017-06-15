#!/bin/sh

case $1 in
start)
    xwinwrap -ni -nf -s -b -ov -g 2560x1080 -- $0 arg WID
 ;;
 arg)
     mpv ~/Videos/.wp/wallpaper.mp4 --wid=$2 --loop=inf
 ;;
 esac