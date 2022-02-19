#!/usr/bin/env bash

set -euo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local full_path_to_cache_tar=$1
  local cache_tar; cache_tar=$(basename "$full_path_to_cache_tar")

  if [[ -f "$full_path_to_cache_tar" ]]; then
    docker run --rm \
      --volumes-from buildx_buildkit_builder0 \
      -v "$(pwd)":/backup \
      alpine \
      sh -c "cd /var/lib/buildkit && tar xvf /backup/$cache_tar --strip 1"
  fi
}

main "$@"
