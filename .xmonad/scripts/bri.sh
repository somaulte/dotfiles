#!/bin/bash

lite=$(xbacklight -get | awk '{ print int($1 + 0.5) }')

if [[ lite -le 10 ]] && [[ $1 == dec ]]; then
    xbacklight -set 1
elif [[ $1 -eq inc ]]; then
   xbacklight -$1 10%
else
   xbacklight -$1 10%
fi
