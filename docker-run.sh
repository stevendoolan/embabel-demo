#!/usr/bin/env bash
set -euo pipefail

IMAGE="stevendoolan/embabel-demo:latest"
PORT="48080"
CONTAINER_NAME="embabel-demo"

# Stop and remove the container
if [ "${1:-}" = "--stop" ] || [ "${1:-}" = "-s" ]; then
  echo "Stopping ${CONTAINER_NAME}..."
  docker rm -f "${CONTAINER_NAME}" 2>/dev/null || echo "Container not running."
  exit 0
fi

# Pull the latest image unless --run-only is specified
if [ "${1:-}" = "--run-only" ] || [ "${1:-}" = "-r" ]; then
  shift
else
  echo "Pulling ${IMAGE}..."
  docker pull "${IMAGE}"
fi

# Build docker run arguments
ARGS=("-p" "${PORT}:8080" "--name" "${CONTAINER_NAME}")

# Point Ollama at the Docker host so the container can reach it
ARGS+=("-e" "SPRING_AI_OLLAMA_BASE_URL=http://host.docker.internal:11434")

# Pass through provider environment variables if they are set
for VAR in ANTHROPIC_BASE_URL ANTHROPIC_API_KEY OPENAI_BASE_URL OPENAI_API_KEY; do
  if [ -n "${!VAR:-}" ]; then
    ARGS+=("-e" "${VAR}")
  fi
done

# Pass through optional model overrides if set
for VAR in EMBABEL_MODELS_DEFAULT_LLM EMBABEL_MODELS_LLMS_BEST EMBABEL_MODELS_LLMS_CHEAPEST; do
  if [ -n "${!VAR:-}" ]; then
    ARGS+=("-e" "${VAR}")
  fi
done

# Remove any existing container with the same name
docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true

echo "Starting ${IMAGE} on port ${PORT}..."
docker run -d "${ARGS[@]}" "${IMAGE}"

echo "Following logs... Press Control+C to exit (container will keep running)."
echo "To stop: ./docker-run.sh --stop"
docker logs -f "${CONTAINER_NAME}"
