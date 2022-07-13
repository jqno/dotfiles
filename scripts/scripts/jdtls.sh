#!/bin/bash

WORKSPACE=$1
BIN=$HOME/bin/jdtls
LOMBOK=$BIN/lombok.jar

jdtls --jvm-arg=-javaagent:"$LOMBOK" --jvm-arg=-Xbootclasspath/a:"$LOMBOK" -data "$WORKSPACE"
