#!/usr/bin/env bash

set -euo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local cache_dir=$1

  timing sudo service docker stop

  fast_delete "$cache_dir"

  sudo mv -T /var/lib/docker "$cache_dir"
  sudo chown -R "$USER:$(id -g -n "$USER")" "$cache_dir"
  sudo chmod -R u+r "$cache_dir"

  ls -lh "$cache_dir"
  set +e
  du -sh "$cache_dir"
  set -e
}

main "$@"
