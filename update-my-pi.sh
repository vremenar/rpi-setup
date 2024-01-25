#!/bin/bash

# Log start of update
echo "[$(date +%x-%X)] Update starting" | tee -a "/var/log/update-my-pi-$(date +%Y-%m-%d)".log

# Do system update
echo "[$(date +%x-%X)] System update starting"
apt update && apt upgrade -y
apt autoremove -y

# Do Docker images update
echo "[$(date +%x-%X)] Docker update starting"
cd /home/pi/docker
docker-compose pull
docker-compose down
docker-compose up -d
docker system prune -f

# Remove old logs
find /var/log/update-my-pi* -type f -mtime +7 -exec rm -f {} \;

# End
echo "[$(date +%x-%X)] Update finished" | tee -a "/var/log/update-my-pi-$(date +%Y-%m-%d)".log