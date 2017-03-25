#!/bin/bash

source $(dirname $0)/config.sh

pac=$(/usr/bin/checkupdates | wc -l)
aur=$(/usr/bin/pacaur -Qqu -a | wc -l)
upd=$(($pac+$aur))

ignorelist=$(cat $HOME/.ignorepkg.txt)
listpac=$(/usr/bin/checkupdates | awk '{print $1;}')
listaur=$(/usr/bin/pacaur -Qqu -a)

for word in $ignorelist; do
      echo "/$word/d;"
done > $HOME/.xmonad/data/ignorepkg.txt

for word in $listpac; do
      echo "^fg(#00cc00)+ $word"
done > $HOME/.xmonad/data/pac.txt

for word in $listaur; do
      echo "^fg(#00cc00)+ $word"
done > $HOME/.xmonad/data/aur.txt

ignore=$(cat $HOME/.xmonad/data/ignorepkg.txt)

sed -i "$ignore" $HOME/.xmonad/data/aur.txt

sort -u .xmonad/data/pac.txt .xmonad/data/aur.txt > .xmonad/data/upd.txt

listorp=$(pacaur -Qtdq)

for word in $listorp; do
      echo "^fg(#cc0000)- $word"
done > $HOME/.xmonad/data/orp.txt
