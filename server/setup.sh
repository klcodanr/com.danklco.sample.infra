#!/bin/bash

OWNER=klcodanr
ARTIFACT_ID=com.danklco.sample.infra

# Update 
apt-get update

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh 
apt-get install -y uidmap docker-compose

# Configure Docker
usermod -aG docker ubuntu
service docker start

# Create SSH Key
cat /dev/zero | ssh-keygen -q -N ""
echo ""
echo "Add public key to GitHub:"
cat ~/.ssh/id_rsa.pub
read -rp $'Press any key to continue...\n' -n1 key

# Clone the server configuration
git clone git@github.com:${OWNER}/${ARTIFACT_ID}.git /opt/${ARTIFACT_ID}

# Make required directories
mkdir -p /opt/${ARTIFACT_ID}/compose/work/cache/cms
mkdir -p /opt/${ARTIFACT_ID}/compose/work/cache/web
mkdir -p /opt/${ARTIFACT_ID}/compose/work/data/cms
mkdir -p /opt/${ARTIFACT_ID}/compose/work/logs/cms
mkdir -p /opt/${ARTIFACT_ID}/compose/work/logs/web
mkdir -p /opt/${ARTIFACT_ID}/compose/work/secrets

# Setup Docker start script
ln -s /opt/${ARTIFACT_ID}/server/docker-compose-ctl /etc/init.d/docker-compose-ctl
update-rc.d docker-compose-ctl defaults

