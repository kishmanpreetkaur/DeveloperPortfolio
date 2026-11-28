#!/bin/bash
# Author: Kishmanpreet Kaur
# Roll Number: 2601730397
# Purpose: Create a compressed backup of a folder

if [ $# -ne 1 ]; then
    echo "Usage: ./backup.sh <folder>"
    exit 1
fi

SOURCE="$1"

if [ ! -d "$SOURCE" ]; then
    echo "Error: Folder does not exist."
    exit 1
fi

BACKUP_DIR="$HOME/DeveloperPortfolio_Backups"
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
FOLDER_NAME=$(basename "$SOURCE")
BACKUP_FILE="$BACKUP_DIR/backup_${TIMESTAMP}.tar.gz"

if tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE")" "$FOLDER_NAME"; then
    SIZE=$(du -h "$BACKUP_FILE" | awk '{print $1}')
    MESSAGE="SUCCESS: $BACKUP_FILE | Size: $SIZE"
    echo "$MESSAGE"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $MESSAGE" >> "$BACKUP_DIR/backup.log"
else
    MESSAGE="FAILED: Backup could not be created for $SOURCE"
    echo "$MESSAGE"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $MESSAGE" >> "$BACKUP_DIR/backup.log"
    exit 1
fi
