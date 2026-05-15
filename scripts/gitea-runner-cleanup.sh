#!/bin/bash

# Runner Container entfernen
docker ps -aq \
  --filter label=gitea.runner.job=true \
  | xargs -r docker rm -f

# Runner Netzwerke entfernen
docker network ls -q \
  --filter label=gitea.runner.job=true \
  | xargs -r docker network rm

# Ungenutzte Images entfernen,
# aber NUR dangling Layer
docker image prune -f

# Ungenutzte Build Cache Layer
docker builder prune -af --filter "until=24h"



# Benutzung:
# 0 4 * * * /opt/gitea-runner/cleanup.sh >> /var/log/gitea-runner-cleanup.log 2>&1  # Pfad muss angepasst werden