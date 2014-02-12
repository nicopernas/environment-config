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
alias ged='git difftool'
alias ga='git add'
alias gitconfig='vim -p ~/.gitconfig ~/.env-config/gitconfig'
alias ll='ls -l'
alias llh='ls -lh'

GIT_PS1_SHOWUPSTREAM="auto"

# https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
source ~/.git-completion.bash

# https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
source ~/.git-prompt.sh

export PS1="[\u $C_WHITE\W$C_DEFAULT]\$(__git_ps1 '$C_GREEN(%s)$C_DEFAULT')# "


