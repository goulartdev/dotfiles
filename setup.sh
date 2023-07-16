#!/bin/bash

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${$HOME}/.local/state"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

##########################################################################################
## Create symlinks

ln -s /mnt/wsl/PHYSICALDRIVE2/code /home/${USER}/code
ln -s /mnt/wsl/PHYSICALDRIVE2/ssh /home/${USER}/.ssh

##########################################################################################
## Setup dotfiles

. ~/code/dotfiles/install.sh

##########################################################################################
## Install apps

sudo add-apt-repository -y ppa:git-core/ppa

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
  build-essential \
  unzip \
  curl \
  wget \
  zsh \
  rsync \
  ca-certificates \
  gnupg 

## Docker 

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker && usermod -aG docker $USER


## ASDF Version Manager
git -C $XDG_DATA_HOME clone https://github.com/asdf-vm/asdf.git

touch ~/.tool-versions

## Oh My Zsh
git -C ${XDG_DATA_HOME} clone https://github.com/ohmyzsh/ohmyzsh.git

ZSH_CUSTOM=${XDG_DATA_HOME}/ohmyzsh/custom

git -C ${ZSH_CUSTOM}/plugins clone https://github.com/zsh-users/zsh-autosuggestions.git
git -C ${ZSH_CUSTOM}/plugins clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git -C ${ZSH_CUSTOM}/plugins clone https://github.com/larkery/zsh-histdb.git
git -C ${ZSH_CUSTOM}/themes clone https://github.com/romkatv/powerlevel10k.git

##########################################################################################
## SSH

sudo chown ${USER}:${USER} ~/.ssh/id_rsa
sudo chown ${USER}:${USER} ~/.ssh/id_rsa.pub

chmod 600 ${HOME}/.ssh/config
chmod 600 ${HOME}/.ssh/id_rsa
chmod 644 ${HOME}/.ssh/id_rsa.pub

##########################################################################################
## Python/Miniconda

# python deps
sudo apt install -y zlib1g-dev libbz2-dev libffi-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libssl-dev llvm libxml2-dev libxmlsec1-dev liblzma-dev

asdf plugin add python

asdf install python latest

MINICONDA_LATEST=$(asdf list all python | grep miniconda3 | tail -1)
asdf install python $MINICONDA_LATEST

asdf global python latest $MINICONDA_LATEST

conda update python -y
conda update conda -y
pip install --upgrade pip setuptools pipenv

##########################################################################################
## Node
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

npm install -g npm@latest mkcert

##########################################################################################
## Rust

asdf plugin add rust
asdf install rust stable
asdf global rust stable

##########################################################################################
## Other tools

sudo apt remove -y neovim

wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -zxf nvim-linux64.tar.gz -C ~/.local --strip-components 1 --skip-old-files
rm nvim-linux64.tar.gz

# Lunarvim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# Cargo
# https://zaiste.net/posts/shell-commands-rust/
cargo install --locked \
  # A cat clone with syntax highlighting and Git integration. https://github.com/sharkdp/bat
  bat \
  
  # A modern replacement for 'ls'. https://github.com/ogham/exa
  exa \
  
  # A replacement for ps. https://github.com/dalance/procs
  procs \
  
  # An intuitive find & replace CLI. https://github.com/chmln/sd
  sd \
  
  # Like du but more intuitive. https://github.com/bootandy/dust
  du-dust \
  
  # A customizable cross-platform graphical process/system monitor for the terminal. https://github.com/ClementTsang/bottom  
  bottom  \
  
  # A very fast implementation of tldr. https://github.com/dbrgn/tealdeer/
  tealdeer \
  
  # Generates regular expressions from user-provided test cases. https://github.com/pemistahl/grex
  grex \
  
  # A 'dmesg' implementation in Rust. https://github.com/archisgore/rmesg
  rmesg \
  
  # A smarter cd command for your terminal. https://github.com/ajeetdsouza/zoxide
  zoxide \
  
  # A syntax-highlighting pager for git. https://github.com/dandavison/delta
  git-delta

  # A simple, fast and user-friendly alternative to 'find'. https://github.com/sharkdp/fd
  # fd-find \
  
  # A line-oriented search tool that recursively searches the current directory for a regex pattern https://github.com/BurntSushi/ripgrep
  # ripgrep \
  
  # Display current network utilization by process, connection and remote IP/hostname. https://github.com/imsnif/bandwhich
  # bandwhich \
  
# cargo install --locked bat exa procs sd du-dust bottom tealdeer bandwhich grex rmesg zoxide git-delta

asdf reshim rust

##########################################################################################
## Finishing

# Clean unneeded dependencies.
sudo apt autoremove -y
sudo apt clean -y

# Make ZSH default shell
chsh -s /usr/bin/zsh



