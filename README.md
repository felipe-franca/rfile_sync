# rfile_sync.sh

## Description

The `rfile_sync.sh` is a shell script that facilitates file synchronization between a local directory and a remote Google Drive using the `rclone` utility. It supports two main operations:

- **push**: Synchronizes files from the local directory to Google Drive.
- **pull**: Synchronizes files from Google Drive to the local directory.

## Files

- `rfile_sync.sh`: Main script that manages the synchronization operations.
- `config.conf`: Configuration file that defines the target local path (`TARGET_PATH`).
- `push.sh`: Auxiliary script that performs the 'copy' operation to Google Drive using `rclone`.
- `pull.sh`: Auxiliary script that performs the 'copy' operation from Google Drive to the local directory using `rclone`.

## Usage

Execute the main script with the desired operation:

```bash
# To push local files to Google Drive
./rfile_sync.sh push

# To pull files from Google Drive to local directory
./rfile_sync.sh pull
```

## Configuration
- `config.conf`: Defines the target local full path (`TARGET_PATH`).

```bash
# config.conf
TARGET_PATH="/home/ubuntu/Documents/Projects"
```

## Tips

- Ensure that the `config.conf` file is in the same directory as the `rfile_sync.sh` script.
- Make sure to have the `rclone` utility installed and configured for the desired Google Drive account.
- You can use aliases to simplify the usage:
  - `rsync push`: `./rfile_sync.sh push`
  - `rsync pull`: `./rfile_sync.sh pull`