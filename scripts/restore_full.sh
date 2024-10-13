#!/bin/bash
# restore_full.sh
BACKUP_DIR="/backups/full"
FILENAME="full_backup_$1.sql"

echo "Restoring full backup..."
pg_restore -U user -d db_pet_project $BACKUP_DIR/$FILENAME
echo "Full backup restored from: $BACKUP_DIR/$FILENAME"
