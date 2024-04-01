#!/bin/bash

TIMESTAMP=$(date '+%Y-%m-%d_%H:%M:%S')

cd $HOME

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install other packages
brew install --force git the_silver_searcher tmux zsh fzf universal-ctags wget httpie \
    lsd pyenv pyenv-virtualenv direnv neovim bat

# Font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font


# Install python packages
sudo easy_install pip

# Update or install Oh My Zsh
if test -d "$HOME/.oh-my-zsh"; then
  echo ".oh-my-zsh found in the system, update existing repository..."
  cd $HOME/.oh-my-zsh && git pull origin master && cd $HOME
else
  echo "Installing .oh-my-zsh..."
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi
if ! test -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting"; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi
if ! test -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions"; then
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions
fi

# Clone nvim repo
if test -d "$HOME/nvim-lua"; then
    cd nvim-lua && git pull origin main && cd $HOME
else
    git clone https://github.com/tridge-hq/nvim-lua.git $HOME/nvim-lua
fi

# nvim related
mkdir -p $HOME/.tmp
mkdir -p $HOME/.tmp/vim
mkdir -p $HOME/.tmp/vim/backup
mkdir -p $HOME/.tmp/vim/swap
mkdir -p $HOME/.tmp/vim/undo

mkdir -p $HOME/.config
mkdir -p $HOME/.config/nvim

# Link files
ln -sf $HOME/nvim-lua/init.lua $HOME/.config/nvim/init.lua
ln -sf $HOME/nvim-lua/lua $HOME/.config/nvim/
if test -f "$HOME/.zshrc"; then
    mv $HOME/.zshrc $HOME/.zshrc_old_$TIMESTAMP
fi
ln -sf $HOME/nvim-lua/zshrc $HOME/.zshrc
if test -f "$HOME/.tmux.conf"; then
    mv $HOME/.tmux.conf $HOME/.tmux.conf_old_$TIMESTAMP
fi
ln -sf $HOME/nvim-lua/tmux.conf $HOME/.tmux.conf

# Install tpm
if test -d "$HOME/.tmux/plugins/tpm"; then
    cd $HOME/.tmux/plugins/tpm && git pull origin master && cd $HOME
else
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi
