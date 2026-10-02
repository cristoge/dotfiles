export EDITOR=nvim

# Load plugins
source ~/.plugins.zsh

# Load aliases
source ~/.aliases.zsh

# Load functions
source ~/.functions.zsh

# Prompt, starship, zoxide, atuin
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh --disable-up-arrow)"

# Autocompletado nativo
autoload -U compinit
compinit


# Detecta el OS
if [[ "$(uname)" == "Darwin" ]]; then
    TMUX_CONF="$HOME/dotfiles/tmux/macos/.tmux.conf"
else
    TMUX_CONF="$HOME/dotfiles/tmux/linux/.tmux.conf"
fi

# Alias para usar tmux con la configuración correcta
alias tmux="tmux -f $TMUX_CONF"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/cristog/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions
