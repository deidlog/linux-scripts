# Backup Directory

A simple Bash script to create a compressed tar.gz backup of a specified directory with a date-stamped filename.  
Logs the backup process and allows the user to specify the destination directory.

## Features
- Creates a compressed `.tar.gz` archive of any directory.
- Adds a timestamp to the archive filename for easy versioning.
- Logs all backup events to a file (`$HOME/logs/backup_directory.log` by default).
- Allows specifying the destination directory (default: `$HOME/backups`).
- Easy to run manually or schedule as a cron job.

## Configuration
- `SOURCE_DIR` — the directory to backup (passed as the first argument to the script).
- `DEST_DIR` — destination directory for backups (optional, second argument; defaults to `$HOME/backups`).
- `LOG_DIR` — directory for log files (default: `$HOME/logs`).

## Usage
```bash
chmod +x backup_directory.sh
./backup_directory.sh /path/to/source_directory /path/to/destination_directory
```
- If the destination directory is not provided, the backup will be saved to $HOME/backups.

## Example Output
```bash
2025-08-28 10:00:01 : Backup successful: /home/user/backups/data_backup_2025-08-28_10-00-01.tar.gz
2025-08-28 10:00:01 : Backup failed: Source directory '/home/user/missing_dir' does not exist!
```

## Running as a Cron Job
To backup a directory every day at 2:00 AM:
```bash
0 2 * * * /path/to/backup_directory.sh /path/to/source_directory /path/to/destination_directory
```

## Notes
- Logs are stored safely in $HOME/logs by default; can be changed to /var/log if run as root.
- The script creates a date-stamped archive to prevent overwriting previous backups.
- Can be used to backup directories to external drives or network shares by specifying DEST_DIR.
---
