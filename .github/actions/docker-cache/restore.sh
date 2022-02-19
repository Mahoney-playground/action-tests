#!/usr/bin/env bash

set -euo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local cache_tar=$1

  if [[ -f "$cache_tar" ]]; then
    docker run --rm \
      --volumes-from buildx_buildkit_builder0 \
      -v "$(pwd)":/backup \
      ubuntu \
      bash -c "cd /var/lib/buildkit && tar xvf /backup/backup.tar --strip 1"
  fi
}

main "$@"
