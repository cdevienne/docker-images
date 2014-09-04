#!/bin/bash
set -e

# Set the service URL
SERVICE_URL=${SERVICE_URL:-$1}
WAIT_SECONDS=5

# Exit with error if SERVICE_URL wasn't provided
if [ "${SERVICE_URL}" == "" ]; then
  echo "The service URL must be provided either with the SERVICE_URL environment variable or the first argument."
  exit 1
fi

printf "Checking for service listening at ${SERVICE_URL}... "
while curl "${SERVICE_URL}" > /dev/null 2>&1; test ${PIPESTATUS[0]} -gt 0; do
  echo "not listening."
  printf "Waiting ${WAIT_SECONDS} seconds and trying again... "
  sleep ${WAIT_SECONDS}
done
echo "listening!"
