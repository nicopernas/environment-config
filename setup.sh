#!/bin/bash -e

function install_all {
	echo "Installing..."

	echo "source $DIR/bash_profile #dotfiles" >> ~/.bash_profile
	echo "source $DIR/bash_profile #dotfiles" >> ~/.bashrc
	echo "export ENV_CONFIG=$DIR #dotfiles" >> ~/.bash_profile
	echo "export ENV_CONFIG=$DIR #dotfiles" >> ~/.bashrc

	ln -fs $DIR/inputrc ~/.inputrc

	# git prompt tools
	url='https://raw.github.com/git/git/master/contrib/completion'
	wget "$url/git-completion.bash" -O ~/.git-completion.bash
	wget "$url/git-prompt.sh" -O ~/.git-prompt.sh

	ln -fs $DIR/vimrc ~/.vimrc

	# vim pathogen install
	mkdir -p ~/.vim
	cd ~/.vim
	git clone https://github.com/tpope/vim-pathogen
	ln -fs vim-pathogen/autoload autoload
	mkdir -p ~/.vim/bundle
	cd bundle

	# install additional VIM plugins
	git clone https://github.com/embear/vim-localvimrc.git
	git clone --depth=1 https://github.com/vim-syntastic/syntastic.git

	source ~/.bash_profile

	sed 's/@@@ //' >> ~/.gitconfig <<-EOF
	@@@ [include]
	@@@ 	path = $DIR/gitconfig
	@@@ [diff]
	@@@ #	external = $DIR/external_diff.sh
	@@@ [core]
	@@@	 excludesfile = $DIR/gitignore_global
	EOF

	sudofile=/etc/sudoers.d/$USER
	sudo touch $sudofile
	echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee -a $sudofile
	sudo chmod 0440 $sudofile
}

function uninstall_all {
	echo "Uninstalling..."

	sed -i '/#dotfiles/d' ~/.bash_profile ~/.bashrc
	rm ~/.inputrc
	rm ~/.git-completion.bash
	rm ~/.git-prompt.sh
	rm ~/.gitconfig
	rm ~/.vimrc
	rm -rf ~/.vim/vim-pathogen
	rm -rf ~/.vim/autoload
	rm -rf ~/.vim/bundle
	sudo rm /etc/sudoers.d/$USER
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$1" == "uninstall" ]]
then
	uninstall_all
else
	install_all
fi

cd $DIR

echo "Done!"
