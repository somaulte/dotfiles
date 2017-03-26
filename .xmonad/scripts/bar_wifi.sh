#!/usr/bin/env bash

source $(dirname $0)/config.sh

QUAL=$(iwconfig wlp1s0 | grep 'Link Quality=')
QUAL=${QUAL/*y=}
QUAL=${QUAL/\/*}

MAX=$(iwconfig wlp1s0 | grep 'Link Quality=')
MAX=${MAX/*\/}
MAX=${MAX//[[:space:]]*}

PERC=$(( $(( $QUAL * 100)) / $MAX ))

if [[ $PERC -lt 20 ]]; then
	ICON="wireless1.xbm"
	color="^fg($warning)"
elif [[ $PERC -lt 40 ]]; then
	ICON="wireless2.xbm"
	color="^fg($notify)"
elif [[ $PERC -lt 60 ]]; then
	ICON="wireless3.xbm"
elif [[ $PERC -lt 80 ]]; then
	ICON="wireless4.xbm"
elif [[ $PERC -le 100 ]]; then
	ICON="wireless5.xbm"
fi

ICON='^i(.xmonad/dzen2/'"$ICON)"
echo "$color$ICON^fg()"