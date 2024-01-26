# My RPi setup
This is my learning project and something I do when I get all nostalgic about technology. It gives me something technical to work on and to continuosly develop my knowledge.

It is a project to run in containers my full home system. From ad-blocking (Pihole) to digital book library. To run it you'll need Raspberry 4 or 5. Anything older will not work as Mongo 4.1 is not supported on that architecture. Also, you'll need some Docker and Docker Compose knowledge. This application will require 4GB of RAM or more. 

Setup of applications mentioned here is out of the scope. Google them. Behind every application there is a large and vibrant community willing to help. And documentation is extensive. 

# Why Docker
It makes my life much easier. It makes management and updating of the application so much easier and effective. And it doesn't blot my RPi. Also, you can find "backup-my-pi.sh" script that will backup everything and makes restore on a new RPi a breeze.

# Applications
## Traefik
I hate accesing applications with dedicated ports. Traefik handles that. It proxies all HTTP/S traffic so everything is behind a domain. It can handle applications with prefixes but I like subdomains more than prefixes.
You'll notice that all neede ports are still exposed for each application. That's on purpose as this is a learning experiment so it's obvious what ports each application requires.

I love HAProxy and I've been using it for a long time. Traefik is my learning experiment. I know it cannot match HAProxy's performance and flexibility but I love to tackle new technologies. And proxy perfomance is not something I worry about on my home setup.

Traefik handles Let's Encrypt certificates for all public domains.

## PiHole
A network ad-blocker. It sinkholes DNS queries to ad systems. Love it.
## no-ip2 and Cloudflare-DDNS
Dynamic DNS records management. I use no-ip2 for DDNS. But also I have my domain which is managed on Cloudflare. So I utilize Cloudflare API to update DNS records for my RPi domain as DDNS.
## Heimdall
One, beautiful, interface to access all my applications.
## Unifi controller
As I have Ubiquity devices in my home network a Unifi controller is a must for me. Unifi controller is not handled by Traefik. Unifi is finicky with reverse proxies. I did manage to get it running but I cannot fully explain all the settings yet so I haven't included that setup. MongoDB is included.
## Nextcloud
Personal file cloud. MySQL and Redis setup is included.
## FTPS
FTP server
## Samba
Samba server
## miniDLNA
DLNA server
## Plex
Plex media server. I had to disable transcoding as RPi was struggling. But it handles steaming to my TV just fine
## Readarr, LazyLibrarian, Calibre, Calibre-web
There are multiple application for eBook library management. Choose one that you like most. 
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
This is a backup script to backup docker compose file, all environment settings files and folders that are mounted for configuration to each container. You'll notice that there is a copy and tar used for backup of the files. I use copied files for fast restore and tar files for long term backup to external USB drive. Use one that you like most.

# update-my-pi.sh
This is my script to update RPi and also all containers. You'll notice I am using "down" to stop and remove all containers. That is on purpose as I had some issues with updating when old continers were not removed. It might have been something temporary but it does not hurt.

# What's next
## Traefik TCP and UDP
Currently Traefik only handles HTTP/S traffic. I plan to move all traffic (TCP and UDP) to Traefik.
## Traefik health checks
I have started to play around with traefik service health checks. I'll add that soon
## Container health checks
Some of the container have a health checks included but not all of them. That I plan to add so they can revover and alert me when they fail
## Prometheus, alertmanager, Grafana
I would love to have a dashboard for monitoring all of the services and RPi. Also to have alertign when something goes wrong. So most likely this will follow soon.
## Home Assistant
I am looking into home automation for some time now. That might be next.
## raspotify
raspotify is not in docker container. raspotify is is Spotify Connect client. It requires low level access to HDMI port. Currently it's installed on my RPi. Some had success running it in container but I haven't yet got to that.
## Kubernetes
I might move this whole project to K0s or K3s. But that will be a new git repo.
## build-my-pi.sh
Something I am working on. This bash script is meant to build RPi from scratch to full operating mode. I do not have a spare RPi 4 to test it and don't feel like building everyting from scratch :)