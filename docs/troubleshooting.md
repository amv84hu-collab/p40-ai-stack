# Troubleshooting

## GPU Issues

### Check GPU availability

```bash
nvidia-smi
```

Expected output:
- GPU listed
- Driver version shown
- Memory reported

### Test Docker GPU access

```bash
docker run --rm \
  --gpus all \
  nvidia/cuda:12.6.3-base-ubuntu22.04 \
  nvidia-smi
```

### Test PyTorch GPU

```bash
./scripts/gpu-test.sh
```

## PyTorch Issues

### Import errors

Run:

```bash
./scripts/gpu-test.sh
```

Looks for:
- Import failures
- CUDA availability
- Version mismatches

### CUDA version mismatch

Ensure driver supports CUDA 12.6:

```bash
nvidia-smi | grep "CUDA Version"
```

Must be 12.6 or higher.

## Container Issues

### Check container status

```bash
cd docker
docker compose ps
```

### View container logs

```bash
cd docker
docker compose logs -f
```

### View specific service logs

```bash
cd docker
docker compose logs -f comfyui
docker compose logs -f ollama
docker compose logs -f open-webui
```

### Restart containers

```bash
cd docker
docker compose restart
```

### Rebuild base image

If base image issues:

```bash
./scripts/build-base.sh
```

## Service Issues

### ComfyUI not responding

1. Check logs:
   ```bash
   cd docker
   docker compose logs -f comfyui
   ```

2. Test endpoint:
   ```bash
   curl http://127.0.0.1:8188/system_stats
   ```

3. Restart:
   ```bash
   cd docker
   docker compose restart comfyui
   ```

### Ollama not responding

1. Check logs:
   ```bash
   cd docker
   docker compose logs -f ollama
   ```

2. Test endpoint:
   ```bash
   curl http://127.0.0.1:11434/api/tags
   ```

3. Restart:
   ```bash
   cd docker
   docker compose restart ollama
   ```

### Open WebUI not connecting to Ollama

Verify Ollama is running:

```bash
cd docker
docker compose ps ollama
```

Check docker network:

```bash
docker network ls
docker network inspect p40-ai
```

## Disk Space Issues

### Check disk usage

```bash
df -h
```

### Check Docker usage

```bash
docker system df
```

### Check specific directories

```bash
du -sh /var/lib/docker
du -sh /var/lib/containerd
du -sh /opt/ai-models
```

### Safe cleanup

Remove unused Docker resources:

```bash
docker builder prune
```

More aggressive cleanup (unused containers, images, volumes):

```bash
docker builder prune -af
```

### Do NOT manually delete

Avoid manual deletion of:

```
/var/lib/containerd/io.containerd.metadata.v1.bolt/meta.db
```

This will corrupt container metadata.

## Memory Issues

### Check available memory

```bash
free -h
```

### Check container memory usage

```bash
docker stats
```

### Reduce memory pressure

1. Stop unused containers:
   ```bash
   cd docker
   docker compose down
   ```

2. Clean up docker:
   ```bash
   docker system prune
   ```

## Network Issues

### Check container network

```bash
docker network inspect p40-ai
```

### Test container connectivity

```bash
docker exec comfyui ping ollama
```

### Check port availability

```bash
netstat -tuln | grep -E '8188|3000|11434|9443'
```

## Environment Variables

### Load from .env

Ensure `.env` file exists and is properly formatted:

```bash
cat .env
```

### Override variables

```bash
export COMFYUI_PORT=8188
cd docker
docker compose up -d
```

## Health Check

Run comprehensive health check:

```bash
./scripts/health-check.sh
```

This verifies:
- Docker version
- All containers running
- GPU available
- All services responding
