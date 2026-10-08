# P40 AI Stack

Universal AI Docker stack optimized for NVIDIA Tesla P40 24 GB.

The project provides a reproducible environment for running AI applications on Tesla P40 using a custom PyTorch build compiled for CUDA 12.6 and Compute Capability 6.1.

---

## Hardware

GPU:

NVIDIA Tesla P40 24 GB

Architecture:

Pascal

Compute Capability:

6.1

CUDA:

12.6

---

## Core stack

The base image contains:

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

---

## Services

| Service | Port |
|---|---:|
| ComfyUI | 8188 |
| Open WebUI | 3000 |
| Ollama | 11434 |
| Portainer | 9443 |

---

## Requirements

- NVIDIA Tesla P40
- NVIDIA driver
- Docker
- Docker Compose
- NVIDIA Container Toolkit

Check GPU:

```bash
nvidia-smi
```

---

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/amv84hu-collab/p40-ai-stack.git
cd p40-ai-stack
```

### 2. Configure environment

```bash
cp .env.example .env
```

Edit `.env` if needed (optional).

### 3. Prepare model storage

```bash
./scripts/prepare-models.sh
```

### 4. Build base image

Ensure PyTorch wheels are available in `/opt/pytorch-p40/final-wheels/`:

```bash
./scripts/build-base.sh
```

### 5. Install and start

```bash
./scripts/install.sh
```

### 6. Check health

```bash
./scripts/health-check.sh
```

---

## Accessing services

Replace `SERVER_IP` with your server address:

- **ComfyUI**: http://SERVER_IP:8188
- **Open WebUI**: http://SERVER_IP:3000
- **Ollama API**: http://SERVER_IP:11434
- **Portainer**: https://SERVER_IP:9443

---

## Project structure

```
p40-ai-stack/
├── base-image/
│   ├── Dockerfile
│   └── README.md
├── docker/
│   └── compose.yml
├── scripts/
│   ├── build-base.sh
│   ├── gpu-test.sh
│   ├── health-check.sh
│   ├── install.sh
│   ├── prepare-models.sh
│   └── update.sh
├── configs/
│   ├── comfyui/
│   │   └── README.md
│   ├── open-webui/
│   │   └── README.md
│   └── ollama/
│       └── README.md
├── docs/
│   ├── architecture.md
│   ├── gpu.md
│   ├── models.md
│   └── troubleshooting.md
├── .env.example
├── .gitignore
└── README.md
```

---

## Persistent storage

### Application data

```
/opt/ai/
├── comfyui/
├── ollama/
├── open-webui/
└── portainer/
```

### Models

```
/opt/ai-models/
├── checkpoints/
├── diffusion_models/
├── vae/
├── loras/
├── controlnet/
├── clip/
├── text_encoders/
├── unet/
├── transformers/
├── llm/
├── embeddings/
├── vision/
├── audio/
├── upscalers/
├── gguf/
└── cache/
    ├── huggingface/
    └── torch/
```

---

## Documentation

- [Architecture](docs/architecture.md) - System design and components
- [GPU Setup](docs/gpu.md) - NVIDIA Tesla P40 configuration
- [Models](docs/models.md) - Model organization and storage
- [Troubleshooting](docs/troubleshooting.md) - Common issues and solutions

---

## Scripts

### prepare-models.sh

Creates model directory structure.

```bash
./scripts/prepare-models.sh
```

### build-base.sh

Builds the P40 AI base Docker image.

```bash
./scripts/build-base.sh
```

### gpu-test.sh

Tests GPU and PyTorch installation.

```bash
./scripts/gpu-test.sh
```

### install.sh

Complete setup and installation.

```bash
./scripts/install.sh
```

### health-check.sh

Verifies all services are running.

```bash
./scripts/health-check.sh
```

### update.sh

Updates project and containers.

```bash
./scripts/update.sh
```

---

## Managing containers

### Start

```bash
cd docker
docker compose up -d
```

### Stop

```bash
cd docker
docker compose down
```

### Logs

```bash
cd docker
docker compose logs -f
```

### Specific service

```bash
cd docker
docker compose logs -f comfyui
```

### Status

```bash
cd docker
docker compose ps
```

---

## Design principles

- **Containers are disposable** — application state is stored outside
- **Models are persistent** — stored in `/opt/ai-models` across container restarts
- **Reproducible** — version-pinned dependencies and custom PyTorch build
- **P40 optimized** — tailored for Pascal architecture and Compute Capability 6.1

---

## Limitations

Tesla P40 limitations:

- No BF16 hardware acceleration
- No Flash Attention support
- Some CUDA kernels may require Compute Capability >= 7.x
- Assumes Compute Capability 6.1 compatibility

See [GPU documentation](docs/gpu.md) for details.

---

## License

MIT License

---

## Support

For issues, see [Troubleshooting](docs/troubleshooting.md) or open an issue on GitHub.
