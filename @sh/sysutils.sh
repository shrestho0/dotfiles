#!/bin/bash


function na(){
    # Check if argument is given
    if [ -z "$1" ]; then
    echo "Usage: $0 <minutes>"
    exit 1
    fi

    X=$1

    # Wait for X minutes
    sleep "$((X * 60))"

    # Linux notification
    if command -v notify-send >/dev/null; then
    notify-send "Time's up!" "Your $X-minute timer has finished."
    # macOS notification
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    osascript -e 'display notification "Your timer has finished." with title "Time'"'"'s Up!"'
    else
    echo "Timer done! (No GUI notification tool found.)"
    fi
}

kill_port() {
  if [ -z "$1" ]; then
    echo "Usage: kill_port <port_number>"
    return 1
  fi

  PORT=$1
  PID=$(lsof -t -i :$PORT)

  if [ -z "$PID" ]; then
    echo "No process is using port $PORT."
  else
    echo "Killing process $PID using port $PORT..."
    kill -9 $PID && echo "Process $PID killed."
  fi
}


