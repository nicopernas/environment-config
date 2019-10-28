#!/bin/bash

set -u -e

script_dir="$( dirname "$( realpath "$0" )" )"

install_all() {
    echo "Installing..."

    echo "source $script_dir/bash_profile #dotfiles" >> ~/.bash_profile
    echo "export ENV_CONFIG=$script_dir #dotfiles" >> ~/.bash_profile
    echo "source $script_dir/bash_profile #dotfiles" >> ~/.bashrc
    echo "export ENV_CONFIG=$script_dir #dotfiles" >> ~/.bashrc

    ln -fs "$script_dir/inputrc" ~/.inputrc
    ln -fs "$script_dir/tmux.conf" ~/.tmux.conf

    # git prompt tools
    url='https://raw.github.com/git/git/master/contrib/completion'
    wget "$url/git-completion.bash" -O ~/.git-completion.bash
    wget "$url/git-prompt.sh" -O ~/.git-prompt.sh

    ln -fs "$script_dir/vimrc" ~/.vimrc

    # vim pathogen install
    mkdir -p ~/.vim
    rm -rf ~/.vim/vim-pathogen
    git clone https://github.com/tpope/vim-pathogen ~/.vim/vim-pathogen
    ln -fs ~/.vim/vim-pathogen/autoload ~/.vim/autoload

    # install additional VIM plugins
    rm -rf ~/.vim/bundle
    mkdir -p ~/.vim/bundle
    git clone --depth=1 https://github.com/embear/vim-localvimrc.git ~/.vim/bundle/vim-localvimrc.git
    git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic.git
    git clone --depth=1 https://github.com/ludovicchabant/vim-gutentags.git ~/.vim/bundle/vim-gutentags.git
    git clone --depth=1 https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim.git

    # shellcheck disable=SC1090
    source ~/.bash_profile

    sed 's/[ ]*@@ //' > ~/.gitconfig <<EOF
    @@ [user]
    @@     name = Nicolás Pernas Maradei
    @@     #email = nicopernas@gmail.com
    @@ [include]
    @@     path = $script_dir/gitconfig
    @@ [diff]
    @@     #external = $script_dir/external_diff.sh
    @@ [core]
    @@     excludesfile = $script_dir/gitignore_global
EOF

    sudofile="/etc/sudoers.d/$USER"
    sudo touch "$sudofile"
    echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee "$sudofile"
    sudo chmod 0440 "$sudofile"
}

uninstall_all() {
    echo "Uninstalling..."

    sed -i '/#dotfiles/d' ~/.bash_profile ~/.bashrc
    rm ~/.inputrc
    rm ~/.tmux.conf
    rm ~/.git-completion.bash
    rm ~/.git-prompt.sh
    rm ~/.gitconfig
    rm ~/.vimrc
    rm -rf ~/.vim/vim-pathogen
    rm -rf ~/.vim/autoload
    rm -rf ~/.vim/bundle
    sudo rm "/etc/sudoers.d/$USER"
}

action="${1:-install}"

if [[ "$action" == 'uninstall' ]]; then
    uninstall_all
else
    install_all
fi

echo "Done!"
