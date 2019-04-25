# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
PHPBASE=/usr/local/etc/php/7.2
PHPRC=$PHPBASE/php-cli.ini
MAPIWP=/Users/wescurtis/src/mapi-server/public/wp-updates
etc=/usr/local/etc

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=1000000
export GOPATH="$HOME/src/go"
export GO111MODULE=on

export PATH="/usr/local/opt/php@7.2/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH:/Users/wescurtis/bin:/Users/wescurtis/.composer/vendor/bin:./vendor/bin:./node_modules/.bin:$GOPATH/bin"
export myHome="/Users/wescurtis"
export ORIENTDB_HOME="/usr/local/opt/orientdb-2.2.26/bin"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function getBracketBranch {
    parse_git_branch | sed 's/\(.*\)/\[\1\]/'
}

#PS1="\[\033[38;5;12m\][\d \t]\[$(tput sgr0)\] \[\e[1;32m\]\u \[\033[38;5;9m\](\$(aws_prof))\e[1;37m\]:\[\e[1;34m\]\w\[\e[1;31m\] \$(getBracketBranch) \[\e[1;37m\]$ \[\e[0m\]"
#PS1="\[\033[38;5;12m\][\d \t]\[$(tput sgr0)\] \[\e[1;32m\]\u \[\e[1;37m\]\]: \[\e[1;34m\]\w\[\e[1;31m\] \$(getBracketBranch) \[\e[1;37m\]$ \[\e[0m\]"
#PS1="\[\e[1;34m\][\d \t] \[\e[1;32m\]\u@\h\[\e[1;37m\]:\[\e[1;34m\]\w\[\e[1;31m\] \$(getBracketBranch) \[\e[1;37m\]$ \[\e[0m\]"
PS1="[\d \t] \[\e[1;32m\]\u@\h\[\e[1;37m\]:\[\e[1;34m\]\w\[\e[1;31m\] \$(getBracketBranch) \[\e[1;37m\]$ \[\e[0m\]"

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

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alFh'
alias l='ls -alF'

alias ..="cd ../"

alias tmux="TERM=screen-256color tmux"

alias ten="tail -f /usr/local/var/log/nginx/error.log";
alias ven="vim /usr/local/var/log/nginx/error.log";
alias tep="tail -f /usr/local/var/log/php70-error.log";
alias vep="vim /usr/local/var/log/php70-error.log";

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

alias gb="parse_git_branch"
alias gs="git status"
alias gsh="git show"
alias gshs="git show --stat"
alias gl="git log"
alias gln="git log --no-merges"
alias ga="git add"
alias gap="git add -p"
alias gc="git commit -v"
alias gca="git commit --amend"
alias gd="git diff"
alias gdt="git diff --staged"
alias gds="git diff --stat"
alias gdst="git diff --stat --staged"
alias gco="git checkout"
alias gcod="git checkout dev"
alias gcom="git checkout master"
alias gcop="git checkout production"
alias gpo="git push origin"
alias gpl="git push local"
alias gpob="git push origin \`parse_git_branch\`"
alias gpu="git pull origin"
alias gpr="git pull --rebase"
alias gprb="git pull --rebase origin \`parse_git_branch\`"
alias gprd="git pull --rebase origin dev"
alias gprm="git pull --rebase origin master"
alias gprbf="git pull --rebase origin \`parse_git_branch\` && git fetch --tags"
alias gprdf="git pull --rebase origin \`parse_git_branch\` && git fetch --tags"
alias gf="git fetch"
alias gt="git tag -a"
alias gtd="git tag -d"
alias gtdr="git push origin :"
alias gst="git stash"
alias gsti="git stash --include-untracked"
alias gsts="git stash show"
alias gstsp="git stash show --patch"
alias gstp="git stash pop"
alias gsl="git stash list"
alias gft="git fetch --tags"
alias gfa="git fetch --all"
alias gshf="git show --stat --name-only --pretty=\"format:\""
alias grs="git reset"

alias gau="git update-index --assume-unchanged"
alias gac="git update-index --no-assume-unchanged"

alias gnr="git svn rebase"
alias gnd="git svn dcommit"
alias gndr="git svn dcommit --dry-run"
alias gn="git svn"
alias gcp="git cherry-pick"
alias gbt="git branch --sort=-committerdate"

# Set terminal title
function title {
    echo -ne "\033]0;$1\007"
}

function gpreb {
    git push $1 `parse_git_branch` "${@:2}"
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

alias fc="find . -name '*.cs' | xargs grep 2>/dev/null --color"
alias fci="find . -name '*.cs' | xargs grep 2>/dev/null --color -i"
alias fp="find . -name '*.php' | xargs grep 2>/dev/null --color"

function fpv() {
    find . -name '*.php' | grep -v $1 | xargs grep 2>/dev/null --color $2
}

function fx() {
    ex=""
    for var in "$@"
    do
        ex="$ex -not -path './$var/*' "
    done
    eval "find . -type f $ex"
}

alias g="grep"
alias gi="grep -i"
alias xg="xargs grep"
alias xgi="xargs grep -i"
alias fpi="find . -name '*.php' | xargs grep 2>/dev/null --color -i"
alias fj="find . -name '*.js' | xargs grep 2>/dev/null --color"
alias fji="find . -name '*js' | xargs grep 2>/dev/null --color -i"
alias fph="find . -name '*.phtml' | xargs grep 2>/dev/null --color"
alias fphi="find . -name '*.phtml' | xargs grep 2>/dev/null --color -i"
alias fa="find . -type f | xargs grep 2>/dev/null --color"
alias fai="find . -type f | xargs grep 2>/dev/null --color -i"
alias fn="find . -name"
#alias ff="find . -type f"

alias gex="grep -v"

function fz {
    find . -iname "*$1*"
}

function fzf {
    find . -type f -iname "*$1*"
}

function ff {
    find . -type f -iname "*.$1" | xargs grep ${@:2}
}


alias xg="xargs grep"
alias xgi="xargs grep -i"

#up 5 => go up 5 directories
function up {
    for i in $(seq 1 $1); do cd ..; done
}

function tagn {
    git tag -a `tn $1` -m \'${*:2}\'
    ts $1
}

alias apa="cd /etc/apache2"
alias acnf="sudo vim /etc/apache2/httpd.conf"
alias rapa="sudo apachectl restart"
alias php7="brew services stop php53 && brew services start php70"
alias php53="brew services stop php70 && brew services start php53"

alias brews="brew services"
alias brewsr="brew services restart"
alias brewss="brew services start"
alias brewsp="brew services stop"
alias sbrews="sudo brew services"

#completely annihilate phpstorm
alias kill_storm="ps aux | grep phpstorm | grep -v grep | tr -s ' ' | cut -d ' ' -f 2 | xargs kill -9"

alias fuck="ibus restart"
alias gtg="git tag --list | grep -i"

alias ports="sudo lsof -i -n -P | grep TCP"
alias cd="pushd > /dev/null"
alias cleard="dirs -c"


alias v="sudo virt-manager"

function gta {
    git tag -a $2 -m "$1"
}

HHVMD="hhvm -d xdebug.enable=1"

alias vimhuge="vim -u \"NONE\""

[ -s "/home/wcurtis/.dnx/dnvm/dnvm.sh" ] && . "/home/wcurtis/.dnx/dnvm/dnvm.sh" # Load dnvm

MAPIDIR="/Users/wescurtis/src/mapi-server"
PHPUNIT="$MAPIDIR/vendor/bin/phpunit"
MAPI_UNIT="$MAPIDIR/phpunit.xml"
PHPX="php -c $PHPBASE/php-cli-xdebug.ini"

alias mapi="cd $MAPIDIR"
alias tmapi="tail -f $MAPIDIR/storage/logs/lumen.log"
alias vmapi="vim $MAPIDIR/storage/logs/lumen.log"
alias munit="$PHPUNIT --config=$MAPI_UNIT"
alias munitx="$PHPX $PHPUNIT --config=$MAPI_UNIT"
alias frontier="cd /Users/wescurtis/src/cms-v2/trunk/sites/partners.frontier"
alias src="cd ~/src"
alias phpx="$PHPX"
alias pu="phpunit --stop-on-failure"
alias pur="phpunit"
alias pux="$PHPX vendor/bin/phpunit"

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

function getPanLog {
    sftp $1:logs/php-error.log ./php-error.log
}

alias hosts="sudo vim /etc/hosts"

function tae {
  task $1 edit
}

function tm {
  task $1 modify
}

function td {
  task $1 done
}

function tn {
  task $1 annotate ${@:2}
}

function tdr {
  DAYS=2
  task end.after:today-${1:-$DAYS}days completed
}

function tarl {
  DAYS=2
  task entry.after:today-${1:-$DAYS}days list
}

alias t="task"
alias tw="task ready"
alias ta="task add"
alias ts="task start"
alias tp="task stop"
alias tl="task all"
alias nowutc="echo \"<?php echo (new DateTime('now', new DateTimeZone('UTC')))->format('Y-m-d H:i:s') . PHP_EOL;\" | php"

function phpunitIndependent {
    for i in $(find tests -name '*Test.php'); do vendor/bin/phpunit --stop-on-failure $i || exit 255; done
}

alias gbo="git branch --sort=-committerdate"
alias dcrrm="docker-compose run --rm"
alias dc="docker-compose"
alias dm="docker-machine"
alias dps="docker ps"
alias d="docker"
function dsh {
    docker run -it $1 sh
}

alias hist="vim ~/.bash_history"
alias aws_who="aws sts get-caller-identity"
export KUBECONF="$HOME/.kube/config"
export KNAMESPACE="default"

function kns {
    export KNAMESPACE="$1"
}

function k {
    kubectl -n $KNAMESPACE "$@"
}

function kg {
    kubectl -n $KNAMESPACE get "$@"
}

function ks {
    kubectl -n $KNAMESPACE get service "$@"
}

function kn {
    kubectl -n $KNAMESPACE get namespaces "$@"
}

function kp {
    kubectl -n $KNAMESPACE get pods "$@"
}

function kdp {
    kubectl -n $KNAMESPACE get deployments "$@"
}

function ki {
    kubectl -n $KNAMESPACE get ingress "$@"
}

function kd {
    kubectl -n $KNAMESPACE describe "$@"
}

function kl {
    kubectl -n $KNAMESPACE logs "$@"
}

function kdl {
    kubectl -n $KNAMESPACE delete "$@"
}

function ktx {
    echo "namespace: $KNAMESPACE"
    echo "context: "$(kubectl config current-context)
}

function ktxs {
    rm ~/.kube/config
    ln -s ~/.kube/conf-$1 ~/.kube/config
}

function ktxl {
    find ~/.kube -name 'conf-*' -depth 1 -exec basename {} \; | sed s/conf-//
}

function kr {
    kubectl describe nodes | grep -A 2 -e "^\\s*CPU Requests"
}

function ka {
    kubectl -n $KNAMESPACE get all "$@"
}



PATH="/Users/wescurtis/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/wescurtis/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/wescurtis/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/wescurtis/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/wescurtis/perl5"; export PERL_MM_OPT;

BB="~/dotfiles/scripts/go-to-source"
alias pr="$BB pr"
alias bb="$BB"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
 
aws_clear() {
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
  unset AWS_PROFILE
}

awsmfa_ops() {
  read -r KEY_ID SECRET_KEY SESSION_KEY <<< $(aws sts get-session-token --serial-number arn:aws:iam::879277251299:mfa/wescurtis --token-code $1 --duration-seconds 129600 --output text | awk -F "\t" '{print $2; print $4; print $5; }')

  cat << EOF > ~/.aws/credentials
[default]
aws_access_key_id = $KEY_ID
aws_secret_access_key = $SECRET_KEY
aws_session_token = $SESSION_KEY
EOF

  cat ~/.aws/base-creds >> ~/.aws/credentials
}

function aws_prof() {
  local profile="${CURRENT_DEFAULT_AWS_PROFILE:=default}"
  echo $profile
}

function ap() {
    aws_clear

    echo "[default]" > ~/.aws/credentials
    awk "/\[$1\]/,/^$/" ~/.aws/base-creds | sed '1d' >> ~/.aws/credentials
    cat ~/.aws/base-creds >> ~/.aws/credentials

    export CURRENT_DEFAULT_AWS_PROFILE=$1
    echo $CURRENT_DEFAULT_AWS_PROFILE
    if [[ "$1" = "ops" ]]; then 
        awsmfa_ops $2
    fi

    aws_who
}


# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash
