#!/bin/bash

omada_url="https://static.tp-link.com/upload/software/2025/202501/20250109/Omada_SDN_Controller_v5.15.8.2_linux_x64.deb"

# Extract the filename without the extension
omada_filename=$(basename $omada_url)

mongodb_url="https://repo.mongodb.org/apt/debian/dists/bookworm/mongodb-org/8.0/main/binary-amd64/mongodb-org-server_8.0.4_amd64.deb"
mongodb_filename=$(basename $mongodb_url)


# Install dependencies
apt install -y wget curl gnupg gpg openjdk-17-jre-headless jsvc

# if [ -f libssl1.1_1.1.1w-0+deb11u2_amd64.deb ]; then
#   dpkg -i libssl1.1_1.1.1w-0+deb11u2_amd64.deb
# else
#   echo "libssl1.1_1.1.1w-0+deb11u2_amd64.deb not found! Try downloading it from the Debian repository."
#   wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.1w-0+deb11u2_amd64.deb
#   if [ $? -ne 0 ]; then
#     echo "Failed to download libssl1.1_1.1.1w-0+deb11u2_amd64.deb"
#     exit 1
#   fi
#   dpkg -i libssl1.1_1.1.1w-0+deb11u2_amd64.deb
# fi

# Add mongodb repository
# curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-4.4.gpg
# echo "deb [signed-by=/usr/share/keyrings/mongodb-server-4.4.gpg] https://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# # Install mongodb
# apt update
# apt install -y mongodb-org
wget $mongodb_url
chmod +x $mongodb_filename
dpkg -i $mongodb_filename
systemctl start mongod
systemctl enable mongod

wget $omada_url

chmod +x $omada_filename

dpkg -i $omada_filename

# tar -xvzf $omada_filename.tar.gz
# cd $omada_filename
# ./install.sh
