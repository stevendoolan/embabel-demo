#!/usr/bin/env bash
set -euo pipefail

IMAGE="stevendoolan/embabel-demo:latest"
PORT="48080"
CONTAINER_NAME="embabel-demo"

PULL=true
CONFIG_PROFILE=""

while [ $# -gt 0 ]; do
  case "$1" in
    --stop|-s)
      echo "Stopping ${CONTAINER_NAME}..."
      docker rm -f "${CONTAINER_NAME}" 2>/dev/null || echo "Container not running."
      exit 0
      ;;
    --logs|-l)
      echo "Following logs for ${CONTAINER_NAME}... Press Control+C to exit."
      docker logs -f "${CONTAINER_NAME}"
      exit 0
      ;;
    --run-only|-r)
      PULL=false
      ;;
    --anthropic)
      CONFIG_PROFILE="anthropic"
      ;;
    --openai)
      CONFIG_PROFILE="openai"
      ;;
    --ollama)
      CONFIG_PROFILE="ollama"
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 2
      ;;
  esac
  shift
done

if [ "$PULL" = true ]; then
  echo "Pulling ${IMAGE}..."
  docker pull "${IMAGE}"
fi

# Build docker run arguments
ARGS=("-p" "${PORT}:${PORT}" "--name" "${CONTAINER_NAME}")

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
if [ -n "$CONFIG_PROFILE" ]; then
  echo "Using config profile: ${CONFIG_PROFILE}"
  docker run -d "${ARGS[@]}" "${IMAGE}" \
    "--spring.config.additional-location=file:/app/config/${CONFIG_PROFILE}/"
else
  docker run -d "${ARGS[@]}" "${IMAGE}"
fi

echo "Following logs... Press Control+C to exit (container will keep running)."
echo "To stop: ./docker-run.sh --stop"
docker logs -f "${CONTAINER_NAME}"
