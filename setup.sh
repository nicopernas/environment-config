#!/bin/bash

# Any subsequent commands which fail will cause the shell script to exit immediately
set -e

DIR=`pwd`
cd ~
ln -fs .env-config/bash_profile .profile
ln -fs .env-config/inputrc .inputrc
# git prompt tools
wget https://raw.github.com/git/git/master/contrib/completion/git-completion.bash -O ~/.git-completion.bash
wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
ln -fs .env-config/vimrc .vimrc

# vim pathogen install
mkdir -p ~/.vim
cd ~/.vim
git clone https://github.com/tpope/vim-pathogen
ln -fs vim-pathogen/autoload autoload
mkdir -p ~/.vim/bundle
cd bundle

# install additional VIM plugins
git clone https://github.com/embear/vim-localvimrc.git

source ~/.profile

echo "
[user]
#	email = nicopernas@gmail.com
[include]
	path = ~/.env-config/gitconfig
[diff]
#	external = ~/.env-config/external_diff.sh
" >> ~/.gitconfig

cd $DIR

# Turn off automatic exit on failure.
set +e
