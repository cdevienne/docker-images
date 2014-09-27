#!/bin/bash
set -e

# Set environment variables
export BACKUP_DATA_DIR="${BACKUP_DATA_DIR:-/data}"
export BACKUP_CONFIG_DIR="${BACKUP_CONFIG_DIR:-/etc/backups}"
export BACKUP_COMMAND="${1:-init}"

# Make sure the specified directories are present
mkdir -p "${BACKUP_DATA_DIR}"
mkdir -p "${BACKUP_CONFIG_DIR}"

# Check for a known command
BACKUP_COMMAND=$1
case "${BACKUP_COMMAND}" in
  "trigger" )
    # Extract the backup task argument and execute it
    shift
    BACKUP_TASK=$1
    command="script/trigger-backup.sh ${BACKUP_TASK}"
    ;;
  "schedule"|"scheduler"|"cron" )
    # Write the crontab entries from the whenever schedule
    script/create-schedule.sh
    # Call the phusion baseimage docker initialization script
    command="/sbin/my_init"
    ;;
  "init" )
    # Call the phusion baseimage docker initialization script
    command="/sbin/my_init"
    ;;
  * )
    command="$@"
    ;;
esac

${command}
