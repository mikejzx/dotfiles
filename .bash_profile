#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start X if we are in TTY1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx -- vt1; fi
