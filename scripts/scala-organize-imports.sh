#!/usr/bin/env sh

echo "Organizing $@"
echo "Please wait..."

scalafix \
  --tool-classpath $(cs fetch com.github.liancheng:organize-imports_2.13:0.4.0 -p) \
  --scalac-options -Ywarn-unused \
  --rules OrganizeImports \
  --classpath $(mvn -q org.codehaus.mojo:exec-maven-plugin:exec -Dexec.classpathScope="compile" -Dexec.executable="echo" -Dexec.args="%classpath") \
  --files $@
