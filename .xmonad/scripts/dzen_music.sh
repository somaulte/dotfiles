#!/bin/bash

source $(dirname $0)/config.sh
XPOS="0"
WIDTH="320"
LINES="6"
LINES2="1"

remote=$(cmus-remote -Q)
artist=$(echo -e "$remote" | grep "tag albumartist " | sed -n -e 's/^.*artist //p')
album=$(echo -e "$remote" | grep "tag album " | sed -n -e 's/^.*album //p')
track=$(echo "$remote" | grep title | sed -n -e 's/^.*title //p')

if [[ $artist == "" ]]; then
    artist=$(echo -e "$remote" | grep "tag artist" | sed -n -e 's/^.*tag artist //p')
fi

if [[ $track == "♠" ]]; then
    track="^i($HOME/.xmonad/dzen2/spade.xbm)"
fi

art="$HOME/Pictures/.albumart/$artist/$album.png"

if [ $(pgrep dzen_music.sh | wc -w) -le 4 ]; then
   (echo "";
      echo "^i(.xmonad/dzen2/music.xbm)";
      echo " $track";
      echo " $artist";
      echo " $album";
      echo "";
      echo "^ca(1, cmus-remote -r) ^i(.xmonad/dzen2/prev.xbm) ^ca()    ^ca(1, cmus-remote -u) ^i(.xmonad/dzen2/pause.xbm) ^ca()    ^ca(1, cmus-remote -u) ^i(.xmonad/dzen2/play.xbm) ^ca()    ^ca(1, cmus-remote -n) ^i(.xmonad/dzen2/next.xbm) ^ca()";
      sleep 5.2)\
      | dzen2 -sa c -ta c -fg $foreground -bg $background -h $HEIGHT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -fn 'Open Sans:Regular:size=9' -e 'onstart=uncollapse;button3=exit' &

   for i in $(seq 1 5); do
      remote2=$(cmus-remote -Q)
      duration=$(echo "$remote2" | grep duration | sed -n -e 's/^.*duration //p')
      position=$(echo "$remote2" | grep position | sed -n -e 's/^.*position //p')
      perc=$((100 * $position / $duration))
      percbar=$(echo -e "$perc" | gdbar -bg $bar_bg -fg $foreground -h 1 -w $WIDTH)

         (echo "";
      echo $percbar;
      sleep 1);
   done\
   | dzen2 -sa l -ta c -fg $foreground -bg $background -h $HEIGHT -x $XPOS -y $(( $YPOS + 140 )) -w $WIDTH -l $LINES2 -fn 'Open Sans:Regular:size=9' -e 'onstart=uncollapse;button3=exit' &
   feh -x -B black -g +$(($WIDTH))+$(($YPOS)) "$art" &
   sleep 5.2;
   killall feh
else
   exit 0
fi
