#!/bin/bash

# Log start of backup
echo -e "[$(date +%x-%X)] Backup starting" | tee -a "/var/log/backup-my-pi-$(date +%Y-%m-%d)".log

# Stop Docker for consistency
echo -e "[$(date +%x-%X)] Stoping Docker containers"
cd /home/pi/docker
docker compose stop

# Set folders
BACKUP_DIR="/mnt/backup"
DOCKER_BACKUP_DIR="$BACKUP_DIR/docker/$(date +%Y_%m_%d)"
APP_BACKUP_DIR="$BACKUP_DIR/applications/$(date +%Y_%m_%d)"
CRON_BACKUP_DIR="$BACKUP_DIR/crontab/$(date +%Y_%m_%d)"

# Create folders
mkdir -p "${DOCKER_BACKUP_DIR}"
mkdir -p "${APP_BACKUP_DIR}"
mkdir -p "${CRON_BACKUP_DIR}"
mkdir -p "${APP_BACKUP_DIR}/etc/raspotify"
mkdir -p "${APP_BACKUP_DIR}/var/spool/cron/crontabs"

# Backup Docker 
echo -e "[$(date +%x-%X)] Starting Docker backup"
cp -aR /home/pi/docker/* ${DOCKER_BACKUP_DIR}
tar -zcf "${DOCKER_BACKUP_DIR}/docker_$(date '+%Y_%m_%d').tar.gz" /home/pi/docker/
chmod -R 775 "${DOCKER_BACKUP_DIR}"

# Backup raspotify
echo -e "[$(date +%x-%X)] Starting raspotify backup"
cp -aR /etc/raspotify/* "${APP_BACKUP_DIR}/etc/raspotify"
tar -zcf "${APP_BACKUP_DIR}/raspotify_$(date '+%Y_%m_%d').tar.gz" /etc/raspotify/
chmod -R 775 "${APP_BACKUP_DIR}"

# Backup crontab
echo -e "[$(date +%x-%X)] Starting crontab backup"
cp -aR /var/spool/cron/crontabs/* "${CRON_BACKUP_DIR}/var/spool/cron/crontabs"
tar -zcf "${CRON_BACKUP_DIR}/crontabs_$(date '+%Y_%m_%d').tar.gz" /var/spool/cron/crontabs/ 
chmod -R 775 "${CRON_BACKUP_DIR}"

# Delete backups older than 7 days
echo -e "[$(date +%x-%X)] Delete old backups"
find /mnt/backup/docker/* -ctime +6 -exec rm -rf {} \;
find /mnt/backup/applications/* -ctime +6 -exec rm -rf {} \;
find /mnt/backup/crontabs/* -ctime +6 -exec rm -rf {} \;

# Start Docker for consistency
echo -e "[$(date +%x-%X)] Starting Docker containers"
cd /home/pi/docker
docker compose up -d

# Remove old logs
find /var/log/backup-my-pi* -type f -mtime +7 -exec rm -f {} \;

# Log end of backup
echo -e "[$(date +%x-%X)] Backup finished" | tee -a "/var/log/backup-my-pi-$(date +%Y-%m-%d)".log