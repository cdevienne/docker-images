#!/bin/bash
set -e

# Set environment variables
export BACKUP_DATA_DIR="${BACKUP_DATA_DIR:-/data}"
export BACKUP_CONFIG_DIR="${BACKUP_CONFIG_DIR:-/data}"
export BACKUP_TASK="${BACKUP_TASK:-$1}"

# Exit with error if BACKUP_TASK wasn't provided
if [ "${BACKUP_TASK}" == "" ]; then
  echo "The backup task must be provided either with the BACKUP_TASK environment variable or the first argument."
  exit 1
fi

echo "Triggering backup task ${BACKUP_TASK}."
mkdir -p "${BACKUP_DATA_DIR}/.tmp"
/usr/bin/flock --exclusive --wait 300 "${BACKUP_DATA_DIR}/.tmp/trigger-backup-${BACKUP_TASK}.lockfile" \
  backup perform --config-file="${BACKUP_CONFIG_DIR}/config.rb" --root-path="${BACKUP_DATA_DIR}" --trigger ${BACKUP_TASK}
