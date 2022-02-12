#!/usr/bin/env bash

set -exuo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local cache_dir=$1

  timing sudo service docker stop

  fast_delete /var/lib/docker

  if [[ -d "$cache_dir" ]]; then
    timing sudo mv -T "$cache_dir" /var/lib/docker
    timing sudo chown -R root:root /var/lib/docker
  fi

  timing sudo service docker start
}

fast_delete() {
  local to_delete=$1

  if [ -d "$to_delete" ]; then
    # mv is c. 25 seconds faster than rm -rf here
    local temp_dir; temp_dir="$(mktemp -d --dry-run)"
    timing sudo mv "$to_delete" "$temp_dir"
    nohup rm -rf "$temp_dir" </dev/null >/dev/null 2>&1 & disown
  fi
}

main "$@"
