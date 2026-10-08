#!/usr/bin/env bash

set -euo pipefail

MODELS_ROOT="${MODELS_ROOT:-/opt/ai-models}"

echo "Creating model storage: ${MODELS_ROOT}"

mkdir -p \
    "${MODELS_ROOT}/checkpoints" \
    "${MODELS_ROOT}/diffusion_models" \
    "${MODELS_ROOT}/vae" \
    "${MODELS_ROOT}/loras" \
    "${MODELS_ROOT}/controlnet" \
    "${MODELS_ROOT}/clip" \
    "${MODELS_ROOT}/text_encoders" \
    "${MODELS_ROOT}/unet" \
    "${MODELS_ROOT}/transformers" \
    "${MODELS_ROOT}/llm" \
    "${MODELS_ROOT}/embeddings" \
    "${MODELS_ROOT}/vision" \
    "${MODELS_ROOT}/audio" \
    "${MODELS_ROOT}/upscalers" \
    "${MODELS_ROOT}/gguf" \
    "${MODELS_ROOT}/cache/huggingface" \
    "${MODELS_ROOT}/cache/huggingface/hub" \
    "${MODELS_ROOT}/cache/torch"

echo
echo "Model storage:"
echo

find "${MODELS_ROOT}" -maxdepth 2 -type d | sort

echo
echo "Done."
