# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# shut up os x let me bash in peace
export BASH_SILENCE_DEPRECATION_WARNING=1

source ~/.bash_secrets 2>/dev/null

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s extglob

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export GOPATH="$HOME/go"
export GOROOT="/opt/homebrew/Cellar/go/1.20.4/libexec"
export GO111MODULE=on
export GOPRIVATE="gitlab.com/arivo-software-development/*"

export PATH="$HOME/src/sre/infrastructure/util:$HOME/Library/Python/3.9/bin:$HOME/src/base-images/tools/bin:/opt/homebrew/opt/mysql-client/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH:$HOME/.bin:$HOME/.tool-bin:./vendor/bin:/opt/homebrew/bin:./node_modules/.bin:$GOROOT/bin:$GOPATH/bin:/usr/local/lib/node_modules/.bin:/usr/local/go/bin"

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function getBracketBranch {
    parse_git_branch | sed 's/\(.*\)/\[\1\]/'
}

function getKNamespace {
    echo $KNAMESPACE
}

export NPS="[\d \t] \[\e[1;32m\]\u@\h\[\e[1;37m\]:\[\e[1;34m\]\w\[\e[1;31m\] \$(getBracketBranch) \[\e[1;37m\]$ \[\e[0m\]"
export KPS="\[\e[36m\][\$(getKNamespace)][\$(kubectl config current-context)]\[\e[m\]\n[\d \t] \[\e[1;32m\]\u@\h\[\e[1;37m\]:\[\e[1;34m\]\w\[\e[1;31m\] \$(getBracketBranch) \[\e[1;37m\]$ \[\e[0m\]"
export PS1=$NPS

function kps {
    export PS1="$KPS"
}

function nps {
    export PS1="$NPS"
}


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias l='ls -alF'
alias ll='ls -alFh'

alias ..="cd ../"

#put file on local clipboard
alias cb='xclip -selection c -i'
alias cbp='xclip -o -sel clip'
alias cbm='pbcopy';

stty werase undef

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
alias gcf="git commit --fixup"
alias gd="git diff"
alias gdt="git diff --staged"
alias gds="git diff --stat"
alias gdst="git diff --stat --staged"
alias gco="git checkout"
alias gcod="git checkout dev"
alias gcom="git checkout main"
alias gcomt="git checkout master"
alias gcop="git checkout -p"
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

alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias gri="git rebase -i"

alias gau="git update-index --assume-unchanged"
alias gac="git update-index --no-assume-unchanged"

alias gnr="git svn rebase"
alias gnd="git svn dcommit"
alias gndr="git svn dcommit --dry-run"
alias gn="git svn"
alias gcp="git cherry-pick"
alias gbt="git branch --sort=-committerdate"

function gpreb {
    git push $1 `parse_git_branch` "${@:2}"
}

function gras {
    git rebase -i $1 --autosquash "${@:2}"
}

function gta {
    git tag -a $2 -m "$1"
}

function gtp {
    git tag "$1" "${@:2}"
    git push origin "$1"
}

function grt {
    local tag="$1"
    git push origin :$tag || echo "remote tag delete failed"
    git tag -d $tag || echo "local tag delete failed"
    git tag $tag
    git push origin $tag
}


function fz {
    find . -iname "*$1*"
}

#up 5 => go up 5 directories
function up {
    for i in $(seq 1 $1); do cd ..; done
}

alias ports="sudo lsof -i -n -P | grep TCP"
alias vimhuge="vim -u \"NONE\""
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

alias gbo="git branch --sort=-committerdate"
alias dc="docker compose"
alias dm="docker-machine"
alias dps="docker ps"
alias d="docker"
alias dl="docker logs"
alias dk="docker kill"
alias dka='docker kill $(docker ps -q)'
alias dra='docker rm $(docker ps -q -a)'
alias dr='docker run -it'


function desh {
    docker exec -it $1 sh
}

function dsh {
    docker run -it $1 sh
}

function dshr {
    docker run --user root -it $1 sh
}

alias hist="vim $HISTFILE"
alias histc="cat $HISTFILE"
function histg {
    grep "$@" -- $HISTFILE
}

alias aws_who="aws sts get-caller-identity"
export KUBECONF="$HOME/.kube/config"
export KNAMESPACE="default"

alias kc="kubectl"
alias kdln="kubectl delete namespace"
alias kcn="kubectl create namespace"

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
    kubectl get namespaces "$@"
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

function kip {
    kubectl -n $KNAMESPACE get -o yaml "$@"
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
    echo "context: $(kubectl config current-context)"
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

function kaa {
    kubectl get all --all-namespaces "$@" 
}

function ksh {
    kubectl -n $KNAMESPACE exec -it "$1" "${@:2}"
}

function krs {
    kubectl -n $KNAMESPACE rollout restart deployment "$@"
}

export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=plain

function gst_of() {
    git stash "${@:2}" "stash@{$1}"
}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000000
export HISTFILESIZE=100000000
export HISTFILE=~/.bash_eternal_history

export VAULT_ADDR=https://vault.counsyl.com

alias ave="aws-vault exec"

AWS_DEFAULT_REGION=us-east-1
AWS_REGION=us-east-1
GPG_TTY=$(tty)

alias br="repo -o browser"
alias repoc="repo | pbcopy"
alias pl="br -t pipelines"
alias mr="br -t prs"
alias pls="repo -t pipelines"
alias jira="repo -t jira -o browser"
alias jiras="repo -t jira"
alias jirac="jiras | pbcopy"
alias mrt="repo -t mrt | vim -"
alias glh="goland ."
alias pch="pycharm ."

function glhr() {
    goland "$(git rev-parse --show-toplevel)"
}

function gcasd() {
    git clone gl:/arivo-software-development/$1 "${@:2}"
}

alias sc="vim ~/.ssh/config"

export LC_CTYPE="en_US.UTF-8"
alias pvim="pbpaste | vim -"
function cf() {
    cat "$1" | pbcopy
}

export HUSKY=0
