[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[ -f ~/.xprofile ] && . ~/.xprofile
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
export _JAVA_AWT_WM_NONREPARENTING=1
xsetroot -cursor_name left_ptr &
sudo modprobe nct6775 force_id=0xd120 &
feh --bg-tile Pictures/.wp/black.png
compton --glx-no-stencil --backend xr_glx_hybrid -o 0 --use-ewmh-active-win --paint-on-overlay &
xmonad
