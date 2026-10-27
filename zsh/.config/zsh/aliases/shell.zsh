# Easier navigation:
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"

# Shortcuts
alias c="cd ~/code"
alias b="cd ~/bots"
alias p="cd ~/code/projects"
alias f="cd ~/code/flowcase"
alias ft='cd ~/code/worktrees/flowcase'

alias hosts="sudo vim /etc/hosts"

# Color flag for macOS (BSD) ls
colorflag="-G"

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, excluding . and ..
alias la="ls -lAF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for ls
alias ls="command ls ${colorflag}"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get week number
alias week='date +%V'

# Week number with date range, e.g. 44.27-2
weekd() {
  local week_number=$(date +%V)
  local dow=$(date +%u)
  local monday=$(date -v -$((dow - 1))d +%-d)
  local sunday=$(date -v +$((7 - dow))d +%-d)
  echo "${week_number}.${monday}-${sunday}"
}

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"
alias res='source ~/.zshrc'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
