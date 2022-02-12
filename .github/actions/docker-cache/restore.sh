#!/usr/bin/env bash

set -euo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local cache_dir=$1

  timing sudo service docker stop

  remove_docker_data

  if [[ -d "$cache_dir" ]]; then
    timing sudo mv "$cache_dir" /var/lib/docker
  fi

  timing sudo service docker start
}

remove_docker_data() {
  # mv is c. 25 seconds faster than rm -rf here
  local old_docker; old_docker="$(mktemp -d --dry-run)"
  timing sudo mv /var/lib/docker "$old_docker"
  nohup rm -rf "$old_docker" </dev/null >/dev/null 2>&1 & disown
}

main "$@"
