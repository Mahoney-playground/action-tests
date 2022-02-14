#!/bin/bash

set -euo pipefail

docker buildx build . \
  --platform linux/arm64/v8,linux/amd64
