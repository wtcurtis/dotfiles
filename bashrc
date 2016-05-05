# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
PHPRC=/usr/local/etc/php/7.0/php-cli.ini

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
export PATH="$PATH:/Users/wescurtis/bin:./vendor/bin:./node_modules/.bin:/Users/wescurtis/.composer/vendor/bin"
export myHome="/Users/wescurtis"

WEBROOT="/usr/local/var/www/htdocs";
CMSROOT="$WEBROOT/cms/trunk/html";

HAWKDIR="/var/www/html/hawk"
EAGLEDIR="$HAWKDIR/eagle"
WP_CONTENT_DIR="wp-content"
SELENIUM_DIR="$EAGLEDIR/selenium"
SELENIUM_SERVER="$myHome/Downloads/selenium/selenium-server-standalone-2.45.0.jar"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function getBracketBranch {
    parse_git_branch | sed 's/\(.*\)/\[\1\]/'
}

PS1="\[\e[1;32m\]\u@\h\[\e[1;37m\]:\[\e[1;34m\]\w\[\e[1;31m\] \$(getBracketBranch) \[\e[1;37m\]$ \[\e[0m\]"

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

#alias ls='ls --color=auto'
alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias l='ls -alF'
#alias la='ls -A'
#alias lls='ll --sort=time -r'
#alias l='ls -CF'

alias ..="cd ../"

alias tmux="TERM=screen-256color tmux"

alias te="tail -f /usr/local/var/log/nginx/error.log";
alias ve="vim /usr/local/var/log/nginx/error.log";
alias teh="tail -f /var/log/hhvm/error.log -n 40";
alias veh="vim /var/log/hhvm/error.log";
alias tep="tail -f /usr/local/var/log/php70-error.log";
alias vep="vim /var/log/php/php_errors.log";
alias teg="tail -f $HAWKDIR/eagle/log.txt -n 40";
alias veg="vim $HAWKDIR/eagle/log.txt";

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
alias cbm='pbcopy';

stty werase undef
bind 'C-w:unix-filename-rubout'

PROMPT_COMMAND='history -a'

alias gs="git status"
alias gsh="git show"
alias gshs="git show --stat"
alias gl="git log"
alias gln="git log --no-merges"
alias ga="git add"
alias gap="git add -p"
alias gc="git commit"
alias gca="git commit --amend"
alias gd="git diff"
alias gds="git diff --stat"
alias gco="git checkout"
alias gcod="git checkout dev"
alias gpo="git push origin"
alias gpl="git push local"
alias gpob="git push origin \`parse_git_branch\`"
alias gpu="git pull origin"
alias gpr="git pull --rebase origin"
alias gprb="git pull --rebase origin \`parse_git_branch\`"
alias gprd="git pull --rebase origin dev"
alias gprbf="git pull --rebase origin \`parse_git_branch\` && git fetch --tags"
alias gprdf="git pull --rebase origin \`parse_git_branch\` && git fetch --tags"
alias gf="git fetch"
alias gt="git tag -a"
alias gtd="git tag -d"
alias gtdr="git push origin :"
alias gst="git stash"
alias gsts="git stash show"
alias gstsp="git stash show --patch"
alias gstp="git stash pop"
alias gsl="git stash list"
alias gft="git fetch --tags"
alias gfa="git fetch --all"
alias gshf="git show --stat --name-only --pretty=\"format:\""

alias gau="git update-index --assume-unchanged"
alias gac="git update-index --no-assume-unchanged"

alias gnr="git svn rebase"
alias gnd="git svn dcommit"
alias gndr="git svn dcommit --dry-run"
alias gcp="git cherry-pick"

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

NGINXBASE="/usr/local/etc/nginx"
alias sa="cd $NGINXBASE/sites-available && sudo vim && cd -"
alias se="cd $NGINXBASE/sites-enabled && sudo vim && cd -"

function ngensite() {
    toSymlink=$NGINXBASE/sites-enabled/$1.conf

    if [ -e $NGINXBASE/sites-available/$1.conf ]; then
        ln -s $NGINXBASE/sites-available/$1.conf $toSymlink
    else
        echo "$toSymlink already exists."
    fi
}

function ngdissite() {
    toDelete=$NGINXBASE/sites-enabled/$1.conf

    if [ -e $NGINXBASE/sites-available/$1.conf ]; then
        rm $toDelete
    else
        echo "No such sites: $toDelete"
    fi
}

alias nglist="ls -la $NGINXBASE/sites-enabled"
alias nglista="ls -la $NGINXBASE/sites-available"
alias ngrestart="sudo brew services restart nginx"
alias ngreload="sudo brew services reload nginx"
alias ngstop="sudo brew services stop nginx"
alias astart="sudo apachectl start"
alias astop="sudo apachectl stop"
alias use_fpm="sudo service hhvm stop && sudo service php5-fpm start"
alias use_hhvm="sudo service php5-fpm stop && sudo service hhvm start"

# clear magento cache
alias clearcache="cd $HAWKDIR/eagle/scripts && ./clearcache.sh hawk && cd -"

function tailmag {
    tail -f $HAWKDIR/magento/var/log/$1.log -n 40
}

function vmag {
    vim $HAWKDIR/magento/var/log/$1.log
}

alias fc="find . -name '*.cs' | xargs grep 2>/dev/null --color"
alias fci="find . -name '*.cs' | xargs grep 2>/dev/null --color -i"
alias fp="find . -name '*.php' | xargs grep 2>/dev/null --color"
alias fpi="find . -name '*.php' | xargs grep 2>/dev/null --color -i"
alias fj="find . -name '*.js' | xargs grep 2>/dev/null --color"
alias fji="find . -name '*js' | xargs grep 2>/dev/null --color -i"
alias fx="find . -name '*.xml' | xargs grep 2>/dev/null --color"
alias fxi="find . -name '*.xml' | xargs grep 2>/dev/null --color -i"
alias fph="find . -name '*.phtml' | xargs grep 2>/dev/null --color"
alias fphi="find . -name '*.phtml' | xargs grep 2>/dev/null --color -i"
alias fa="find . -type f | xargs grep 2>/dev/null --color"
alias fai="find . -type f | xargs grep 2>/dev/null --color -i"
alias fm="find . -name xennsoft.manifest | xargs grep 2>/dev/null --color"
alias fmi="find . -name xennsoft.manifest | xargs grep 2>/dev/null --color -i"
alias fn="find . -name"
alias ff="find . -type f"
function fz {
    find . -iname "*$1*"
}

function fzf {
    find . -type f -iname "*$1*"
}


alias xg="xargs grep"
alias xgi="xargs grep -i"

alias tailb="tail -f $HAWKDIR/eagle/var/log/billing.log -n 40"
alias vimb="vim $HAWKDIR/eagle/var/log/billing.log"
alias taile="tail -f $HAWKDIR/eagle/log.txt -n 40"
alias vime="vim $HAWKDIR/eagle/log.txt"

#up 5 => go up 5 directories
function up {
    for i in $(seq 1 $1); do cd ..; done
}

function tagn {
    git tag -a `tn $1` -m \'${*:2}\'
    ts $1
}

alias web="cd $WEBROOT"
alias cms="cd $CMSROOT"
alias apa="cd /etc/apache2"
alias acnf="sudo vim /etc/apache2/httpd.conf"
alias rapa="sudo apachectl restart"
alias php7="brew services stop php53 && brew services start php70"
alias php53="brew services stop php70 && brew services start php53"

alias php7conf="cd /usr/local/etc/php/7.0 && sudo vim && cd -"
alias php53conf="cd /usr/local/etc/php/5.3 && sudo vim && cd -"

alias brews="brew services"

#completely annihilate phpstorm
alias kill_storm="ps aux | grep phpstorm | grep -v grep | tr -s ' ' | cut -d ' ' -f 2 | xargs kill -9"
alias phpstorm="~/phpstorm/current.sh"

alias hawk="pushd $HAWKDIR &>/dev/null"

alias eb="pushd $HAWKDIR/eagle/classes/Billing &>/dev/null"
alias ebt="php $EAGLEDIR/classes/Billing/test.php"
alias ebin="pushd $HAWKDIR/eagle/bin &>/dev/null"
alias e="pushd $HAWKDIR/eagle &>/dev/null"
alias wp="pushd $HAWKDIR/wordpress &>/dev/null"
alias wpp="pushd $HAWKDIR/wordpress/$WP_CONTENT_DIR/plugins &>/dev/null"
alias wpe="pushd $HAWKDIR/wordpress/$WP_CONTENT_DIR/plugins/xennsoft-eagle &>/dev/null"

DTDIR="$HAWKDIR/dev/DevTools"
DEVTOOLS="$DTDIR/src/app"

D_MAG="$HAWKDIR/magento"
D_MAGC="$D_MAG/app/code/local"
D_MAGX="$D_MAGC/Xennsoft"
D_MAGD="$D_MAG/app/design"
D_MAGFT="$D_MAGD/frontend/base/default/template"
D_MAGAT="$D_MAGD/adminhtml/default/default/template"
D_MAGAL="$D_MAGD/adminhtml/default/default/layout"
D_MAGFL="$D_MAGD/frontend/base/default/layout"

alias mag="pushd $D_MAG &>/dev/null"
alias magc="pushd $D_MAGC &>/dev/null"
alias magx="pushd $D_MAGX &>/dev/null"
alias magd="pushd $D_MAGD &>/dev/null"
alias magft="pushd $D_MAGFT &>/dev/null"
alias magat="pushd $D_MAGAT &>/dev/null"
alias magfl="pushd $D_MAGFL &>/dev/null"
alias magal="pushd $D_MAGAL &>/dev/null"
alias bonus="pushd $HAWKDIR/bonus/BonusV2 &>/dev/null"

alias fuck="ibus restart"
alias gtg="git tag --list | grep -i"
alias lx="vim $HAWKDIR/magento/app/etc/local.xml"

alias tf="sed 's/[-]/ /g' | awk '{print $NF,$0}' | sort -n"

alias alllog="multitail /var/log/hhvm/error.log /var/log/php/php_errors.log $HAWKDIR/eagle/log.txt"
alias ports="sudo netstat -plnt"
alias cd="pushd > /dev/null"
alias cleard="dirs -c"

alias ts="php $DEVTOOLS tagger:tag"
alias tn="php $DEVTOOLS tagger:tag -t next"
alias tp="php $DEVTOOLS tagger:tag -t specific -s --"
alias bs="php $DEVTOOLS tagger:branch"

alias uniq_f="awk '{print $1}' | cut -f 1 -d ':' | uniq"


function annotate {
    cd $HAWKDIR/magento && php ../dev/n98-magerun.phar dev:code:model:method $1 && cd -
}

function cmc {
    cd $HAWKDIR/magento && php ../dev/n98-magerun.phar dev:code:model:method $1 && cd -
}

alias pq="php $HAWKDIR/eagle/bin/Billing_Cron ProcessQueue"
alias v="sudo virt-manager"
alias repl="php $HAWKDIR/dev/Search-Replace-DB-master/srdb.xennsoft.cli.php -h localhost -n xennsoft -u root -p '' -s 'xennsoft.com' -r 'wes.xen'"

function gta {
    git tag -a $2 -m "$1"
}

HHVMD="hhvm -d xdebug.enable=1"

alias vimhuge="vim -u \"NONE\""

[ -s "/home/wcurtis/.dnx/dnvm/dnvm.sh" ] && . "/home/wcurtis/.dnx/dnvm/dnvm.sh" # Load dnvm

alias branchDate="for k in \`git branch|perl -pe s/^..//\`;do echo -e \`git show --pretty=format:'%Cgreen%ci %Cblue%cr%Creset' $k|head -n 1\`\\t$k;done|sort -r"

MAPIDIR="/Users/wescurtis/src/mapi-server"
PHPUNIT="$MAPIDIR/vendor/bin/phpunit"
MAPI_UNIT="$MAPIDIR/phpunit.xml"
PHPX="php -c /usr/local/etc/php/7.0/php-cli-xdebug.ini"

alias mapi="cd $MAPIDIR"
alias tmapi="tail -f $MAPIDIR/storage/logs/lumen.log"
alias vmapi="vim $MAPIDIR/storage/logs/lumen.log"
alias munit="$PHPUNIT --config=$MAPI_UNIT"
alias munitx="$PHPX $PHPUNIT --config=$MAPI_UNIT"
alias frontier="cd /Users/wescurtis/src/cms-v2/trunk/sites/partners.frontier"
alias src="cd ~/src"
alias phpx="$PHPX"

alias dockersql="mysql -u root -psecret -h \$(docker-machine ip) -P 32771"
alias svr="find $myHome/dev-local-bash -type f | xargs grep --color -i"

function svnClone {
    git svn clone $1 -T trunk -b branches -t tags
}

function svnBranches {
    git branch trunk refs/remotes/origin/trunk
    git branch staging refs/remotes/origin/staging
    git branch production refs/remotes/origin/production
}

