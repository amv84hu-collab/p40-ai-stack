# P40 AI Base Image

Image:

`p40-ai-base:torch2.14-cu126`

CUDA:

12.6

GPU architecture:

Pascal / Compute Capability 6.1

## Required wheels

The following wheels must exist in:

`/opt/pytorch-p40/final-wheels/`

- `torch`
- `torchvision`
- `torchaudio`
- `xformers`

They are copied into this directory during the build.

Wheel files are intentionally excluded from Git.

## Build

From repository root:

```bash
./scripts/build-base.sh
```

## Test

```bash
./scripts/gpu-test.sh
```
