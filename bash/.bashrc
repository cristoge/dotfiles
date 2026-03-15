#!/bin/bash

# Editor por defecto
export EDITOR=nvim

# Cargar plugins, alias y funciones
source ~/dotfiles/bash/aliases.bash

# Prompt, starship, zoxide, atuin
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(atuin init bash --disable-up-arrow)"

# Autocompletado nativo
if type compinit &>/dev/null; then
  # En Bash usamos `bash-completion` si está instalado
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Detecta el OS
if [ "$(uname)" = "Darwin" ]; then
  TMUX_CONF="$HOME/dotfiles/tmux/macos/.tmux.conf"
else
  TMUX_CONF="$HOME/dotfiles/tmux/linux/.tmux.conf"
fi

# Alias para usar tmux con la configuración correcta
alias tmux="tmux -f $TMUX_CONF"

# opencode
export PATH=/home/cristo/.opencode/bin:$PATH
