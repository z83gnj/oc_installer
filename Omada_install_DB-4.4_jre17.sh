#!/bin/bash

# URL for the latest version of the Omada Controller
omada_url="https://static.tp-link.com/upload/software/2025/202501/20250109/Omada_SDN_Controller_v5.15.8.2_linux_x64.deb"
omada_filename=$(basename $omada_url)

# Install dependencies
apt install -y wget curl gnupg gpg openjdk-17-jre-headless jsvc

# Install libssl1.1 --> needed for MongoDB v4.4
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

# Install MongoDB v4.4
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-4.4.gpg
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg] https://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
apt update
apt install -y mongodb-org
systemctl start mongod
systemctl enable mongod

# Install Omada Controller
wget $omada_url
chmod +x $omada_filename
dpkg -i $omada_filename