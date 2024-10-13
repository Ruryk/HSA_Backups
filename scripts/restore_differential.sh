#!/bin/bash
# restore_differential.sh
BACKUP_DIR="/backups/differential"
FILENAME="differential_backup_$1.sql"

echo "Restoring differential backup..."
pg_restore -U user -d db_pet_project $BACKUP_DIR/$FILENAME
echo "Differential backup restored from: $BACKUP_DIR/$FILENAME"
