#!/bin/bash

set -u -e

script_dir="$( dirname "$( realpath "$0" )" )"

install_all() {
    echo "Installing..."

    echo "source $script_dir/bash_profile #dotfiles" >> ~/.bash_profile
    echo "export ENV_CONFIG=$script_dir #dotfiles" >> ~/.bash_profile
    echo "source $HOME/.bash_profile" >> ~/.bashrc

    ln -fs "$script_dir/inputrc" ~/.inputrc
    ln -fs "$script_dir/tmux.conf" ~/.tmux.conf

    # git prompt tools
    url='https://raw.github.com/git/git/master/contrib/completion'
    wget "$url/git-completion.bash" -O ~/.git-completion.bash
    wget "$url/git-prompt.sh" -O ~/.git-prompt.sh

    # VIM
    ln -fs "$script_dir/vimrc" ~/.vimrc
    mkdir -p ~/.vim/{undo,backup,swap,spell,bundle}
    git clone https://github.com/tpope/vim-pathogen ~/.vim/vim-pathogen
    plugins=(
      https://github.com/embear/vim-localvimrc.git
      https://github.com/vim-syntastic/syntastic.git
      # https://github.com/ludovicchabant/vim-gutentags.git
      https://github.com/kien/ctrlp.vim.git
      https://github.com/tpope/vim-fugitive.git
      https://github.com/tpope/vim-commentary.git
      https://github.com/rust-lang/rust.vim.git
      https://github.com/fatih/vim-go.git
      https://github.com/preservim/nerdtree.git
      https://github.com/tomlion/vim-solidity.git
      https://github.com/leafgarland/typescript-vim.git
      https://github.com/neoclide/coc.nvim.git
    )

    ln -fs "$script_dir/skeletons" "$HOME/.vim/skeletons"

    for url in "${plugins[@]}"; do
      git clone --depth=1 "$url" "$HOME/.vim/bundle/$( basename "$url" )"
    done

    ln -fs ~/.vim/vim-pathogen/autoload ~/.vim/autoload
    ln -fs "$script_dir/vim_spell_en.utf-8.add" ~/.vim/spell/en.utf-8.add

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


    if [ -f /usr/share/X11/xkb/symbols/gb ]; then
      # TODO: register the layout in /usr/share/X11/xkb/rules/evdev.xml
      sed 's/[ ]*@@//' <<EOF | sudo tee -a /usr/share/X11/xkb/symbols/gb
        @@partial alphanumeric_keys
        @@        xkb_symbols "wasd" {
        @@
        @@    // WASD keyboard layout
        @@    include "gb(basic)"
        @@    name[Group1]="English (UK, WASD keyboard layout)";
        @@
        @@    key <AE02> { [          2,         at,    EuroSign ] };
        @@    key <AC11> { [ apostrophe,    quotedbl             ] };
        @@    key <TLDE> { [      grave,     notsign             ] };
        @@ // key <MENU> { [    Super_R                          ] };
        @@};
EOF
    fi
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
