#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="embabel-demo"

echo "Following logs for ${CONTAINER_NAME}... Press Control+C to exit."
docker logs -f "${CONTAINER_NAME}"
