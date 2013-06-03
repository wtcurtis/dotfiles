# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}

PS1="\[\e[0;32m\]\u\[\e[0;32m\]@\[\e[0;32m\]\h\[\e[0;37m\]:\[\e[0;34m\]\w\[\e[0;31m\]\$(parse_git_branch) \[\e[0;37m\]$ \[\e[0m\]"

# enable color support of ls and also add handy aliases

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#SugarNav
function snav {
    if [ $# -eq 2 ]
    then
        cd `python $PATH_TO_SUGAR_NAV -t $1 -m $2`
    else
        cd `python $PATH_TO_SUGAR_NAV -t $1`
    fi
}
PATH_TO_SUGAR_NAV='/home/wes/src/sugarnav/nav.py'
alias nce='snav ce'
alias nc='snav c'
alias nm='snav m'
alias ncev='snav cev'
alias ncel='snav cel'
alias nceld='snav celd'

alias ..="cd ../"

alias perm='sudo chmod -R 775 `pwd`;sudo chgrp -R www-data `pwd`;sudo chown -R www-data `pwd`'
alias manifest='php -f /home/wes/src/FAYBUS-SugarTools/PackageCreator/create.php'

function bbclone {
    git clone https://wescurtis@bitbucket.org/wescurtis/$1
}
