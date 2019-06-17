###
# FZF Git branches
###
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


###
# Inject current branch and ticket number
###
function inject_text_into_buffer() {
  TMP=$RBUFFER
  BUFFER="$LBUFFER$1"
  CURSOR=$#BUFFER
  BUFFER="$BUFFER$TMP"
}

function inject_current_branch() {
  inject_text_into_buffer $(git_current_branch)
}

function inject_current_ticket_number() {
  inject_text_into_buffer $(git_current_branch | sed -e 's/[-_].*//' | sed -e 's/^[^/]*\///')
}

zle -N inject_current_branch
zle -N inject_current_ticket_number
bindkey "\C-b" inject_current_branch
bindkey "\C-n" inject_current_ticket_number

