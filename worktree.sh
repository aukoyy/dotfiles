# Git worktree helpers (bash / zsh)
# Add to ~/.zshrc or ~/.bashrc:   source ~/path/to/wt.sh
#
# Layout:
#   ~/code/<org>/<repo>                     normal clones (unchanged)
#   ~/code/worktrees/<org>/<repo>/<branch>  all worktrees
#
# Requires git 2.31+ (for --path-format).

WT_ROOT="${WT_ROOT:-$HOME/code/worktrees}"
WT_CODE="${WT_CODE:-$HOME/code}"

# Path of the main clone, even when called from inside a linked worktree
_wt_main_repo() {
  local common
  common=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || {
    echo "wt: not inside a git repo" >&2; return 1; }
  dirname "$common"
}

# wt <branch> [base] — create or reuse a worktree for <branch>, then cd into it.
# New branches start from [base] (default: current HEAD).
wt() {
  [ -z "$1" ] && { echo "usage: wt <branch> [base]" >&2; return 1; }
  local branch="$1" base="${2:-HEAD}" main repo org dest
  main=$(_wt_main_repo) || return 1
  repo=$(basename "$main")
  org=$(basename "$(dirname "$main")")
  dest="$WT_ROOT/$org/$repo/${branch//\//-}"

  if [ -d "$dest" ]; then
    cd "$dest"; return
  fi
  mkdir -p "$(dirname "$dest")"

  if git show-ref --verify --quiet "refs/heads/$branch" ||
     git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
    git worktree add "$dest" "$branch"
  else
    git worktree add -b "$branch" "$dest" "$base"
  fi && cd "$dest"
}

# wtrm [branch] — remove the worktree for <branch>, or the one you're in.
# Refuses if there are uncommitted changes (use: git worktree remove --force).
wtrm() {
  local main target
  main=$(_wt_main_repo) || return 1
  if [ -n "$1" ]; then
    target=$(git worktree list --porcelain | awk -v b="branch refs/heads/$1" \
      '/^worktree /{p=substr($0,10)} $0==b{print p}')
  else
    target=$(git rev-parse --show-toplevel)
  fi
  [ -z "$target" ] && { echo "wtrm: no worktree found" >&2; return 1; }
  [ "$target" = "$main" ] && { echo "wtrm: that's the main clone, not a worktree" >&2; return 1; }
  cd "$main" && git worktree remove "$target" && echo "removed $target"
}

# wtls — list every worktree under $WT_ROOT, flagging uncommitted changes
wtls() {
  [ -d "$WT_ROOT" ] || { echo "no worktrees"; return 0; }
  find "$WT_ROOT" -mindepth 3 -maxdepth 3 -type d | sort | while read -r d; do
    if [ -n "$(git -C "$d" status --porcelain 2>/dev/null)" ]; then
      echo "${d#$WT_ROOT/}   (dirty)"
    else
      echo "${d#$WT_ROOT/}"
    fi
  done
}

# wtprune — clear stale worktree records in every repo, remove empty folders
wtprune() {
  local g
  for g in "$WT_CODE"/*/*/.git; do
    [ -d "$g" ] && git -C "$(dirname "$g")" worktree prune
  done
  find "$WT_ROOT" -mindepth 1 -type d -empty -delete 2>/dev/null
  echo "pruned"
}
