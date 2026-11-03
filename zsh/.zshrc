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

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/cristog/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions
#
[ -f ~/.secrets ] && source ~/.secrets
