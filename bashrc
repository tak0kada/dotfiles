# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ "${DISPLAY}" ] || export DISPLAY=:0.0
BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/nvim

#---------------
# FCITX
#---------------
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx

#---------------
# APPEARANCE
#---------------
export TERM=tmux-256color
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
#PS1='[\u@\h \W]\$ '
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh

#---------------
# aliases
#---------------
alias ls='ls --color -h --group-directories-first'
alias vim='nvim'
alias R='R --vanilla --no-save --quiet'
alias r='R --vanilla --no-save --quiet'

#---------------
# HISTORY
#---------------
function share_history {
    history -a
    history -c
    history -r
}
export PROMPT_COMMAND='share_history'
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export HISTSIZE=10000
