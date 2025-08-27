# Process Monitor

A simple Bash script to monitor high CPU and RAM usage processes on Linux systems.
Logs resource usage and sends alerts for processes exceeding defined thresholds.

## Features
- Monitors all running processes.
- Logs events to a file (`$HOME/logs/process_monitor.log` by default).
- Optional email notifications for processes exceeding CPU or RAM thresholds.
- Easy to run manually or as a cron job.

## Configuration
- `EMAIL` — email address for notifications (optional, leave empty if not needed).
- `CPU_THRESHOLD` — maximum allowed CPU usage in percent (default: 70%).
- `RAM_THRESHOLD` — maximum allowed RAM usage in percent (default: 70%).
- `LOG_DIR` — directory for log files (default: `$HOME/logs`).

## Usage
```bash
chmod +x process_monitor.sh
./process_monitor.sh
```

## Example Output
```bash
2025-08-26 12:30:00 : OK: Process 1234 (bash) CPU: 2% RAM: 1%
2025-08-26 12:30:01 : ALERT: Process 5678 (chrome) by user CPU: 85% RAM: 72%!
```

## Running as a Cron Job
To run the script every 5 minutes and log output:
```bash
*/5 * * * * /path/to/process_monitor.sh
```

## Notes
- Can be extended to send notifications via messaging apps (Telegram, Slack, etc.) using APIs.
- Safe logging in $HOME/logs by default; can be changed to /var/log if run as root.
- Can be integrated with system monitoring dashboards (e.g., Grafana, Zabbix) by parsing the log file. 
---
