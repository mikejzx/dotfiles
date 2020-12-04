#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Basic aliases.
alias ls='ls --color=auto'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias e='nvim'
alias vim='nvim'
alias vi='nvim'
alias vrc="nvim ~/.vimrc"
alias yt-dl='youtube-dl -f bestvideo+bestaudio/best'
alias mutt='neomutt'
alias shredder='shred -uzn 9'
alias diff='colordiff'
alias diffdir='colordiff -qrN'
alias tmux="tmux -2"
alias cls="clear"
alias ka='killall'
alias kar='killall redshift'
alias cp='cp -i'          # Prompt before overwriting
alias mv='mv -i'          # Prompt before overwriting
alias df='df -h'          # Human-readable sizes
alias du='du -ch'         # Human-readable sizes, and total
alias free='free -m'      # Sizes in MiB
alias lynx='lynx -vikeys' # Vi-mode in Lynx
alias ..='cd ..'
alias ...='cd ../..'
alias :q="exit"
alias :qa="exit"
alias pacman-cleanup='sudo pacman -Rns $(pacman -Qtdq)'

export EDITOR=nvim

# Dotfiles config
alias dfls='/usr/bin/git --git-dir=$HOME/src/dotfiles/ --work-tree=$HOME'

# Vi-mode in bash
set -o vi

# Prompt colours.
#PS1='[\u@\h \W]\$ '
PS1='\[\033[00;36m\]\w\[\033[00m\] '

# Home directory clean up
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtkrc-2.0"
export LESSHISTFILE="-"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
alias  mbsync="mbsync --config=$XDG_CONFIG_HOME/mbsyncrc"
alias  gpg="gpg --homedir $XDG_DATA_HOME/gnupg"
alias  mpdfavd="mpdfavd -config-file $XDG_CONFIG_HOME/mpdfav.json"
alias  ncmpcpp="ncmpcpp ncmpcpp_directory=$XDG_CONFIG_HOME/ncmpcpp/data/ lyrics_directory=$XDG_CONFIG_HOME/ncmpcpp/lyrics"

# Allows colours in e.g man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# MPD stuff
export MPD_HOST="127.0.0.1"
export MPD_PORT="6600"

# Show cow with fortune on login.
~/src/scripts/misc/cow-greet.sh

# Bash history - set length, and set to not overwrite.
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth

# Check window size after each command and
# update LINES and COLUMNS if necessary.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
