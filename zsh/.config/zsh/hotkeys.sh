# Autosuggest
bindkey '^[[Z' autosuggest-accept  # Shift-tab

# The delete button doesn't work unless we bind it to `delete-char`
bindkey "^[[3~" delete-char
bindkey -M vicmd "^[[3~" delete-char

# Up/Down keys, take into account what's already been typed
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward


###
# Prevent clearing the entire line when pressing certain key bindings in the Neovim terminal
###
function insert_space {
  LBUFFER+=" "
}
zle -N insert_space

bindkey '^[[127;2u' backward-delete-char # Shift+Backspace
bindkey '^[[127;5u' backward-delete-char # Ctrl+Backspace
bindkey '^[[32;2u' insert_space # Shift-Space


###
# FZF projects
###
function select_project() {
  local project=$(find ~/w ~/Dropbox/notes -maxdepth 2 -type d 2> /dev/null | sort --reverse | fzf)

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
  local branch=$(git branch -a --sort=-committerdate --list --format "%(refname:lstrip=2)" | fzf)

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
  inject_text_into_buffer "$(git_current_branch)"
}

function inject_current_ticket_number() {
  inject_text_into_buffer "$(git_current_branch | sed -e 's/[-_].*//' | sed -e 's/^[^/]*\///')"
}

zle -N inject_current_branch
zle -N inject_current_ticket_number
bindkey "\C-b" inject_current_branch
bindkey "\C-n" inject_current_ticket_number
