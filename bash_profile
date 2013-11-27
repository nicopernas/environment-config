

export PATH=~/.bin:$PATH
export HISTSIZE=10000
export HISTFILESIZE=20000

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

source ~/.git-completion.bash
source ~/.git-prompt.sh

export PS1='[\u \W]\[\033[32m\]$(__git_ps1)\[\033[0m\]# '



