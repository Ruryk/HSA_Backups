#!/bin/bash
# cdp.sh
WAL_DIR="/backups/wal"

mkdir -p $WAL_DIR

echo "Starting Continuous Data Protection..."
pg_receivewal -D $WAL_DIR -U user -h localhost
if [ $? -eq 0 ]; then
  echo "CDP started, writing WAL logs to: $WAL_DIR"
else
  echo "Error during CDP process."
fi
