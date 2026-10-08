# Models

All models are stored outside containers in persistent storage.

## Root directory

`/opt/ai-models`

## ComfyUI models

```
/opt/ai-models/
├── checkpoints/          # Model checkpoints
├── diffusion_models/     # Diffusion model files
├── vae/                  # VAE models
├── loras/                # LoRA adapters
├── controlnet/           # ControlNet models
├── clip/                 # CLIP models
├── text_encoders/        # Text encoder models
├── unet/                 # UNet models
└── upscalers/            # Upscaling models
```

## LLM models

```
/opt/ai-models/
├── llm/                  # Large language models
└── gguf/                 # GGUF format models
```

## Vision models

```
/opt/ai-models/
└── vision/               # Vision models
```

## Audio models

```
/opt/ai-models/
└── audio/                # Audio processing models
```

## Embeddings

```
/opt/ai-models/
└── embeddings/           # Embedding models
```

## Cache directories

```
/opt/ai-models/cache/
├── huggingface/          # Hugging Face model cache
│   └── hub/              # Hub cache
└── torch/                # PyTorch cache
```

## Important

**Do not commit model files to Git.**

Model files are large (GB-TB scale) and should not be tracked by Git. They are persistent and managed separately.
