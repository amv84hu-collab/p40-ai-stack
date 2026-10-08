# NVIDIA Tesla P40

## GPU Specifications

| Property | Value |
|---|---|
| GPU | Tesla P40 24 GB |
| Architecture | Pascal |
| Compute Capability | 6.1 |
| CUDA | 12.6 |
| Memory | 24 GB GDDR5 |

## PyTorch Configuration

PyTorch is custom-built for:

```
TORCH_CUDA_ARCH_LIST="6.1+PTX"
```

This ensures optimal performance on P40 hardware.

## xFormers

xFormers is built specifically for Pascal architecture.

### Limitations

- **Flash Attention is disabled** — not supported on Compute Capability 6.1
- Falls back to standard attention mechanisms
- Performance may be lower than newer architectures with Flash Attention

## Hardware Limitations

Do not assume compatibility with:

- **BF16 hardware acceleration** — Pascal does not support native BF16
- **Flash Attention** — requires Compute Capability >= 7.x
- **CUDA kernels requiring newer architectures** — may require Compute Capability >= 7.x
- **Software with minimum Compute Capability >= 7.x** — will not run

## Testing

Run GPU test:

```bash
./scripts/gpu-test.sh
```

This verifies:

- CUDA availability
- Correct GPU detection
- Compute Capability (must be 6.1)
- PyTorch functionality on GPU
- Basic inference with ResNet18

## Monitoring

Check GPU status:

```bash
nvidia-smi
```

Monitor during inference:

```bash
watch -n 1 nvidia-smi
```

## Performance Tips

1. **Use FP32 instead of BF16** — Pascal doesn't support BF16 hardware acceleration
2. **Avoid Flash Attention** — xFormers will automatically fall back to standard attention
3. **Monitor memory** — 24 GB is substantial but can fill quickly with large batch sizes
4. **Use mixed precision (FP32/FP16)** — supported and recommended for efficiency
5. **Profile your workload** — use `nvidia-smi` to monitor memory and utilization
