#!/bin/bash
# differential_backup.sh
BACKUP_DIR="/backups/differential"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
FILENAME="differential_backup_$DATE.sql"

mkdir -p $BACKUP_DIR

echo "Starting differential backup..."
pg_dump -U user -d db_pet_project -F c -a > $BACKUP_DIR/$FILENAME
if [ $? -eq 0 ]; then
  echo "Differential backup completed: $BACKUP_DIR/$FILENAME"
else
  echo "Error during differential backup process."
fi
