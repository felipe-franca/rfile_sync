#!/usr/bin/bash

pull() {
  local target_path="$1";
  rclone copy -P Projects:/ "$target_path" -v || return 1;
}
