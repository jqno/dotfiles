function select_branch() {
  local branch=$(git branch -a --list --format "%(refname:lstrip=2)" | fzf)

  if [[ ! -z "$branch" ]];
  then
    git checkout ${branch/origin\//}
  fi

  echo "\n"

  zle reset-prompt
}

zle -N select_branch
bindkey "\C-g" select_branch

