#!/bin/bash

set -e

sudo apt update && sudo apt upgrade -y

echo "Instalando paquetes base..."
sudo apt install -y \
  tmux \
  git \
  zoxide \
  nodejs \
  npm \
  fzf \
  ripgrep \
  fd-find \
  luarocks \
  stow \
  wl-clipboard \
  pipx

sudo snap install nvim --classic

sudo apt install -y lazygit

sudo apt install -y eza

curl -sS https://starship.rs/install.sh | sh -s -- -y
#ghostty
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

sudo npm install -g tree-sitter-cli

sudo apt install -y atuin

echo "Instalación completada"
