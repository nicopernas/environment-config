export PATH="/usr/local/sbin:$HOME/.bin:$HOME/.local/bin:$PATH"

# set these to unlimited size
export HISTSIZE=-1
export HISTFILESIZE=-1

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoredups:ignorespace:erasedups
HISTTIMEFORMAT="%d/%m/%y %T "
# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# bash colours
C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_GREEN="\[\033[32m\]"
C_RED="\[\033[31m\]"

if [[ "$( uname )" == 'Darwin' ]]; then
    export CLICOLOR=1
    export LSCOLORS='gxfxcxdxbxexexabagacad'
    alias ls='ls -bFHGLOPW'
else
    alias ls='ls --color'
fi

#aliases
alias grep='grep --colour=auto'
alias h=history
alias hgrep='history|grep'
alias gs='git status'
alias gd='git diff'
alias ged='git difftool'
alias ga='git add'
alias gu='git undo'
alias grb='git rbi'
alias gl='git lg'
alias gitconfig='vim -p ~/.gitconfig "$ENV_CONFIG"/gitconfig'
alias ll='ls -l'
alias llh='ls -lh'
alias fuck='sudo $(history -p \!\!)'
alias xmod='chmod +x'
alias mkae=make
alias untar='tar xvf'
alias ..='cd ..'

# functions
cgrep() {
    grep --include=*.{c,cpp,h,hpp,s,S} -rn --exclude-dir=build* "${@}"
}

lgrep() {
    grep --include="*.lua" -rn "${@}"
}

known_hosts_update() {
    line_number=$1
    if [[ "$line_number" =~ ^[0-9]+$ ]]; then
        sed -i "${line_number}d" ~/.ssh/known_hosts
    else
        echo "Invalid line number: '$line_number'"
        echo "Usage: $FUNCNAME line_number"
    fi
}

last_file() {
  ls -tr | tail -n1
}

plot () {
    gnuplot -e "set terminal dumb 200 50; set datafile separator ','; plot '$1' pt '*'"
}

GIT_PS1_SHOWUPSTREAM="auto"

#source ~/.git-completion.bash
source ~/.git-prompt.sh

export PS1="[\u@\h ${C_WHITE}\W${C_DEFAULT}]\$(__git_ps1 '${C_GREEN}(%s)${C_DEFAULT}')# "
EDITOR=vim

# disable Software Flow Control (XON/XOFF flow control)
# https://unix.stackexchange.com/a/72092/398334
stty -ixon
