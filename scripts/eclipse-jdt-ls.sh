#!/usr/bin/env sh

SERVERPATH="$HOME/bin/eclipse-jdt-ls"

# To connect a debugger, add the following parameter:
#   -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 \

CONFIGPATH=config_linux
if [ "$(uname -s)" == "Darwin" ]; then
  CONFIGPATH=config_mac
fi

java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.level=ALL \
    -Dfile.encoding=UTF-8 \
    -noverify \
    -Xms1G \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    -jar $SERVERPATH/plugins/org.eclipse.equinox.launcher_1.*.jar \
    -configuration $SERVERPATH/$CONFIGPATH/ \
    "$@"

