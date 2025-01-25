#!/bin/bash

# Omada Controller installation script for Debian
omada_url="https://static.tp-link.com/upload/software/2024/202412/20241224/Omada_SDN_Controller_v5.15.6.7_linux_x64.tar.gz"

# Extract the filename without the extension
omada_filename=$(basename $omada_url .tar.gz)

# Add mongodb repository
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-4.4.gpg
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg] https://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# Install dependencies
apt install -y wget curl gnupg gpg openjdk-17-jre-headless jsvc mongodb-org
      
if [ -f libssl1.1_1.1.1w-0+deb11u2_amd64.deb ]; then
  dpkg -i libssl1.1_1.1.1w-0+deb11u2_amd64.deb
else
  echo "libssl1.1_1.1.1w-0+deb11u2_amd64.deb not found! Try downloading it from the Debian repository."
  wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.1w-0+deb11u2_amd64.deb
  if [ $? -ne 0 ]; then
    echo "Failed to download libssl1.1_1.1.1w-0+deb11u2_amd64.deb"
    exit 1
  fi
  dpkg -i libssl1.1_1.1.1w-0+deb11u2_amd64.deb
fi


          
sudo apt install -y ./Omada_SDN_Controller_v5.15.6.7_linux_x64.tar.gz

sudo systemctl start mongod

            sudo systemctl enable mongod

            tar -xvzf Omada_SDN_Controller_v5.15.6.7_linux_x64.tar.gz

            cd Omada_SDN_Controller_v5.15.6.7_linux_x64/
             sudo ./install.sh
wget $omada_url




