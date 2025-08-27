# Disk Monitor

A simple Bash script to monitor disk space usage on Linux systems.  
Logs disk usage and sends alerts if usage exceeds a defined threshold.

## Features
- Monitors all mounted filesystems.
- Logs events to a file (`$HOME/logs/disk_monitor.log` by default).
- Optional email notifications when disk usage exceeds the threshold.
- Easy to run manually or as a cron job.

## Configuration
- `THRESHOLD` — maximum allowed disk usage in percent (default: 80%).
- `EMAIL` — email address for notifications (optional, leave empty if not needed).
- `LOG_DIR` — directory for log files (default: `$HOME/logs`).

## Usage
```bash
chmod +x disk_monitor.sh
./disk_monitor.sh
```

## Example Output
```bash
2025-08-26 12:30:00 : OK: / - 55%
2025-08-26 12:30:00 : ALERT: Disk usage on /home reached 82%!
```

## Running as a Cron Job
To run the script every 10 minutes and log output:
```bash
*/10 * * * * /path/to/disk_monitor.sh
```

## Notes
- Can be extended to send notifications via messaging apps (Telegram, Slack, etc.) using APIs.
- Safe logging in $HOME/logs by default; can be changed to /var/log if run as root.
- Can be integrated with system monitoring dashboards (e.g., Grafana, Zabbix) by parsing the log file. 
---