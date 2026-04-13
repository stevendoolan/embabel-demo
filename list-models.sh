#!/usr/bin/env sh
#
# List available models from an LLM provider API.
#
# Usage:
#   ./list-models.sh                  # default: anthropic
#   ./list-models.sh openai
#   ./list-models.sh ollama
#   ./list-models.sh anthropic

set -e

PROVIDER="${1:-anthropic}"

case "$PROVIDER" in
  openai)
    if [ -z "$OPENAI_API_KEY" ]; then
      echo "ERROR: OPENAI_API_KEY environment variable is not set." >&2
      exit 1
    fi
    if [ -z "$OPENAI_BASE_URL" ]; then
      echo "ERROR: OPENAI_BASE_URL environment variable is not set." >&2
      exit 1
    fi
    MODELS_URL="${OPENAI_BASE_URL}/models?api-version=2024-10-21"
    echo "Fetching models from ${MODELS_URL}..."
    curl -sS "$MODELS_URL" -H "api-key: ${OPENAI_API_KEY}" \
      | jq -r '.data[].id' | sort
    ;;

  anthropic)
    if [ -z "$ANTHROPIC_API_KEY" ]; then
      echo "ERROR: ANTHROPIC_API_KEY environment variable is not set." >&2
      exit 1
    fi
    if [ -z "$ANTHROPIC_BASE_URL" ]; then
      echo "ERROR: ANTHROPIC_BASE_URL environment variable is not set." >&2
      exit 1
    fi
    BASE_URL="$ANTHROPIC_BASE_URL"
    MODELS_URL="${BASE_URL}/v1/models"
    echo "Fetching models from ${MODELS_URL}..."
    curl -sS "$MODELS_URL" -H "Authorization: Bearer ${ANTHROPIC_API_KEY}" \
      | jq -r '.data[].id' | sort
    ;;

  ollama)
    MODELS_URL="http://localhost:11434/api/tags"
    echo "Fetching models from ${MODELS_URL}..."
    curl -sS "$MODELS_URL" | jq -r '.models[].name' | sort
    ;;

  *)
    echo "ERROR: Unknown provider '${PROVIDER}'. Valid values: openai, ollama, anthropic" >&2
    exit 1
    ;;
esac
