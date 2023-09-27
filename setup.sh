#!/bin/bash

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

hostnamectl set-hostname djonathan

sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoremove 
sudo apt autoclean

sudo fwupdmgr get-devices
sudo fwupdmgr get-updates
sudo fwupdmgr update

flatpak update

sudo pop-upgrade recovery upgrade from-release

sudo system76-power graphics hybrid

# sudo reboot now

##########################################################################################
## Setup dotfiles

mkdir ~/code 
git -C ~/code clone --recurse-submodules git@github.com:goulartdev/dotfiles.git

. ~/code/dotfiles/install.sh

##########################################################################################
## Install apps

sudo add-apt-repository -y ppa:git-core/ppa

sudo apt install -y \
  build-essential \
  curl \
  wget \
  zsh \
  rsync \
  ca-certificates \
  gnupg \
  timeshift \
  snapd \
  gparted \
  gnome-tweaks \
  git \
  gamemode \
  xclip \
  sqlite3 \
  cmake

sudo apt autoremove
sudo apt autoclean

sudo flatpak install flathub \
  org.kde.okular \
  org.videolan.VLC \
  org.gimp.GIMP \
  org.inkscape.Inkscape \
  com.getpostman.Postman \
  md.obsidian.Obsidian \
  org.qgis.qgis \
  org.qbittorrent.qBittorrent \
  io.podman_desktop.PodmanDesktop \
  com.spotify.Client \
  com.valvesoftware.Steam \
  com.github.tchx84.Flatseal \
  net.davidotek.pupgui2 \
  org.freedesktop.Platform.VulkanLayer.MangoHud

sudo snap install code --classic

## neovim
sudo apt remove -y neovim

curl -Lso ${HOME}/bin/nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
 | chmod u+x ${HOME}/bin/nvim

# curl -Ls https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz \
#  | tar --directory ~/.local --strip-components=1 -zxf nvim-linux64.tar.gz --skip-old-files

## Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker && usermod -aG docker $USER

## ASDF Version Manager
git -C $XDG_DATA_HOME clone https://github.com/asdf-vm/asdf.git
cp $XDG_DATA_HOME/asdf/completions $XDG_DATA_HOME/zsh/completions

. $XDG_DATA_HOME/asdf/asdf.sh

## micromamba
mkdir -p $MAMBA_ROOT_PREFIX/bin

curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest \
  | tar --directory $MAMBA_ROOT_PREFIX/bin/ --strip-components=1 -xvj bin/micromamba

$MAMBA_EXE shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" > ~/.local/share/mamba/mamba.sh

##########################################################################################
## Rust

asdf plugin add rust
asdf install rust stable
# asdf global rust stable

cargo install --locked alacritty bat exa procs sd du-dust bottom tealdeer rmesg zoxide git-delta fd ripgrep

# bat: A cat clone with syntax highlighting and Git integration. https://github.com/sharkdp/bat
# exa: A modern replacement for 'ls'. https://github.com/ogham/exa
# procs: A replacement for ps. https://github.com/dalance/procs
# sd: An intuitive find & replace CLI. https://github.com/chmln/sd
# dust: Like du but more intuitive. https://github.com/bootandy/dust
# bottom: A customizable cross-platform graphical process/system monitor for the terminal. https://github.com/ClementTsang/bottom  
# tealdeer: A very fast implementation of tldr. https://github.com/dbrgn/tealdeer/
# grex: Generates regular expressions from user-provided test cases. https://github.com/pemistahl/grex
# rmesg: A 'dmesg' implementation in Rust. https://github.com/archisgore/rmesg
# zoxide: A smarter cd command for your terminal. https://github.com/ajeetdsouza/zoxide
# git-delta: A syntax-highlighting pager for git. https://github.com/dandavison/delta
# fd: A simple, fast and user-friendly alternative to 'find'. https://github.com/sharkdp/fd
# ripgrep: A line-oriented search tool that recursively searches the current directory for a regex pattern https://github.com/BurntSushi/ripgrep

asdf reshim rust

# https://github.com/starship/starship/releases/download/v1.16.0/starship-x86_64-unknown-linux-gnu.tar.gz
#

## alcritty desktop launcher and completions

sudo curl -sLo ${XDG_DATA_HOME}/zsh/completions/_alacritty https://github.com/alacritty/alacritty/releases/latest/download/_alacritty
sudo curl -sLo /usr/share/pixmaps/Alacritty.svg https://github.com/alacritty/alacritty/releases/latest/download/Alacritty.svg
sudo curl -sL https://github.com/alacritty/alacritty/releases/latest/download/Alacritty.desktop | desktop-file-install
sudo update-desktop-database

#sudo mkdir -p /usr/local/share/man/man1
#gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
#gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

# TODO: refazer instalação do alacritty
# https://github.com/alacritty/alacritty/blob/v0.12.2/INSTALL.md

##########################################################################################
## Misc

# Lunarvim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

## Fonts
mkdir -p ${XDG_DATA_HOME}/fonts
cd ${XDG_DATA_HOME}/fonts

curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/FiraCodeNerdFont-Regular.ttf
curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/FiraCodeNerdFontMono-Regular.ttf

fc-cache -f -v

compaudit | xargs chmod g-w,o-w # disable the write permission of "group" and "others" 

chsh -s /usr/bin/zsh


## to track
https://github.com/zsh-users/zsh-autosuggestions  releases
https://github.com/atuinsh/atuin releases
https://github.com/zdharma-continuum/fast-syntax-highlighting commits
https://github.com/jeffreytse/zsh-vi-mode releases
https://github.com/romkatv/powerlevel10k releases

https://github.com/direnv/direnv
