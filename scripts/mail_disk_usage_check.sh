#!/bin/bash
# Script to monitor disk usage on root filesystem and send alert if usage is high

echo "Script name = $0"
echo "Monitoring disk usage on / (root)..."

# Replace with your email
TO="demoaws5601@gmail.com"

# Set alert threshold
THRESHOLD=40

# Get usage % of the root filesystem (mounted on '/'), stripping the % sign
DISKUSAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')
MOUNT_INFO=$(df -h / | awk 'NR==2 {print "Filesystem: "$1", Size: "$2", Used: "$3", Available: "$4", Use%: "$5", Mounted on: "$6}')

# Get timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Check if usage is over the threshold
if [[ $DISKUSAGE -gt $THRESHOLD ]]; then
    echo -e "!! ALERT: HIGH DISK USAGE on EC2 Instance !!\n\nTimestamp: $TIMESTAMP\n\n$MOUNT_INFO\n\nCurrent Usage: $DISKUSAGE%\nThreshold: $THRESHOLD%\n\nPlease take appropriate action to free up space." \
    | mail -s "ALERT | Disk Space Usage on EC2: $DISKUSAGE% Used" $TO
else
    echo "No issues. Current Disk Usage = $DISKUSAGE% < $THRESHOLD%"
fi

