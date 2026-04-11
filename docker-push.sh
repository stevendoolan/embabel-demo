#!/usr/bin/env bash
set -euo pipefail

: "${DOCKER_USER:?Error: DOCKER_USER environment variable must be set}"
IMAGE_NAME="embabel-demo"
TAG="$(date +%Y%m%d-%H%M%S)"
VERSIONED_TAG="${DOCKER_USER}/${IMAGE_NAME}:${TAG}"
LATEST_TAG="${DOCKER_USER}/${IMAGE_NAME}:latest"

echo "Building ${VERSIONED_TAG}..."
docker build -t "${VERSIONED_TAG}" -t "${LATEST_TAG}" .

echo "Pushing ${VERSIONED_TAG}..."
docker push "${VERSIONED_TAG}"

echo "Pushing ${LATEST_TAG}..."
docker push "${LATEST_TAG}"

echo "Tagging git repo with ${TAG}..."
git tag "${TAG}"
git push origin "${TAG}"

echo "Done. Image available at https://hub.docker.com/r/${DOCKER_USER}/${IMAGE_NAME}"
