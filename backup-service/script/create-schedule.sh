#!/bin/bash
set -e

# Set environment variables
export BACKUP_CONFIG_DIR="${BACKUP_CONFIG_DIR:-/data}"

# Exit with error if BACKUP_TASK wasn't provided
if ! [ -f "${BACKUP_CONFIG_DIR}/schedule.rb" ]; then
  echo "Could not find the schedule definition file at ${BACKUP_CONFIG_DIR}/schedule.rb."
  exit 1
fi

# Write the whenever schedule to the cron definition
printf "Creating cron schedule from ${BACKUP_CONFIG_DIR}/schedule.rb... "
whenever --load-file "${BACKUP_CONFIG_DIR}/schedule.rb" > "/etc/cron.d/backups"
echo "done."
