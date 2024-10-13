#!/bin/bash
# restore_cdp.sh
WAL_DIR="/backups/wal"
FILENAME="000000010000000000000001"

echo "Restoring CDP (WAL)..."
pg_basebackup -D /var/lib/postgresql/data/ -R -U user
pg_waldump $WAL_DIR/$FILENAME
pg_restore -U user -d db_pet_project
echo "CDP restored from WAL logs: $WAL_DIR/$FILENAME"
