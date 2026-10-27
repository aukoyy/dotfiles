# Git aliases
alias g="git"
alias gs='git status'
alias gco="git checkout"
alias gfo="git fetch origin"
alias gp='git pull'
alias gpy="git pull && yarn"
alias pi='git pull && npm i'
alias gb='git branch'
alias glg='git lg -30'
alias gprune='git fetch --prune && git for-each-ref --format="%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" refs/heads | xargs git branch -d'

# git worktree
alias gw='git worktree'
alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwr='git worktree remove'
alias gwp='git worktree prune'
alias gwm='git worktree move'

# Open PRs where my review is requested
prs() {
  gh search prs --review-requested=@me --state=open \
    --json repository,number,title,labels,updatedAt,url \
    --template '{{tablerow "REPO" "ID" "UPDATED" "LABELS" "TITLE"}}{{range .}}{{tablerow .repository.nameWithOwner (printf "#%v" .number | color "green") (timeago .updatedAt) (pluck "name" .labels | join ", ") (hyperlink .url .title)}}{{end}}{{tablerender}}'
}
