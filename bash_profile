export PATH=~/.bin:$PATH
export HISTSIZE=10000
export HISTFILESIZE=20000

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
alias ga='git add'
alias ll='ls -l'
alias llh='ls -lh'

GIT_PS1_SHOWUPSTREAM="auto"

source ~/.git-completion.bash
source ~/.git-prompt.sh

#export PS1='[\u \W]\[\033[32m\]$(__git_ps1)\[\033[0m\]# '
export PS1="[\u $C_WHITE\W$C_DEFAULT]\$(__git_ps1 '$C_GREEN(%s)$C_DEFAULT')# "


