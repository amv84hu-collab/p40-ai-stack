FROM nvidia/cuda:12.6.3-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

ENV CUDA_HOME=/usr/local/cuda
ENV PATH=/usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/lib:$LD_LIBRARY_PATH

ENV TORCH_CUDA_ARCH_LIST="6.1+PTX"

# ============================================================
# SYSTEM PACKAGES
# ============================================================

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    git \
    git-lfs \
    wget \
    curl \
    ca-certificates \
    build-essential \
    cmake \
    ninja-build \
    pkg-config \
    ffmpeg \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgomp1 \
    libopenblas-dev \
    libsndfile1 \
    libsox-dev \
    sox \
    && rm -rf /var/lib/apt/lists/*

# ============================================================
# PYTHON VIRTUAL ENVIRONMENT
# ============================================================

RUN python3 -m venv /opt/venv

ENV PATH=/opt/venv/bin:$PATH

RUN pip install --no-cache-dir --upgrade \
    pip \
    setuptools \
    wheel \
    packaging

# ============================================================
# LOCAL P40 WHEELS
# ============================================================

COPY *.whl /wheels/

RUN pip install --no-cache-dir \
    /wheels/torch-*.whl \
    /wheels/torchvision-*.whl \
    /wheels/torchaudio-*.whl \
    /wheels/xformers-*.whl

# ============================================================
# AI / ML
# ============================================================

RUN pip install --no-cache-dir \
    transformers \
    accelerate \
    safetensors \
    huggingface_hub \
    tokenizers \
    sentencepiece \
    protobuf \
    einops \
    pyyaml \
    requests \
    tqdm \
    psutil

# ============================================================
# SCIENTIFIC / IMAGE PROCESSING
# ============================================================

RUN pip install --no-cache-dir \
    numpy \
    scipy \
    pandas \
    pillow \
    opencv-python-headless \
    imageio \
    imageio-ffmpeg

# ============================================================
# DIFFUSION / VISION
# ============================================================

RUN pip install --no-cache-dir \
    timm \
    torchmetrics \
    albumentations \
    diffusers \
    peft \
    datasets

RUN pip install --no-cache-dir \
    open-clip-torch \
    ftfy \
    regex

# ============================================================
# COMPUTER VISION
# ============================================================

RUN pip install --no-cache-dir \
    matplotlib \
    scikit-image \
    scikit-learn

# ============================================================
# ONNX
# ============================================================

RUN pip install --no-cache-dir \
    onnx \
    onnxruntime

# ============================================================
# SHARED MODEL CACHE
# ============================================================

ENV HF_HOME=/models/cache/huggingface
ENV HF_HUB_CACHE=/models/cache/huggingface/hub
ENV TRANSFORMERS_CACHE=/models/cache/huggingface
ENV TORCH_HOME=/models/cache/torch

RUN mkdir -p \
    /models \
    /models/cache/huggingface \
    /models/cache/huggingface/hub \
    /models/cache/torch

# ============================================================
# BUILD VERIFICATION
# ============================================================

RUN python - <<'PY'
import torch
import torchvision
import torchaudio
import xformers
import transformers
import diffusers
import timm
import cv2
import PIL

print("=" * 70)
print("P40 AI BASE IMAGE")
print("=" * 70)

print("PyTorch:      ", torch.__version__)
print("Torch CUDA:   ", torch.version.cuda)
print("TorchVision:  ", torchvision.__version__)
print("TorchAudio:   ", torchaudio.__version__)
print("xFormers:     ", xformers.__version__)
print("Transformers: ", transformers.__version__)
print("Diffusers:    ", diffusers.__version__)
print("timm:         ", timm.__version__)
print("OpenCV:       ", cv2.__version__)
print("Pillow:       ", PIL.__version__)

print("=" * 70)
PY

WORKDIR /workspace

CMD ["bash"]
