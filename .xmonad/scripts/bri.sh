#!/usr/bin/env bash

lite=$(xbacklight -get)
lite=${lite/.*}

if [[ lite -le 10 ]] && [[ $1 == dec ]]; then
    xbacklight -set 1
elif [[ $1 -eq inc ]]; then
   xbacklight -$1 10%
else
   xbacklight -$1 10%
fi