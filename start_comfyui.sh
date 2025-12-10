#!/bin/bash

if [ -f env ]; then
  set -a
  source ./env
  set +a
fi

# ComfyUIのコンテナを実行
# WSL2起動時に実行すればOK
podman container run -d --replace \
  --name comfyui-runpod \
  -p 8188:8188 \
  -p 8888:8888 \
  --volume "$(pwd)/data:/workspace/data" \
  --volume "$(pwd)/output:/workspace/output" \
  --device "nvidia.com/gpu=all" \
  localhost/comfyui-runpod:${COMFYUI_TAG}

podman container logs -f comfyui-runpod
