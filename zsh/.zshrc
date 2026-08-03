# Navigation shortcuts (like .. for cd ..)
# setopt AUTO_CD

# Load antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# Source aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Use substring search (git plus arrow up finds history with git)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(~/.local/bin/mise activate zsh)"
eval "$(starship init zsh)"