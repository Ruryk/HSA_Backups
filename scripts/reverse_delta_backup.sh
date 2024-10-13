#!/bin/bash
# reverse_delta_backup.sh
BACKUP_DIR="/backups/reverse_delta"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
PREVIOUS_BACKUP="$BACKUP_DIR/previous"
FILENAME="reverse_delta_backup_$DATE"

mkdir -p $BACKUP_DIR

echo "Starting reverse delta backup..."
if [ -d "$PREVIOUS_BACKUP" ]; then
    rsync -av --compare-dest="$PREVIOUS_BACKUP" /var/lib/postgresql/data/ $BACKUP_DIR/$FILENAME
else
    cp -r /var/lib/postgresql/data/ $BACKUP_DIR/$FILENAME
fi

if [ $? -eq 0 ]; then
  echo "Reverse delta backup completed: $BACKUP_DIR/$FILENAME"
  # Update the link to the previous backup
  rm -rf $BACKUP_DIR/previous
  ln -s $BACKUP_DIR/$FILENAME $BACKUP_DIR/previous
else
  echo "Error during reverse delta backup process."
fi
