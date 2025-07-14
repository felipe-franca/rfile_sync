#!/usr/bin/bash

push() {
  local target_path="$1"
  local file_name="$2"

  echo -e "Syncing: [$file_name] in local [$target_path] to remote [$REMOTE_NAME:$file_name]"

  rclone copy "$target_path" "$REMOTE_NAME:$file_name" \
    --exclude "*.swp" \
    --exclude ".~*" \
    --exclude "*.tmp" -v || return 1
}
