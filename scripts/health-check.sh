#!/usr/bin/env bash

set -u

echo "============================================================"
echo "P40 AI STACK HEALTH CHECK"
echo "============================================================"

echo
echo "Docker:"
docker --version

echo
echo "Containers:"
docker ps \
    --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo
echo "GPU:"
nvidia-smi

echo
echo "ComfyUI:"
if curl -fsS http://127.0.0.1:8188/system_stats >/dev/null 2>&1; then
    echo "OK"
else
    echo "NOT AVAILABLE"
fi

echo
echo "Ollama:"
if curl -fsS http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
    echo "OK"
else
    echo "NOT AVAILABLE"
fi

echo
echo "Open WebUI:"
if curl -fsS http://127.0.0.1:3000 >/dev/null 2>&1; then
    echo "OK"
else
    echo "NOT AVAILABLE"
fi

echo
echo "Portainer:"
if curl -kfsS https://127.0.0.1:9443 >/dev/null 2>&1; then
    echo "OK"
else
    echo "NOT AVAILABLE"
fi

echo
echo "============================================================"
