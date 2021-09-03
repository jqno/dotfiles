#!/bin/bash

workspace=$1
BIN=$HOME/bin/jdtls
LOMBOK=$BIN/lombok.jar

java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    -Xms1g \
    -Xmx2G \
    -javaagent:$LOMBOK \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED \
    -jar $BIN/plugins/org.eclipse.equinox.launcher_*.jar \
    -configuration "$BIN/config_linux" \
    -data "$workspace" \
    "$@"
