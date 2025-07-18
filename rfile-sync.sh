#!/usr/bin/bash

# -----------------------------------------------------------------------------
# File: rfile-sync.sh
# Description: Sync files from local to remote google-drive using rclone.
#
# Author: Felipe França<https://github.com/felipe-franca>
#
# Operations:
#   push         Upload local files to the cloud.
#   pull         Download files from the cloud to local.
#   sync-remote  Sync changes from local to the remote.
#   sync-local   Sync changes from remote to the local.
# -----------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/config.conf"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/push.sh"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/pull.sh"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/sync-remote.sh"

# shellcheck disable=SC1091
source "$SCRIPT_DIR/sync-local.sh"

handle_params() {
  if [ $# -ne 1 ]; then
    echo "Usage: <command> <push|pull|sync>" >&2

    return 1
  fi
}

main() {
  handle_params "$@" || exit 1

  local operation="$1"

  if [ "$operation" == "push" ]; then
    echo "Syncing files up to cloud..."

    echo -e "Target files to sync:\n$(ls -1 "$TARGET_PATH")\n"

    # Check if the directory has any files
    if [ -z "$(ls -A "$TARGET_PATH" 2>/dev/null)" ]; then
      echo "No files to sync in $TARGET_PATH."
      exit 0
    fi

    # Correctly iterate through files
    for file_path in "$TARGET_PATH"/*; do
      local target_name
      target_name="$(basename "$file_path")"

      echo "Validating \"$file_path\""

      if [ -e "$file_path" ]; then
        echo "Target $target_name validated with success!"
        if push "$file_path" "$target_name"; then
          echo "Synced: $target_name with success!"
        else
          echo "Failed to sync $target_name"
          continue
        fi
      else
        echo -e "File or folder [$target_name] does not exist"
      fi
    done
  elif [ "$operation" == "pull" ]; then
    if pull "$TARGET_PATH"; then
      echo "Synced with success!"
    else
      echo "Failed pulling files from cloud!"
    fi
  elif [ "$operation" == "sync-remote" ]; then
    if sync_remote "$TARGET_PATH"; then
      echo "Synced with success!"
    else
      echo "Failed to sync files to cloud!"
    fi
  elif [ "$operation" == "sync-local" ]; then
    if sync_local "$TARGET_PATH"; then
      echo "Synced with success!"
    else
      echo "Failed to sync files from cloud!"
    fi
  else
    echo "Invalid operation: \"$operation\""
    echo "Usage: <command> <push|pull|sync-remote|sync-local>" >&2
    exit 1
  fi

  exit 0
}

main "$@"
