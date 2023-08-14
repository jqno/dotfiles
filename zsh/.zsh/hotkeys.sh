bindkey '^[[Z' autosuggest-accept  # Shift-tab

###
# Open VIM with current command line
###
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd "\C-v" edit-command-line


###
# FZF projects
###
function select_project() {
  local project=$(find ~/w -maxdepth 2 -type d | sort --reverse | fzf)

  if [[ -n "$project" ]];
  then
    cd "$project"
  fi

  echo "\n"

  zle reset-prompt
}

zle -N select_project
bindkey "\C-p" select_project


###
# FZF Git branches
###
function select_branch() {
  local branch=$(git branch -a --list --format "%(refname:lstrip=2)" | fzf)

  if [[ -n "$branch" ]];
  then
    git checkout "${branch/origin\//}"
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

