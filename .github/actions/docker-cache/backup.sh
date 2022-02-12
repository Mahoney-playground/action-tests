#!/usr/bin/env bash

set -exuo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local cache_dir=$1

  whoami

  rm -rf "$cache_dir"
  mkdir -p "$(dirname "$cache_dir")"

  timing sudo service docker stop
  timing sudo mv /var/lib/docker "$cache_dir"
  timing sudo chown -R "$USER:$(id -g -n "$USER")" "$cache_dir"
  sudo ls -lh "$cache_dir"
  sudo ls -lh "$cache_dir/overlay2/"
  sudo du -sh "$cache_dir"
}

main "$@"
