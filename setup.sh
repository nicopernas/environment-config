#!/bin/bash -e

function install_all {
	echo "Installing..."

	echo 'source ~/.env-config/bash_profile' >> ~/.bash_profile
	echo 'source ~/.env-config/bash_profile' >> ~/.bashrc

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

	source ~/.bash_profile

	sed 's/@@@ //' >> ~/.gitconfig <<-EOF
	@@@ [user]
	@@@ #	email = nicopernas@gmail.com
	@@@ [include]
	@@@ 	path = ~/.env-config/gitconfig
	@@@ [diff]
	@@@ #	external = ~/.env-config/external_diff.sh
	EOF

	sudofile=/etc/sudoers.d/$USER
	sudo touch $sudofile
	echo "$USER ALL=(ALL) NOPASSWD: ALL" | tee -a $sudofile
	sudo chmod 0440 $sudofile
}

function uninstall_all {
	echo "Uninstalling..."

	sed -i '/.env-config/d' .bash_profile .bashrc
	rm .inputrc
	rm .git-completion.bash
	rm .git-prompt.sh
	rm .gitconfig
	rm .vimrc
	rm -rf .vim/vim-pathogen
	rm -rf .vim/autoload
	rm -rf .vim/bundle
}

DIR=`pwd`
cd ~

if [[ "$1" == "uninstall" ]]
then
	uninstall_all
else
	install_all
fi

cd $DIR

echo "Done!"
