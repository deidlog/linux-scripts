#!/usr/bin/env bash
#
# process_monitor.sh - monitor high CPU and RAM usage processes
#
# Author: deidlog
#
# Purpose: Finds processes consuming more than the specified CPU or RAM threshold
#
# Usage: ./process_monitor.sh
#


# ====== Settings ======
EMAIL=""            # Specify an email address for notifications (or leave it blank)
CPU_THRESHOLD=70                        # CPU usage threshold in %
RAM_THRESHOLD=70                        # RAM usage threshold in %
LOG_DIR="$HOME/logs"                    # Log directory
LOG_FILE="$LOG_DIR/process_monitor.log"

mkdir -p "$LOG_DIR"

# ====== Functions ======
# Logs messages to file with timestamp
log_message() {
    local message="$1"
    echo "$(date +%Y-%m-%d %H:%M:%S) : ${message}" | tee -a "$LOG_FILE"
}

# Alerts about high resource usage
send_alert() {
    local pid="$1"
    local user="$2"
    local cpu="$3"
    local ram="$4"
    local command="$5"
    local message="ALERT: Process $pid ($command) by $user uses CPU: ${cpu}% RAM: ${ram}%!"

    log_message "$message"

    # If an email is specified, we will send an email
    if [[ -n "$EMAIL" ]]; then
        echo "$message" | mail -s "Process Usage Alert on $(hostname)" "$EMAIL"
    fi
}

# ====== Main logic ======
# Loop through all processes and check CPU and RAM usage
while IFS= read -r line; do
    pid=$(echo "$line" | awk '{print $1}')
    user=$(echo "$line" | awk '{print $2}')
    cpu=$(echo "$line" | awk '{print $3}')
    ram=$(echo "$line" | awk '{print $4}')
    command=$(echo "$line" | awk '{print $5}')

    cpu_int=${cpu%.*}
    ram_int=${ram%.*}

    if (( cpu_int > CPU_THRESHOLD || ram_int > RAM_THRESHOLD )); then
        send_alert "$pid" "$user" "$cpu" "$ram" "$command"
    else
        log_message "OK: Process $pid ($command) CPU: ${cpu}% RAM: ${ram}%"
    fi

done < <(ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | awk 'NR>1')

exit 0