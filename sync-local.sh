#!/usr/bin/bash

sync_local() {
  local target_path="$1"

  echo -e "Syncing target local [$target_path] to remote [$REMOTE_NAME:/]"

  rclone sync -Pv "$REMOTE_NAME:/" "$target_path" || return 1
}
