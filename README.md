# Linux Scripts

A collection of useful Bash scripts for DevOps and Linux administration tasks.  
Each script is self-contained and designed to be practical, clean, and easy to use.

## Scripts

- **disk_monitor** — monitors disk usage, logs alerts, and optionally sends email notifications.
- **process_monitor** - monitors active processes for high CPU and RAM usage, logs alerts.
- **backup_directory** — backs up a directory as a date-stamped tar.gz archive and logs the process; destination can be specified.

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/deidlog/linux-scripts.git
cd linux-scripts
```
2. Make any script executable and run it:
```bash
cd <scripts_folder>
chmod +x <script-name>.sh
./<script_name>.sh [options]
```
3. Each script may have its own usage instructions. Check the README inside each script folder for details.
- disk_monitor: see /disk-monitor/README.md
- process_monitor: see /process-monitor/README.md
- backup_directory: see /backup-directory/README.md

## Contributing
Contributions are welcome! Please submit pull requests or open issues if you have suggestions or improvements.

## License
This repository is licensed under MIT License.

---
