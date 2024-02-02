# Release Notes
## v1.4 - Add Jellyfin
Added Jellyfin as an alternative to Plex. Both Plex and Jellyfin are included so you can choose the application which you prefer.
## v1.3 - Add Portainer
Added Portainer and Portainer agent enable GUI for Docker management. Also this is I use to be able to quickly fix issues with containers as I do not want to expose SSH.
## v1.2 - Add monitoring
Add Prometheus, Grafana, Node-exporter, cAdvisor, alertmanager. Raspberry Pi and Docker is monitoried. Enable Prometheus export for Traefik. Included some sample Grafana dashboards for Raspberry Pi, Docker and Traefik.

## v1.1 - Enable Traefik health monitoring
All services are monitoried with Traefik health monitoring

# My RPi setup
This is my learning project and something I do when I get all nostalgic about technology. It gives me something technical to work on and to continuously develop my knowledge.
It is a project to run in containers in my home system. From ad-blocking (Pihole) to the digital book library. To run it, you'll need a Raspberry 4 or 5. Anything older will not work, as Mongo 4.1 is not supported on that architecture. Also, you'll need some Docker and Docker Compose knowledge. This application will require 4GB of RAM or more.
The setup of the applications mentioned here is out of scope. Google them. Behind every application, there is a large and vibrant community willing to help. The documentation is extensive.
# Why Docker
It makes my life much easier. It makes management and updating of the application so much easier and more effective. And it doesn't blot my RPi. Also, you can find a "backup-my-pi.sh" script that will backup everything and make restoring a new RPi a breeze.
# Applications
## Traefik
I hate accessing applications with dedicated ports. Traefik handles that. It proxies all HTTP/S traffic, so everything is behind a domain. It can handle applications with prefixes, but I like subdomains more than prefixes. You'll notice that all needed ports are still exposed for each application. That's on purpose, as this is a learning experiment, so it's obvious what ports each application requires.
I love HAProxy, and I've been using it for a long time. Traefik is my learning experiment. I know it cannot match HAProxy's performance and flexibility, but I love to tackle new technologies. And proxy performance is not something I worry about in my home setup.
Traefik handles Let's Encrypt certificates for all public domains.
All services exposed through Traefik have configured health checks.
## Portainer
Portainer is a GUI for the management of Docker and part of the RPi.
Prometheus, Grafana, AlertManager, and cAdvisor
Enable monitoring of the health of Raspberry Pi, Docker containers, and Traefik. Some sample Grafana dashboards are included for Raspberry Pi, Docker, and Traefik metrics.
## PiHole
A network ad-blocker. It sinkholes the DNS queries of ad systems. Love it.
## no-ip2 and Cloudflare-DDNS
Dynamic DNS records management. I use no-ip2 for DDNS. But I also have my domain, which is managed on Cloudflare. So I utilize the Cloudflare API to update DNS records for my RPi domain as DDNS.
## Heimdall
One beautiful interface to access all my applications.
## Unifi controller
As I have Ubiquity devices on my home network, a Ubiquity controller is a must for me. The unifi controller is not handled by Traefik. Unifi is finicky with reverse proxies. I did manage to get it running, but I cannot fully explain all the settings yet, so I haven't included that setup. MongoDB is included.
## Nextcloud
Personal file cloud. MySQL and Redis setups are included.
## FTPS
FTP server
## Samba
Samba server
## miniDLNA
DLNA server
## Plex
Plex media server. I had to disable transcoding as RPi was struggling. But it handles steaming to my TV just fine
## Jellyfin
Jellyfin media server. An alternative to Plex if you prefer open source software.
## Readarr, LazyLibrarian, Calibre, Calibre-web
There are multiple applications for eBook library management. Choose one that you like most.
## Radarr
Movie library management
## Sonarr
TV shows library management
## Prowlarr
Indexer management
## Bazarr
Subtitles manager
## Transmission
Torrent client
# backup-my-pi.sh
This is a backup script to backup the Docker Compose file, all environment settings files, and folders that are mounted for configuration in each container. You'll notice that there is a copy and tar used for backup of the files. I use copied files for fast restore and tar files for long-term backup to an external USB drive. Use one that you like most.
# update-my-pi.sh
This is my script to update RPi and all containers. You'll notice I am using "down" to stop and remove all containers. That is on purpose, as I had some issues with updating when old continers were not removed. It might have been something temporary, but it does not hurt.
# What's next
## Traefik TCP and UDP
Currently, Traefik only handles HTTP/S traffic. I plan to move all traffic (TCP and UDP) to Traefik.
## Container health checks
Some of the containers have health checks included, but not all of them. That I plan to add so they can revover and alert me when they fail.
## Home Assistant
I have been looking into home automation for some time now. That might be next.
## raspotify
raspotify is not in the Docker container. Raspotify is a Spotify Connect client. It requires low-level access to the HDMI port. Currently, it's installed on my RPi. Some had success running it in containers, but I haven't yet gotten to that.
## Kubernetes
I might move this whole project to K0s or K3s. But that will be a new git repo.
## build-my-pi.sh
Something I am working on. This bash script is meant to build RPi from scratch to full operating mode. I do not have a spare RPi 4 to test it, and I don't feel like building everything from scratch.
