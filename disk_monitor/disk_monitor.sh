#!/usr/bin/env bash
#
# disk_monitor.sh - monitorin disk space usage
#
# Author: deidlog
#
# Purpose: Checks whether the file system usage does not exceed the specified threshold
#
# Usage: ./disk_monitor.sh
#

# ====== Settings ======
THRESHOLD=80                         # Disk usage threshold in %
EMAIL=""            # Specify an email address for notifications (or leave it blank)

# Logs go to home directory for safety; can switch to /var/log with root
LOG_DIR="$HOME/logs"                 
LOG_FILE="$LOG_DIR/disk_monitor.log"

mkdir -p "$LOG_DIR"

# ====== Functions ======
log_message() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') : ${message}" | tee -a "$LOG_FILE"
}

send_alert() {
    local fs="$1"
    local usage="$2"
    local message="ALERT: Disk usage on ${fs} reached ${usage}%!"

    log_message "$message"

    # If an email is specified, we will send an email
    if [[ -n "$EMAIL" ]]; then
        echo "$message" | mail -s "Disk Usage Alert on $(hostname)" "$EMAIL"
    fi
}

# ====== Basic logic ======
while IFS= read -r line; do
    usage=$(echo "$line" | awk '{print $5}' | tr -d '%')
    fs=$(echo "$line" | awk '{print $6}')

    if (( usage > THRESHOLD )); then
        send_alert "$fs" "$usage"
    else
        log_message "OK: $fs - ${usage}%"
    fi
done < <(df -hP | awk 'NR>1')

exit 0
