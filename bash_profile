export PATH=~/.bin:$PATH
export HISTSIZE=10000
export HISTFILESIZE=20000
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
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

#aliases
alias grep='grep --colour=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias h=history
alias hgrep='history|grep'
alias gs='git status'
alias gd='git diff'
alias ged='git difftool'
alias ga='git add'
alias gu='git undo'
alias gitconfig='vim -p ~/.gitconfig "$ENV_CONFIG"/gitconfig'
alias ll='ls -l'
alias llh='ls -lh'
alias fuck='sudo $(history -p \!\!)'
alias xmod='chmod +x'
alias rand_pass='openssl rand -base64 20'
alias mkae=make
alias untar='tar xvf'

# functions
function cgrep {
	grep --include="*.[ch]" -rn "$1" "${@:2}"
}

function lgrep {
	grep --include="*.lua" -rn "$1" "${@:2}"
}

function known_hosts_update {
	line_number=$1
	if [[ "$line_number" =~ ^[0-9]+$ ]]; then
		sed -i "${line_number}d" ~/.ssh/known_hosts
	else
		echo "Invalid line number: '$line_number'"
		echo "Usage: $FUNCNAME line_number"
	fi
}

GIT_PS1_SHOWUPSTREAM="auto"

source ~/.git-completion.bash
source ~/.git-prompt.sh

export PS1="[\u@\h $C_WHITE\W$C_DEFAULT]\$(__git_ps1 '$C_GREEN(%s)$C_DEFAULT')# "


