#!/bin/bash
# restore_incremental.sh
BACKUP_DIR="/backups/incremental"
FILENAME="incremental_backup_$1"

echo "Restoring incremental backup..."
pg_basebackup -D /var/lib/postgresql/data/ -F t -X fetch -C -R -U user
pg_restore -U user -d db_pet_project $BACKUP_DIR/$FILENAME
echo "Incremental backup restored from: $BACKUP_DIR/$FILENAME"
