#!/usr/bin/env bash

set -exuo pipefail
# shellcheck source=timing.sh
. "${BASH_SOURCE%/*}/timing.sh"

main() {
  local cache_dir=$1

  id

  timing sudo service docker stop
  fast_delete "$cache_dir"
  sudo mv -T /var/lib/docker "$cache_dir"
  sudo chown -R "$USER:$(id -g -n "$USER")" "$cache_dir"
  chmod -R u+r "$cache_dir"
  ls -lh "$cache_dir"
  du -sh "$cache_dir"
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
