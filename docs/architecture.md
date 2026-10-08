# P40 AI Stack Architecture

## Hardware

- NVIDIA Tesla P40 24 GB
- Pascal
- Compute Capability 6.1
- CUDA 12.6

## Base image

`p40-ai-base:torch2.14-cu126`

### Contains

- PyTorch 2.14
- TorchVision
- TorchAudio
- xFormers
- Transformers
- Diffusers
- timm
- OpenCV
- Hugging Face libraries
- ONNX

## Persistent storage

### Application data

`/opt/ai`

### Models

`/opt/ai-models`

## Services

| Service | Port | Container |
|---|---:|---|
| ComfyUI | 8188 | comfyui |
| Open WebUI | 3000 | open-webui |
| Ollama | 11434 | ollama |
| Portainer | 9443 | portainer |

## Design principle

**Containers are disposable.**

Models and application data are persistent and stored outside containers. This allows:

- Quick container updates without losing data
- Shared models across multiple services
- Easy backup and recovery
- Container isolation while maintaining state
