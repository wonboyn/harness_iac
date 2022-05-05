#!/bin/bash

# Update yum
echo "Updating yum..." > /tmp/user_data.log
sudo yum update -y >> /tmp/user_data.log

# Install Docker
echo "" >> /tmp/user_data.log
echo "Installing Docker..." >> /tmp/user_data.log
sudo amazon-linux-extras install docker >> /tmp/user_data.log

# Start Docker Service
echo "" >> /tmp/user_data.log
echo "Starting Docker..." >> /tmp/user_data.log
sudo service docker start >> /tmp/user_data.log

# Configure Docker
echo "" >> /tmp/user_data.log
echo "Configuring Docker..." >> /tmp/user_data.log
sudo usermod -a -G docker ec2-user >> /tmp/user_data.log
sudo chkconfig docker on >> /tmp/user_data.log

# Install Docker Compose
echo "" >> /tmp/user_data.log
echo "Installing Docker Compose..." >> /tmp/user_data.log
sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Rebooting ec2
echo "" >> /tmp/user_data.log
echo "Rebooting..." >> /tmp/user_data.log
sudo reboot
