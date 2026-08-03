# Load antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# Auto-escape special characters (?, &, etc.) in URLs typed or pasted at the prompt
autoload -Uz url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# Source aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Use substring search (git plus arrow up finds history with git)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(~/.local/bin/mise activate zsh)"
eval "$(starship init zsh)"