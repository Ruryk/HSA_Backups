# HSA_Backups

## All backed up

- Take/create the database from your pet project.
- Implement all kinds of repository models (Full, Incremental, Differential, Reverse Delta, CDP).
- Compare their parameters: size, ability to roll back at specific time point, speed of roll back, cost.

## Backup Types

### 1. **Full Backup**

- **Description**: Creates a complete copy of the entire database at a specific point in time.
- **Advantages**: Simple recovery to the point when the backup was taken.
- **Disadvantages**: Takes more space, especially with large databases.

### 2. **Incremental Backup**

- **Description**: Stores only the changes since the last full or incremental backup.
- **Advantages**: Saves disk space.
- **Disadvantages**: Requires all previous backups for a full restoration.

### 3. **Differential Backup**

- **Description**: Stores all changes since the last full backup.
- **Advantages**: Saves disk space and allows faster recovery.
- **Disadvantages**: The size increases over time until the next full backup.

### 4. **Reverse Delta Backup**

- **Description**: Stores the differences (deltas) between the current and previous data states.
- **Advantages**: Flexible for rolling back to previous versions.
- **

### 5. **CDP (Continuous Data Protection)**

- **Description**: Continuously logs all transactions in real-time via WAL (Write-Ahead Logs).
- **Advantages**: Can roll back to any point in time.
- **Disadvantages**: Requires significant storage space due to the constant logging of changes.

## How to Use Backups

### Creating Backups

To create a backup, run the corresponding script inside the PostgreSQL container. For example, to create a full backup:

```bash
docker exec -it postgres_db /usr/local/bin/full_backup.sh
```

## For other backup types:

- Incremental Backup:
```bash
docker exec -it postgres_db /usr/local/bin/incremental_backup.sh
```

- Differential Backup:
```bash
docker exec -it postgres_db /usr/local/bin/differential_backup.sh
```

- Reverse Delta:
```bash
docker exec -it postgres_db /usr/local/bin/reverse_delta_backup.sh
``` 

- CDP (WAL):
```bash
docker exec -it postgres_db /usr/local/bin/cdp.sh
```

## Restoring Backups
To restore the database from a backup, run the appropriate restore script. For example, to restore a full backup:
```bash
docker exec -it postgres_db /usr/local/bin/restore_full.sh full_backup_YYYY-MM-DD_HH-MM-SS.sql
```

## For other backup types:

- Incremental Backup:
```bash
docker exec -it postgres_db /usr/local/bin/restore_incremental.sh incremental_backup_YYYY-MM-DD_HH-MM-SS
```

- Differential Backup:
```bash
docker exec -it postgres_db /usr/local/bin/restore_differential.sh differential_backup_YYYY-MM-DD_HH-MM-SS.sql
```

- Reverse Delta:
```bash
docker exec -it postgres_db /usr/local/bin/restore_reverse_delta.sh reverse_delta_backup_YYYY-MM-DD_HH-MM-SS
```

- CDP (WAL):
```bash
docker exec -it postgres_db /usr/local/bin/restore_cdp.sh WAL_FILE
```

## Backup Comparison

| Backup Type      | Size     | Restore Time  | Advantages                                 | Disadvantages                                   |
|------------------|----------|---------------|--------------------------------------------|------------------------------------------------|
| Full Backup      | 18.47 MB | 0.242 seconds | Simple recovery                            | Requires more space                            |
| Incremental      | ---      | ---           | Saves space                                | Needs all previous backups for full recovery   |
| Differential     | 18.46 KB | 0.211 seconds | Faster recovery and smaller size           | Increases in size over time                    |
| Reverse Delta    | 1.01 GB  | 7.655 seconds | Flexible rollback to previous versions     | Can be complex to manage with frequent changes |
| CDP (WAL)        | 16.78 MB | Real-time     | Can roll back to any point in time         | Requires significant space for WAL logs        |

### Key Points:
1. **Full Backup** is straightforward but may consume more space.
2. **Incremental and Differential** backups save space but require more work during restoration.
3. **Reverse Delta** provides flexibility in recovering previous states.
4. **CDP (WAL)** is the most flexible but needs more storage space due to continuous logging.
