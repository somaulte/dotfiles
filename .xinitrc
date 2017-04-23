[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[ -f ~/.xprofile ] && . ~/.xprofile
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
export _JAVA_AWT_WM_NONREPARENTING=1
exec ~/.xmonad/scripts/startlock.sh &
xsetroot -cursor_name left_ptr &
compton -b -o 0 &
feh --randomize --bg-center /home/somaulte/Pictures/.wp/* &
xmonad
