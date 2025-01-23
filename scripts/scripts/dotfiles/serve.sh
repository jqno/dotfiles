#!/usr/bin/env bash

port=${2:-4000}
cmd="python3 -m http.server"
pid=$(pgrep -f "$cmd")
if [[ "$1" == "start" ]]; then
  if [[ "$pid" == "" ]]; then
    eval "$cmd $port" > /dev/null 2>&1 &
    echo "🚀 HTTP server started on port $port"
  else
    echo "❌ HTTP server was already running!"
    exit 1
  fi
elif [[ "$1" == "status" ]]; then
  if [[ "$pid" == "" ]]; then
    echo "⭕ No HTTP server is running"
  else
    echo "🟢 HTTP server is running"
  fi
elif [[ "$1" == "stop" ]]; then
  if [[ "$pid" == "" ]]; then
    echo "❌ No HTTP server found"
    exit 1
  else
    kill "$pid"
    echo "🏁 HTTP server stopped"
  fi
else
  echo "Usage:"
  echo "  $(basename "$0") start [port]  starts the webserver in the current directory on [port] (default is 4000)"
  echo "  $(basename "$0") status        checks if a server is running"
  echo "  $(basename "$0") stop          stops a running webserver"
fi
