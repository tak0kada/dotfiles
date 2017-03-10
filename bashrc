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
# aliases
#---------------
alias ls='ls --color -h --group-directories-first'
alias vim='nvim'
alias vi='nvim'
alias R='R --vanilla --no-save --quiet'
alias r='R --vanilla --no-save --quiet'

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
# HISTORY
#---------------
# share history between several running terminal
function share_history {
    history -a
    history -c
    history -r
}
export PROMPT_COMMAND='share_history'
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export HISTSIZE=10000

#---------------
# TMUX
#---------------
# run tmux on the start up of terminal-emulator
if [ -z "$TMUX" ]; then # if not in tmux
    # if no session exists, start new session
    if [ "`tmux ls | cut -c 1-2`" = "no" ]; then
        tmux new-session && exit
    fi

    detached="`tmux ls | grep -Ev 'attached'`"

    # when some tmux session already existing, but all attached
    if [ -z "$detached" ]; then
        tmux new-session && exit
    fi

    # when some tmux session available, you can choose
    choices="${detached}\nc: create new session"
    ID=`echo -e "$choices" | peco | cut -d ':' -f 1`
    if [[ $ID =~ [0-9]+ ]]; then
        tmux attach -t $ID && exit
    elif [ "$ID" = "c" ]; then
        tmux new-session && exit
    elif [ -z "$ID" ]; then
        exit
    fi
fi
