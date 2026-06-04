#!/bin/bash
set -e
sudo dnf update -y
echo "Instalando paquetes base..."
sudo dnf install -y \
  tmux \
  git \
  zoxide \
  fzf \
  ripgrep \
  fd-find \
  luarocks \
  stow \
  wl-clipboard \
  pipx \
  eza \
  atuin

sudo dnf install -y neovim

sudo dnf copr enable dejan/lazygit -y
sudo dnf install -y lazygit

sudo dnf copr enable scottames/ghostty -y
sudo dnf install -y ghostty

curl -sS https://starship.rs/install.sh | sh -s -- -y
curl -f https://zed.dev/install.sh | sh

echo "Instalación completada"
