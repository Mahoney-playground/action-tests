#!/usr/bin/env bash

set -euo pipefail

docker run --rm --privileged tonistiigi/binfmt:qemu-v6.1.0-21 --install all

if ! docker buildx inspect builder > /dev/null 2>&1; then
  docker buildx create --use --name builder
  docker buildx install
fi
