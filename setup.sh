#!/bin/bash

cd ~ && \
ln -s .env-config/bash_profile .profile  && \
# git prompt tools
wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash && \
wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh && \
ln -s .env-config/vimrc .vimrc && \
# vim patogen install
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O ~/.vim/autoload/pathogen.vim && \
source .profile  && \
echo "[include]
        path = ~/.env-config/gitconfig
[diff]
#       external = /home/nico/.env-config/external_diff.sh
[merge]
        tool = meld" >> ~/.gitconfig && \
cd -

