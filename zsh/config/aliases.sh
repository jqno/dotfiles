# General
alias cd..='cd ..'

# setEnv.sh
alias session="source ~/.setEnv/session.sh"

# Vim
alias vanilla-vim="vim -u NONE -U NONE -N"

# Git
alias gitk-old='/usr/local/bin/gitk'
alias gitk='echo "Use tig!"'
alias gst='git status'
alias git="noglob git"   # So we can type `git add *Test*` instead of `git add "*Test*"`

# Maven
alias mvn='mvn -C'

# setEnv
alias work='. setEnv.sh work'
alias home='. setEnv.sh home'

# bat: a better `cat`
alias cat=bat

# mcd
function mcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

# MacOS pre-installs a bad version of ctags so we substitute our own.
if [[ "$(uname -s)" == "Darwin" ]]
then
  alias ctags="`brew --prefix`/bin/ctags"
fi

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

      JAVA_VERSION="$(java -version 2>&1 | grep 'version' | sed -E 's/.*version "(.*)".*/\1/')"
      if [[ $JAVA_VERSION == *"."* ]]; then
        if [[ $JAVA_VERSION == "1."* ]]; then
          # Java 8 and lower (1.8.*)
          export JAVA_MAJOR_VERSION=$(echo $JAVA_VERSION | sed "s/1\.//" | sed "s/\..*//" )
        else
          # Java 9 and up (9.*)
          export JAVA_MAJOR_VERSION=$(echo $JAVA_VERSION | sed "s/\..*//" )
        fi
      else
        # Early Access versions (don't contain .)
        export JAVA_MAJOR_VERSION=$JAVA_VERSION
      fi
    fi
  }

  function removeFromPath() {
    export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
  }

  setjdk-silent 11
fi

