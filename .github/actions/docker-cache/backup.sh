#!/usr/bin/env bash

set -euo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local cache_tar=$1
  local cache_dir; cache_dir=$(dirname "$cache_tar")

  mkdir -p "$cache_dir"
  rm -f "$cache_tar"

  timing docker run \
    --rm \
    --volumes-from buildx_buildkit_builder0 \
    -v "$(pwd)":/backup \
    ubuntu tar cvf /backup/backup.tar /var/lib/buildkit
  sudo chown "$USER:$(id -g -n "$USER")" "$cache_tar"
  ls -lh "$cache_tar"
}

main "$@"
