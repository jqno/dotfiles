#!/bin/bash

BIN_LOCATION=$1
LOMBOK_LOCATION="$2/lombok.jar"
WORKSPACE=$3

"$BIN_LOCATION/jdtls" --jvm-arg=-javaagent:"$LOMBOK_LOCATION" --jvm-arg=-Xbootclasspath/a:"$LOMBOK_LOCATION" -data "$WORKSPACE"
