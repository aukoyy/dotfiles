# PATH
typeset -U path
path=("$HOME/bin" $path)

# Load antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load

# Auto-escape special characters (?, &, etc.) in URLs typed or pasted at the prompt
autoload -Uz url-quote-magic bracketed-paste-magic
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

# Source aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Source worktree aliases
source ~/dotfiles/worktree.sh

# Use substring search (git plus arrow up finds history with git)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(~/.local/bin/mise activate zsh)"
eval "$(starship init zsh)"

. "$HOME/.cargo/env"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/aukoyy/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/aukoyy/.config/tfenv/versions/1.9.8/terraform terraform
