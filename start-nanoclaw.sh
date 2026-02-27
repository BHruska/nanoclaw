#!/bin/bash
# start-nanoclaw.sh — Start NanoClaw without systemd
# To stop: kill \$(cat /home/bhruska/_projects/nanoclaw/nanoclaw.pid)

set -euo pipefail

cd "/home/bhruska/_projects/nanoclaw"

# Stop existing instance if running
if [ -f "/home/bhruska/_projects/nanoclaw/nanoclaw.pid" ]; then
  OLD_PID=$(cat "/home/bhruska/_projects/nanoclaw/nanoclaw.pid" 2>/dev/null || echo "")
  if [ -n "$OLD_PID" ] && kill -0 "$OLD_PID" 2>/dev/null; then
    echo "Stopping existing NanoClaw (PID $OLD_PID)..."
    kill "$OLD_PID" 2>/dev/null || true
    sleep 2
  fi
fi

echo "Starting NanoClaw..."
nohup "/home/bhruska/.nvm/versions/node/v22.22.0/bin/node" "/home/bhruska/_projects/nanoclaw/dist/index.js" \
  >> "/home/bhruska/_projects/nanoclaw/logs/nanoclaw.log" \
  2>> "/home/bhruska/_projects/nanoclaw/logs/nanoclaw.error.log" &

echo $! > "/home/bhruska/_projects/nanoclaw/nanoclaw.pid"
echo "NanoClaw started (PID $!)"
echo "Logs: tail -f /home/bhruska/_projects/nanoclaw/logs/nanoclaw.log"
