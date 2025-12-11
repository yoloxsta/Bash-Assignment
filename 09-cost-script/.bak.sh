#!/bin/bash

# Define the base backup directory and the S3 bucket URL
BASE_BACKUP_DIR="/var/opt/gitlab/backups"
S3_BUCKET_URL="s3://music-gitlab-backup/git"

# Create a directory named with the current date to store today's backups
TODAYS_DATE=$(date +"%Y-%m-%d")
TODAYS_BACKUP_DIR="$BASE_BACKUP_DIR/$TODAYS_DATE"
mkdir -p "$TODAYS_BACKUP_DIR"

# Backup the GitLab configuration files
cp /etc/gitlab/gitlab.rb "$TODAYS_BACKUP_DIR/gitlab.rb.backup"
cp /etc/gitlab/gitlab-secrets.json "$TODAYS_BACKUP_DIR/gitlab-secrets.json.backup"

# Spinner function to show progress while the backup is running
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\\'
    while kill -0 $pid 2>/dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\r"
    done
    printf "    \r"
}

# Export the BACKUP_DIR variable for the GitLab backup rake task
export BACKUP_DIR="$TODAYS_BACKUP_DIR"

# Perform the GitLab backup using the rake task and start spinner
gitlab-rake gitlab:backup:create &
backup_pid=$!
spinner $backup_pid

# Move the latest backup tar file into today's backup directory
cd "$BASE_BACKUP_DIR"
LATEST_BACKUP_FILE=$(ls -t *.tar | head -n1)
mv "$LATEST_BACKUP_FILE" "$TODAYS_BACKUP_DIR/"

# Upload the whole dated directory to S3, including the latest backup file
aws s3 cp "$TODAYS_BACKUP_DIR" "$S3_BUCKET_URL/$TODAYS_DATE/" --recursive

# Confirm upload
echo "Uploaded $LATEST_BACKUP_FILE to S3 bucket $S3_BUCKET_URL/$TODAYS_DATE/"
