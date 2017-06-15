#!/usr/bin/env bash

source $(dirname $0)/config.sh

while :; do
sleep 60
ESSID=$(iwgetid)
ESSID=${ESSID#*\"}
ESSID=${ESSID%%\"}

if [[ $ESSID == "BHNTG1672GEA42-5G" ]] || [[ $ESSID == "BHNTG1672GEA42" ]]; then
    xset -dpms
elif [[ $ESSID != "BHNTG1672GEA42-5G" ]]; then
    xset +dpms
fi
sleep 240
done