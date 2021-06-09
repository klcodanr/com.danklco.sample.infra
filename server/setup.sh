#!/bin/bash

OWNER=klcodanr
ARTIFACT_ID=com.danklco.sample.infra

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
apt-get install -y uidmap docker-compose
dockerd-rootless-setuptool.sh install

# Configure Docker
loginctl enable-linger ubuntu
service docker start
usermod -aG docker ubuntu

# Create SSH Key
cat /dev/zero | ssh-keygen -q -N ""
echo ""
echo "Add public key to GitHub:"
cat ~/.ssh/id_rsa.pub
read -rsp $'Press any key to continue...\n' -n1 key

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
cp /opt/${ARTIFACT_ID}/dockhostctr /etc/init.d
update-rc.d dockhostctl defaults

