#!/usr/bin/bash

sync_remote() {
  local target_path="$1"

  echo -e "Syncing target local [$target_path] to remote [$REMOTE_NAME:/]"

  rclone sync \
    --exclude "*.swp" \
    --exclude ".~*" \
    --exclude "*.tmp" \
    -Pv "$target_path" "$REMOTE_NAME:/" || return 1
}
