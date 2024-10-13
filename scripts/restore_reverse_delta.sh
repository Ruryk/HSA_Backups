#!/bin/bash
# restore_reverse_delta.sh
BACKUP_DIR="/backups/reverse_delta"
FILENAME="$1"

echo "Restoring reverse delta backup..."
rsync -av $BACKUP_DIR/$FILENAME/ /var/lib/postgresql/data/
echo "Reverse delta backup restored from: $BACKUP_DIR/$FILENAME"
