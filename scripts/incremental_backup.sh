#!/bin/bash
# incremental_backup.sh
BACKUP_DIR="/backups/incremental"
WAL_DIR="/backups/wal"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
FILENAME="incremental_backup_$DATE"

mkdir -p $BACKUP_DIR
mkdir -p $WAL_DIR

echo "Starting incremental backup..."
pg_basebackup -D $BACKUP_DIR/$FILENAME -X stream -h localhost -U user
if [ $? -eq 0 ]; then
  echo "Incremental backup completed: $BACKUP_DIR/$FILENAME"
else
  echo "Error during incremental backup process."
fi
