#!/bin/bash

# URL for the latest version of the Omada Controller
omada_url="https://static.tp-link.com/upload/software/2025/202501/20250109/Omada_SDN_Controller_v5.15.8.2_linux_x64.deb"
omada_filename=$(basename $omada_url)

# URL for the MongoDB 7.0.16 package
mongodb_url="https://repo.mongodb.org/apt/debian/dists/bookworm/mongodb-org/7.0/main/binary-amd64/mongodb-org-server_7.0.16_amd64.deb"
mongodb_filename=$(basename $mongodb_url)

# Install dependencies
apt install -y wget curl openjdk-17-jre-headless jsvc

# Install mongodb
wget $mongodb_url
chmod +x $mongodb_filename
dpkg -i $mongodb_filename
systemctl start mongod
systemctl enable mongod

# Install Omada Controller
wget $omada_url
chmod +x $omada_filename
dpkg -i $omada_filename