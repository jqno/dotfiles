#!/usr/bin/env bash

# Keeping this as a shell script instead of a .gitconfig file
# so we can do some platform-specific things.

git config --global user.name "Jan Ouwens"
git config --global color.ui true
git config --global push.autoSetupRemote true
git config --global push.followTags true
git config --global pull.rebase true
git config --global remote.origin.prune true
git config --global commit.verbose true
git config --global diff.algorithm patience
git config --global diff.compactionHeuristic true
git config --global init.defaultBranch main
git config --global help.autocorrect prompt

git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global merge.conflictstyle zdiff3
git config --global diff.colorMoved plain

git config --global alias.amend "commit --amend"
git config --global alias.ci "commit -v"
git config --global alias.co checkout
git config --global alias.cpick cherry-pick
git config --global alias.empty "commit --allow-empty -m \"Trigger notification\""
git config --global alias.flush "clean -fd"
git config --global alias.flush-all "clean -fdx"
git config --global alias.l10 "!git --no-pager log -10 --pretty=format:'%Cred%h%Creset %C(yellow)%d%Creset %s %Cgreen(%an) %Cblue(%cr)%Creset' --abbrev-commit --date=relative && echo"
git config --global alias.mail "config user.email"
git config --global alias.main '!f() { if git show-ref --quiet refs/heads/main; then branch="main"; else branch="master"; fi; git stash && git checkout $branch && git pull && git remote prune origin && git stash pop; }; f'
git config --global alias.showstash "stash show -p"
git config --global alias.sts "status -s"
git config --global alias.prune-local "!git branch -vv | awk '/: gone]/{print \$1}' | xargs git branch -d"
git config --global alias.prune-local-force "!git branch -vv | awk '/: gone]/{print \$1}' | xargs git branch -D"
git config --global alias.uncommit "reset HEAD^"
git config --global alias.wipe "!git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1 --hard"


# Stash:
# git stsh      # unstaged + staged + untracked
# git stash     # unstaged + staged
git config --global alias.stsh "stash --include-untracked"


# for presentations: see https://coderwall.com/p/ok-iyg/git-prev-next
git config --global alias.prev "checkout HEAD^1"
git config --global alias.next "!sh -c 'git log --reverse --pretty=%H master | awk \"/\$(git rev-parse HEAD)/{getline;print}\" | xargs git checkout'"


# Assume
git config --global alias.assume "update-index --skip-worktree"
git config --global alias.unassume "update-index --no-skip-worktree"
git config --global alias.assumed "!git ls-files -v | grep ^S | sed 's/^S //'"


if [[ $(uname -s) == MINGW* ]]; then
  # Windows
  git config --global core.autocrlf true
elif [[ $(uname -s) == "Darwin" ]]; then
  git config --global credential.helper osxkeychain
else
  # Unix
  git config --global credential.helper cache
fi

