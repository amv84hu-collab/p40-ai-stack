#!/usr/bin/env bash

set -euo pipefail

IMAGE_NAME="p40-ai-base:torch2.14-cu126"

echo "============================================================"
echo "P40 GPU TEST"
echo "============================================================"

docker run --rm \
    --gpus all \
    "${IMAGE_NAME}" \
    python -u -c '

import torch
import torchvision
import torchaudio
import xformers

print("=" * 70)
print("FINAL P40 AI BASE TEST")
print("=" * 70)

print("Torch:       ", torch.__version__)
print("CUDA:        ", torch.version.cuda)
print("TorchVision: ", torchvision.__version__)
print("TorchAudio:  ", torchaudio.__version__)
print("xFormers:    ", xformers.__version__)

assert torch.cuda.is_available(), "CUDA unavailable"

print("CUDA:        ", torch.cuda.is_available())
print("GPU:         ", torch.cuda.get_device_name(0))
print("CC:          ", torch.cuda.get_device_capability(0))

assert torch.cuda.get_device_capability(0) == (6, 1)

x = torch.randn(
    2,
    3,
    224,
    224,
    device="cuda"
)

model = torchvision.models.resnet18(
    weights=None
).cuda().eval()

with torch.no_grad():
    y = model(x)

torch.cuda.synchronize()

print("Input:       ", x.shape)
print("Output:      ", y.shape)

print("=" * 70)
print("P40 AI BASE: ALL OK")
print("=" * 70)
'
