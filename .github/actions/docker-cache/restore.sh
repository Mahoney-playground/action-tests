#!/usr/bin/env bash

set -euo pipefail
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

main "$@"
