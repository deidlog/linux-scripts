#!/usr/bin/env bash
#
# backup_directory.sh - backup a specified directory with date-stamped tar.gz archive
#
# Author: deidlog
#
# Purpose: Creates a compressed tar.gz backup of a specified directory and copies it to a user-defined destination.
#
# Usage: ./backup_directory.sh /path/to/source_dir /path/to/destination_dir
#

# ====== Settings ======
SOURCE_DIR="$1"                          # Directory to backup (passed as first argument)
DEST_DIR="${2:-$HOME/backups}"           # Destination directory (second argument, default: $HOME/backups)
LOG_DIR="$HOME/logs"                     # Log directory
LOG_FILE="$LOG_DIR/backup_directory.log"

mkdir -p "$LOG_DIR"
mkdir -p "$DEST_DIR"

# ====== Functions ======
# Logs messages to file with timestamp
log_message() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') : $message" | tee -a "$LOG_FILE"
}

# ====== Main logic ======
# Check if source directory is provided
if [[ -z "$SOURCE_DIR" ]]; then
    echo "Usage: $0 /path/to/source_directory [destination_directory]"
    exit 1
fi

# Check if source directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
    log_message "Backup failed: Source directory '$SOURCE_DIR' does not exist!"
    exit 1
fi

# Create date-stamped backup filename
DATE=$(date '+%Y-%m-%d_%H-%M-%S')
BASENAME=$(basename "$SOURCE_DIR")
BACKUP_FILE="$DEST_DIR/${BASENAME}_backup_$DATE.tar.gz"

# Create tar.gz archive
if tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$BASENAME"; then
    log_message "Backup successful: $BACKUP_FILE"
else
    log_message "Backup failed for $SOURCE_DIR"
    exit 1
fi

exit 0
