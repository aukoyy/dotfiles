# wt.sh

Shell helpers for git worktrees. Keeps every worktree in one place, separate from your clones.

## Layout

```
~/code/<org>/<repo>                      normal clones (unchanged)
~/code/worktrees/<org>/<repo>/<branch>   all worktrees
```

## Setup

Requires git 2.31+. Works in bash and zsh.

Add this to `~/.zshrc` or `~/.bashrc`:

```bash
source ~/path/to/wt.sh
```

## Commands

| Command               | What it does                                                          |
|-----------------------|-----------------------------------------------------------------------|
| `wt <branch> [base]`  | Create or reuse a worktree for `<branch>` and `cd` into it            |
| `wtrm [branch]`       | Remove the worktree for `<branch>`, or the one you're in              |
| `wtls`                | List all worktrees across repos and flag ones with uncommitted changes |
| `wtprune`             | Clear stale worktree records in every repo and delete empty folders   |

`wt` checks out existing local or `origin` branches. Otherwise it creates a new branch from `[base]`, which defaults to the current `HEAD`. Slashes in branch names become dashes in folder names, so `feature/login` becomes `feature-login`.

## Example

```bash
cd ~/code/acme/api
wt feature/login     # -> ~/code/worktrees/acme/api/feature-login
# work, commit, push
wtrm                 # back in ~/code/acme/api, worktree removed
```

## Config

| Variable  | Default             | Purpose                   |
|-----------|---------------------|---------------------------|
| `WT_ROOT` | `~/code/worktrees`  | Where worktrees are created |
| `WT_CODE` | `~/code`            | Where your clones live    |

Set these before sourcing the script to override them.

## Notes

- A branch can only be checked out in one worktree at a time.
- Each new worktree needs its own dependency install (`npm install`, `.env`, etc.).
- `wtrm` refuses if there are uncommitted changes and keeps the branch. Delete the branch with `git branch -d <branch>`.
