#!/bin/bash

source $(dirname $0)/config.sh

remote=$(cmus-remote -Q)
Instance=$(echo -e "$remote" | wc -l)
stat=$(cmus-remote -Q | head -n 1 | awk 'NF>1{print $NF}')
if [ $stat == "paused" ]; then
    ICON="pause.xbm"
elif [ $stat == "playing" ]; then
    ICON="music.xbm"
fi

title=$(echo "$remote" | grep title | sed -n -e 's/^.*title //p')
artist=$(echo -e "$remote" | grep "tag albumartist " | sed -n -e 's/^.*artist //p')
vol=$(echo -e "$remote" | tail -n 1 | sed -n -e 's/^.*right //p')

if [[ -z $artist ]]; then
    artist=$(echo -e "$remote" | grep "tag artist" | sed -n -e 's/^.*tag artist //p')
fi

if [[ $title == "♠" ]]; then
    title="^i($HOME/.xmonad/dzen2/spade.xbm)"
fi

if [[ -z $artist ]]; then
    echo ""
else
    ICON='^i(/home/somaulte/.xmonad/dzen2/'"$ICON)"
    echo "$ICON  $artist - $title"
fi
