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

PS1="\[\e[1;32m\]\u\[\e[1;32m\]@\[\e[1;32m\]\h\[\e[1;37m\]:\[\e[1;34m\]\w\[\e[1;31m\]\$(parse_git_branch) \[\e[1;37m\]$ \[\e[0m\]"

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
#alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..="cd ../"

alias tmux="TERM=screen-256color tmux"

alias te="tail -f /var/log/nginx/error.log";
alias teh="tail -f /var/log/hhvm/error.log";
alias veh="vim /var/log/hhvm/error.log";
alias tep="tail -f /var/log/php/php_errors.log";
alias vep="vim /var/log/php/php_errors.log";
alias teg="tail -f /var/www/html/hawk/eagle/log.txt";
alias veg="vim /var/www/html/hawk/eagle/log.txt";

#nuclear options for permissions
function perm {
    sudo chmod -R 775 `pwd`
    sudo chgrp -R `id -u -n` `pwd`
    sudo chown -R $1 `pwd`
}

function ifind {
    find $1 -iname $2
}

function pfind {
    find $1 -iname '*.php'
}

#put file on local clipboard
alias cb='xclip -selection c -i'

stty werase undef
bind 'C-w:unix-filename-rubout'

PROMPT_COMMAND='history -a'

alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gp="git add -p"
alias gc="git commit"
alias gd="git diff"
alias gco="git checkout"
alias gpo="git push origin"
alias gpu="git pull origin"
alias gf="git fetch"
alias gt="git tag -a"
alias gtd="git tag -d"
alias gtdr="git push origin :"
alias gst="git stash"
alias gstp="git stash pop"
alias gft="git fetch --tags"

alias gau="git update-index --assume-unchanged"
alias gac="git update-index --no-assume-unchanged"

# Tab completion for git aliases
function make-completion-wrapper () {
    local function_name="$2"
    local arg_count=$(($#-3))
    local comp_function_name="$1"
    shift 2
    local function="
        function $function_name {
            ((COMP_CWORD+=$arg_count))
            COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
            "$comp_function_name"
            return 0
        }"
    eval "$function"
    echo $function_name
    echo "$function"
}

# Set terminal title
function title {
    echo -ne "\033]0;$1\007"
}


alias sa="cd /etc/nginx/sites-available && sudo vim && cd -"

alias use_fpm="sudo service hhvm stop && sudo service php5-fpm start"
alias use_hhvm="sudo service php5-fpm stop && sudo service hhvm start"

# clear magento cache
alias clearcache="cd /var/www/html/hawk/eagle/scripts && ./clearcache.sh hawk && cd -"

function tailmag {
    tail -f /var/www/html/hawk/magento/var/log/$1.log
}

function vmag {
    vim /var/www/html/hawk/magento/var/log/$1.log
}

alias fp="find . -name '*.php' | xargs grep --color"
alias fpi="find . -name '*.php' | xargs grep --color -i"

alias taile="tail -f /var/www/html/hawk/eagle/log.txt"
alias vime="vim /var/www/html/hawk/eagle/log.txt"

#up 5 => go up 5 directories
function up {
    for i in $(seq 1 $1); do cd ..; done
}

#use vi mode on command line
set -o vi

#completely annihilate phpstorm
alias kill_storm="ps aux | grep phpstorm | grep -v grep | tr -s ' ' | cut -d ' ' -f 2 | xargs kill -9"

alias eb="cd /var/www/html/hawk/eagle/classes/Billing"
alias wp="cd /var/www/html/hawk/wordpress"
alias wpp="cd /var/www/html/hawk/wordpress/wp-content/plugins"
alias wpe="cd /var/www/html/hawk/wordpress/wp-content/plugins/xennsoft-eagle"
alias mag="cd /var/www/html/hawk/magento"
alias magc="cd /var/www/html/hawk/magento/app/code/local"
alias magx="cd /var/www/html/hawk/magento/app/code/local/Xennsoft"
alias hawk="cd /var/www/html/hawk"
alias fuck="sudo ibus restart"
alias gtg="git tag --list | grep -i"

alias alllog="multitail /var/log/hhvm/error.log /var/log/php/php_errors.log /var/www/html/hawk/eagle/log.txt"
