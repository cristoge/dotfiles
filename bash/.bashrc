#!/bin/bash

# Editor por defecto
export EDITOR=nvim

# Cargar plugins, alias y funciones
source ~/dotfiles/bash/aliases.bash

# Prompt, starship, zoxide
eval "$(starship init bash)"
eval "$(zoxide init bash)"

# Autocompletado nativo
if type compinit &>/dev/null; then
  # En Bash usamos `bash-completion` si está instalado
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
