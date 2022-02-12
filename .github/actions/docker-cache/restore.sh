#!/usr/bin/env bash

set -euo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local cache_tar=$1

  timing sudo service docker stop

  remove_docker_data

  if [[ -f "$cache_tar" ]]; then
    ls -lh "$cache_tar"
    sudo mkdir -p /var/lib/docker
    timing sudo tar -xf "$cache_tar" -C /var/lib/docker
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
