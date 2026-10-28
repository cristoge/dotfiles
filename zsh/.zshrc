export EDITOR=nvim

# Load plugins
source ~/.plugins.zsh

# Load aliases
source ~/.aliases.zsh

# Load functions
source ~/.functions.zsh

# Prompt, starship, zoxide, mise
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
# Autocompletado nativo
autoload -U compinit
compinit


