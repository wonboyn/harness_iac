#!/bin/bash

# Install Docker
sudo yum update -y > /tmp/user_data.log
sudo amazon-linux-extras install docker >> /tmp/user_data.log
