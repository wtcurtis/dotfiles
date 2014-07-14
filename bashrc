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

alias manifest='php -f /home/wes/src/FAYBUS-SugarTools/PackageCreator/create.php'
alias syntax="find . -name '*.php' | xargs -l1 php -l"

function bbclone {
    git clone git@bitbucket.org:wescurtis/$1 $2
}

alias tmux="TERM=screen-256color tmux"

alias fbsgup="sudo service ipsec start && sudo ipsec auto --add what && sudo ipsec whack --name what --listen --initiate"
alias fbsgdown="sudo service ipsec stop"
alias te="tail -f /var/log/nginx/error.log";
alias teh="tail -f /var/log/hhvm/error.log";
alias veh="vim /var/log/hhvm/error.log";
alias tep="tail -f /var/log/php/php_errors.log";
alias vep="vim /var/log/php/php_errors.log";

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

PATH_TO_SUGAR_BUILD="/home/wes/src/SugarBuild/build.php"
PATH_TO_REVERSE="/home/wes/src/FAYBUS-SugarTools/ReverseInstall/reverse.php"

alias sugar_build="php $PATH_TO_SUGAR_BUILD --basedir=./ --specpath=./build_spec.php --verbose=1"
alias reverse="php $PATH_TO_REVERSE"

alias cb='xclip -selection c -i'

stty werase undef
bind 'C-w:unix-filename-rubout'

PROMPT_COMMAND='history -a'

alias gs="git status"
alias gl="git log"
alias gp="git add -p"
alias gc="git commit"
alias gd="git diff"
alias gco="git checkout"
alias gau="git update-index --assume-unchanged"
alias gac="git update-index --no-assume-unchanged"

alias lookup="php ~/src/fbsg-sugarclient-credential-lookup-utility/bin/console lookup"
alias makeUser="php ~/src/fbsg-sugarclient-credential-lookup-utility/bin/console fbsg:create"

function title {
    echo -ne "\033]0;$1\007"
}

function deployCc {
    scp $1 saasportal:/var/www/sites/faybus-jiraclientportal/public/integrations/FBSG-SugarCRM-ConstantContact-Integration.zip
}

alias sa="cd /etc/nginx/sites-available && sudo vim && cd -"

alias use_fpm="sudo service hhvm stop && sudo service php5-fpm start"
alias use_hhvm="sudo service php5-fpm stop && sudo service hhvm start"

alias clearcache="cd /var/www/html/hawk/eagle/scripts && ./clearcache.sh hawk && cd -"

function tailmag {
    tail -f /var/www/html/hawk/magento/var/log/$1.log
}

set -o vi

