

export PATH=~/.bin:$PATH
export http_proxy=proxy-ir.intel.com:911
export https_proxy=proxy-ir.intel.com:911
export HISTSIZE=10000
export HISTFILESIZE=20000

#aliases
alias ct='/usr/atria/bin/cleartool'
alias grep='grep --colour=auto'
alias ccollab=/nfs/site/local/software/codecollab/ccollab-cmdline/ccollab
alias h=history
alias hgrep='history|grep'
alias cgrep='grep --include="*.[ch]"'
alias ack=ack-grep
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias ll='ls -l'
alias su='my_su.sh'

source ~/.git-completion.bash
source ~/.git-prompt.sh

export PS1='[\u \W]\[\033[32m\]$(__git_ps1)\[\033[0m\]# '

export RTE_TARGET=x86_64-ivshmem-linuxapp-gcc
export RTE_SDK=/opt/workspace/DPDK


