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
  javac -d target/classes -cp $(cat $CLASSPATH_FILE) $2
  java -cp $(cat $CLASSPATH_FILE) $3 $4
else
  NAME=$(basename "$0")
  echo "Usage:"
  echo
  echo "*  $NAME -cp"
  echo "   Generates .vim/classpath, containing the program's complete classpath."
  echo
  echo "*  $NAME -r <filename> <classname> <parameters>"
  echo "   Runs javac on the given filename, then runs the given classname as a"
  echo "   Java program against the generated classpath, with the given parameters."
  echo
fi
