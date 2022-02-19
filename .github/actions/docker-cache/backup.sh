#!/usr/bin/env bash

set -euo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local full_path_to_cache_tar=$1
  local cache_tar; cache_tar=$(basename "$full_path_to_cache_tar")
  local cache_dir; cache_dir=$(dirname "$full_path_to_cache_tar")

  mkdir -p "$cache_dir"
  rm -f "$full_path_to_cache_tar"

  timing docker run \
    --rm \
    --volumes-from buildx_buildkit_builder0 \
    -v "$cache_dir":/backup \
    alpine tar cvf "/backup/$cache_tar" /var/lib/buildkit
  sudo chown "$USER:$(id -g -n "$USER")" "$full_path_to_cache_tar"
  ls -lh "$full_path_to_cache_tar"
}

main "$@"
