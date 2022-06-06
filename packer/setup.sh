#!/bin/bash

# Install Docker Compose
echo ""
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Install Docker
echo ""
echo "Installing Docker..."
sudo amazon-linux-extras install docker

# Start Docker Service
echo ""
echo "Starting Docker..."
sudo service docker start

# Configure Docker
echo ""
echo "Configuring Docker..."
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on
docker --version
