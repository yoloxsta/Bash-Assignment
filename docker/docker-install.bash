#!/bin/bash

set -e

# Update package index and install required dependencies
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add the current user to the 'docker' group
sudo usermod -aG docker $USER

# Inform the user to log out and log back in
echo ""
echo "====================================================="
echo " Docker installation completed."
echo "IMPORTANT: You must log out and log back in, OR run:"
echo "   newgrp docker"
echo "   ...to apply Docker group changes without sudo."
echo "====================================================="
echo ""

# Print Docker version
docker --version || echo "Run the above command after re-login to test 'docker ps' without sudo."
