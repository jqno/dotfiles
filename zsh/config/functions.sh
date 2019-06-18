
###
# VI mode
###

# Assign the current VI mode to the env variable VIMODE
function zle-keymap-select zle-line-init zle-line-finish {
  case $KEYMAP in
    vicmd)
      export VIMODE='n'
      ;;
    viins|main)
      export VIMODE='i'
      ;;
  esac

  zle reset-prompt
  zle -R
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select


###
# Git
###

function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

