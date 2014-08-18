export PATH=~/.bin:$PATH
export HISTSIZE=10000
export HISTFILESIZE=20000
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# bash colours
C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_GREEN="\[\033[32m\]"

#aliases
alias grep='grep --colour=auto'
alias h=history
alias hgrep='history|grep'
alias cgrep='grep --include="*.[ch]"'
alias ack=ack-grep
alias gs='git status'
alias gd='git diff'
alias ged='git difftool'
alias ga='git add'
alias gitconfig='vim -p ~/.gitconfig ~/.env-config/gitconfig'
alias ls='ls --color=auto'
alias ll='ls -l'
alias llh='ls -lh'

GIT_PS1_SHOWUPSTREAM="auto"

# wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
source ~/.git-completion.bash

# wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
source ~/.git-prompt.sh

export PS1="[\u $C_WHITE\W$C_DEFAULT]\$(__git_ps1 '$C_GREEN(%s)$C_DEFAULT')# "


