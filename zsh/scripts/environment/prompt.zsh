autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"
setopt prompt_subst

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

function prompt_working_directory() {
  echo "%~"
}

function prompt_setenv_prompt_injection() {
  [[ -e ~/.setEnv/prompt ]] && cat ~/.setEnv/prompt
}

function prompt_ret_status() {
  local RET_STATUS=""
  [[ $1 -ne 0 ]] && RET_STATUS="×"
  echo $RET_STATUS
}

function prompt_root_and_jobs() {
  local SYMS=""
  [[ $UID -eq 0 ]] && SYMS+="⚡ "
  [[ $(jobs -l | wc -l) -gt 0 ]] && SYMS="λ"
  echo $SYMS
}

function prompt_is_inside_git() {
  [[ -n "$GIT_STATUS" ]]
}

function prompt_is_git_dirty() {
  # This regex looks like a smiley but it means there must be no space on the second char of the line
  echo $GIT_STATUS | grep "^.[^ ]" > /dev/null 2>&1
  [[ "$?" -eq 0 ]] && echo $1 || echo $2
}

function prompt_git_branch() {
  local BRANCH=$(git branch --no-color 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/")
  [[ -n $BRANCH ]] && echo $BRANCH || echo '?'
}

function prompt_git_local() {
  local INFO=""

  # Staged changes
  echo $GIT_STATUS | grep "^D" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="D"
  echo $GIT_STATUS | grep "^A" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="A"
  echo $GIT_STATUS | grep "^M" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="M"
  echo $GIT_STATUS | grep "^R" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="R"

  # Assumed flag
  local GIT_ASSUMED=$(git ls-files -v | grep ^h 2> /dev/null)
  [[ -n "$GIT_ASSUMED" ]] && INFO+="(ASSUMED)"

  echo $INFO
}

function prompt_git_remote() {
  local INFO=""

  # Has remote
  echo $GIT_STATUS | grep "\.\.\." > /dev/null 2>&1
  [[ "$?" -ne "0" ]] && INFO+="¤"

  # Ahead, behind
  echo $GIT_STATUS | grep "ahead" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="↑$(echo "$GIT_STATUS" | sed 's/.*ahead \([0-9]*\).*/\1/; 1q')"
  echo $GIT_STATUS | grep "behind" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && INFO+="↓$(echo "$GIT_STATUS" | sed 's/.*behind \([0-9]*\).*/\1/; 1q')"

  # Stashes flag
  # (We're not using `git stash` because that's very slow)
  [[ -e "$(git rev-parse --show-toplevel)/.git/refs/stash" ]] && INFO+="Σ"

  echo $INFO
}

function prompt_git_warnings() {
  local WARNINGS=""

  # Diverged
  echo $GIT_STATUS | grep "ahead" | grep "behind" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && WARNINGS+="Δ"

  # Merging
  echo $GIT_STATUS | grep "Unmerged paths" > /dev/null 2>&1
  [[ "$?" -eq "0" ]] && WARNINGS+="🔀 "

  # Warning for no email setting
  git config user.email | grep @ > /dev/null 2>&1
  [[ "$?" -ne 0 ]] && WARNINGS+="!!! NO EMAIL SET !!!"

  echo $WARNINGS
}

function build_prompt() {
  # Capturing the exit code must happen first
  local EXIT=$?

  if [[ "$VIMODE" == "n" ]]
  then
    local cVIMODE="%F{16}%K{116}"
    local cERROR=$cVIMODE
    local cDIR=$cVIMODE
    local cBRANCH=$cVIMODE
    local cGITSTATUS=$cVIMODE
    local cSEP=$cVIMODE
    local cARROW=$cVIMODE
  else
    local cERROR="%F{124}%k"
    local cDIR="%F{215}%k"
    local cBRANCH="%F{215}%k"
    local cGITSTATUS="%F{188}%k"
    local cSEP="%F{245}%k"
    local cARROW="%F{188}%k"
  fi

  local RAW_SEP="❯"
  local SEP="$cSEP$RAW_SEP"
  local P=""

  local WORKING_DIR=$(prompt_working_directory)
  local INJECTION=$(prompt_setenv_prompt_injection)
  local GIT_STATUS=$(git status -sb --porcelain 2> /dev/null)
  local GIT_WARNINGS=""

  P+="$cARROW┌ "
  P+="$SEP $cDIR$WORKING_DIR"
  [[ -n "$INJECTION" ]] && P+=" $SEP $cDIR$INJECTION"

  if prompt_is_inside_git
  then
    P+=" $SEP $cBRANCH$(prompt_git_branch)"

    local REMOTE=$(prompt_git_remote)
    local LOCAL=$(prompt_git_local)
    [[ -n "$REMOTE" ]] && P+=" $SEP $cGITSTATUS$REMOTE"
    [[ -n "$LOCAL" ]] && P+=" $SEP $cGITSTATUS$LOCAL"

    GIT_WARNINGS=$(prompt_git_warnings)
  fi

  P+=" $SEP"
  P+="\n"
  P+="$cARROW└ "

  local SYMS=$(prompt_root_and_jobs)
  local RET_STATUS=$(prompt_ret_status $EXIT)
  [[ -n "$RET_STATUS$SYMS$GIT_WARNINGS" ]] && P+="$SEP "
  [[ -n "$SYMS" ]] && P+="$cGITSTATUS$SYMS"
  [[ -n "$RET_STATUS" ]] && P+="$cERROR$RET_STATUS"
  [[ -n "$GIT_WARNINGS" ]] && P+="$cERROR$GIT_WARNINGS"
  [[ -n "$RET_STATUS$SYMS$GIT_WARNINGS" ]] && P+=" "

  P+="$(prompt_is_git_dirty $cERROR $cSEP)$RAW_SEP"

  P+="%{$reset_color%} "

  echo $P
}

PROMPT='$(build_prompt)'
