#!/usr/bin/env sh

CLASSPATH_FILE=.vim/classpath

if [[ "$1" == "-cp" ]]; then
  echo "Generating classpath..."
  mkdir -p .vim
  mvn -q org.codehaus.mojo:exec-maven-plugin:exec \
    -Dexec.classpathScope="compile" \
    -Dexec.executable="echo" \
    -Dexec.args="%classpath" > $CLASSPATH_FILE
elif [[ "$1" == "-r" ]]; then
  if [[ ! -f $CLASSPATH_FILE ]]; then
    . $0 -cp
  fi
  java -cp $(cat $CLASSPATH_FILE) $2 $3
else
  NAME=$(basename "$0")
  echo "Usage:"
  echo
  echo "*  $NAME -cp"
  echo "   Generates .vim/classpath, containing the program's complete classpath."
  echo
  echo "*  $NAME -r <classname>"
  echo "   Runs the given classname as a Java program against the generated classpath."
  echo
fi
