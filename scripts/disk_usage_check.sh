#!/bin/bash
# Script to monitor disk usage on root filesystem and log alert if usage is high

echo "Script name = $0"
echo "Monitoring disk usage on / (root)..."

# Set log file path
LOGFILE="/home/ec2-user/projectlab/disk_alerts.log"

# Set alert threshold
THRESHOLD=40

# Get usage % of the root filesystem (mounted on '/'), stripping the % sign
DISKUSAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')

# Get current date and time
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Check if usage is over the threshold
if [[ $DISKUSAGE -gt $THRESHOLD ]]; then
    echo "$TIMESTAMP - ALERT: HIGH DISK USAGE - Usage = $DISKUSAGE% > Threshold = $THRESHOLD%" >> $LOGFILE
else
    echo "$TIMESTAMP - OK: Disk usage normal - Usage = $DISKUSAGE% < Threshold = $THRESHOLD%" >> $LOGFILE
fi

