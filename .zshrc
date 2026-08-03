# Path to homebrew
#export PATH=/opt/homebrew/bin:$PATH

# source $ZSH/oh-my-zsh.sh

# User configuration

# Source aliases
if [ -f ~/dotfiles-zsh/.aliases ]; then
    source ~/dotfiles-zsh/.aliases
else
    echo "404: ~/dotfiles-zsh/.aliases not found."
fi


# Set a function that can print the current version of some packages
function versions() {
  if command -v pyenv 1>/dev/null 2>&1; then
    echo "Using pyenv for Python versions"
    echo "Python version:"
    python -V
  fi

  echo ""
  echo "Using volta for node versions"
  echo "Node version:"
  node -v
  echo "NPM version:"
  npm -v
}

# Load antidote
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load
# Use subscring search (git pluss arrow up finds history with git)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(~/.local/bin/mise activate zsh)"
#eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

#TRANSIENT_PROMPT_PROMPT='$(starship prompt --terminal-width="$COLUMNS" --keymap="${KEYMAP:-}" --status="$STARSHIP_CMD_STATUS" --pipestatus="${STARSHIP_PIPE_STATUS[*]}" --cmd-duration="${STARSHIP_DURATION:-}" --jobs="$STARSHIP_JOBS_COUNT")'
#TRANSIENT_PROMPT_TRANSIENT_PROMPT='$(starship module character)'eval "$(/Users/aukoyy/.local/bin/mise activate zsh)"
