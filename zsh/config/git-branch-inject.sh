function current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function inject_text_into_buffer() {
  TMP=$RBUFFER
  BUFFER="$LBUFFER$1"
  CURSOR=$#BUFFER
  BUFFER="$BUFFER$TMP"
}

function inject_current_branch() {
  inject_text_into_buffer $(current_branch)
}

function inject_current_ticket_number() {
  inject_text_into_buffer $(current_branch | sed -e 's/[-_].*//' | sed -e 's/^[^/]*\///')
}

zle -N inject_current_branch
zle -N inject_current_ticket_number
bindkey "\C-b" inject_current_branch
bindkey "\C-n" inject_current_ticket_number

