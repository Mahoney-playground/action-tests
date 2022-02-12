#!/usr/bin/env bash

set -exuo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local cache_dir=$1

  rm -rf "$cache_dir"
  mkdir -p "$(dirname "$cache_dir")"

  timing sudo service docker stop
  timing sudo mv /var/lib/docker "$cache_dir"
  sudo ls -lh "$cache_dir"
  sudo du -sh "$cache_dir"
}

main "$@"
