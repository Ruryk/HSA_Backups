#!/bin/bash
# full_backup.sh
BACKUP_DIR="/backups/full"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
FILENAME="full_backup_$DATE.sql"

mkdir -p $BACKUP_DIR

echo "Starting full backup..."
pg_dump -U user -d db_pet_project -F c > $BACKUP_DIR/$FILENAME
if [ $? -eq 0 ]; then
  echo "Full backup completed: $BACKUP_DIR/$FILENAME"
else
  echo "Error during Full backup process."
fi