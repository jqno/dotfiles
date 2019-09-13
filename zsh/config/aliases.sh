# General
alias cd..='cd ..'

# Vim
alias vanilla-vim="vim -u NONE -U NONE -N"

# Git
alias gitk-old='/usr/local/bin/gitk'
alias gitk='echo "Use tig!"'
alias gst='git status'
alias git="noglob git"   # So we can type `git add *Test*` instead of `git add "*Test*"`

# setEnv
alias work='. setEnv.sh work'
alias home='. setEnv.sh home'

# bat: a better `cat`
alias cat=bat

# MacOS pre-installs a bad version of ctags so we substitute our own.
if [[ "$(uname -s)" == "Darwin" ]]
then
  alias ctags="`brew --prefix`/bin/ctags"
fi

# iTerm2
function set-iterm-title() {
  echo -ne "\e]1;$1\a"
}

# Java
if [[ "$(uname -s)" == "Darwin" ]]
then

  function setjdk() {
    setjdk-silent $@
    java -version
  }
  function setjdk-silent() {
    if [ $# -ne 0 ]; then
      removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
      if [ -n "${JAVA_HOME+x}" ]; then
        removeFromPath $JAVA_HOME
      fi
      export JAVA_HOME=`/usr/libexec/java_home -v $@`
      export PATH=$JAVA_HOME/bin:$PATH
    fi
  }
  function removeFromPath() {
    export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
  }

  setjdk-silent 11
fi

