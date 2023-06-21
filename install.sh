#!/bin/bash

cd ~

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install other packages
brew install --force git the_silver_searcher tmux zsh fzf universal-ctags wget httpie \
    lsd pyenv pyenv-virtualenv direnv neovim bat

# Font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# Install python packages
sudo easy_install pip

# Install Oh My Zsh
if [ -d "~/.oh-my-zsh" ]; then
    cd .oh-my-zsh && git pull origin master && cd ~
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
else
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

# Clone nvim repo
if [ -d "~/nvim-lua" ]; then
    cd nvim-lua && git pull origin main && cd ~
else
    git clone https://github.com/tridge-hq/nvim-lua.git
fi

# nvim related
mkdir -p ~/.tmp
mkdir -p ~/.tmp/vim
mkdir -p ~/.tmp/vim/backup
mkdir -p ~/.tmp/vim/swap
mkdir -p ~/.tmp/vim/undo

mkdir -p ~/.config
mkdir -p ~/.config/nvim

# Link files
ln -sf ~/nvim-lua/init.lua ~/.config/nvim/init.lua
ln -sf ~/nvim-lua/lua ~/.config/nvim/
if [ -f "~/.zshrc" ]; then
    mv ~/.zshrc ~/.zshrc_old
fi
ln -sf ~/nvim-lua/zshrc ~/.zshrc
if [ -f "~/.tmux.conf" ]; then
    mv ~/.tmux.conf ~/.tmux.conf_old
fi
ln -sf ~/nvim-lua/tmux.conf ~/.tmux.conf

# Install tpm
if [ -d ".tmux/plugins/tpm " ]; then
    cd .tmux/plugins/tpm && git pull origin master && cd ~
else
    git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
fi
