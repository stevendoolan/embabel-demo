#!/usr/bin/env bash
#
# Copies store.json from the Docker container's writable volume back to the
# local sonic-pi-examples/ directory so it can be used for non-Docker runs.
#
set -euo pipefail

CONTAINER_PATH="/app/store-data/store.json"
LOCAL_PATH="sonic-pi-examples/store.json"

echo "Copying store.json from Docker container..."
docker compose cp "embabel-demo:${CONTAINER_PATH}" "${LOCAL_PATH}"
echo "Saved to ${LOCAL_PATH}"
