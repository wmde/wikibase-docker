#!/bin/bash
#
# This is an example setup script that can be run
# This should work on a WMF labs debian jessie VM
# (as that is what I wrote it on)
# Enjoy!

################################################################
##################    Install Docker CE   ######################
################################################################

# Update the apt package index:
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install --yes \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -

# Add Docker's stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

# Update the apt package index:
sudo apt-get update

# Install the latest version of Docker CE
sudo apt-get --yes install docker-ce

# Run Hellow World
sudo docker run hello-world

################################################################
##############    Install Docker Compose    ####################
################################################################

# Install pip
sudo apt-get install --yes \
     python-pip

# Install docker-composer using pip
sudo pip install docker-compose

################################################################
###############    Clone wikibase-docker    ####################
################################################################

# Install git
sudo apt-get install --yes \
     git

# Clone the repo
git clone https://github.com/wmde/wikibase-docker.git

# Switch to the wikibase-docker directory
cd wikibase-docker/

################################################################
######################    Run It!    ###########################
################################################################

# Pull the images from docker hub
sudo docker-compose pull

# Run the services
sudo docker-compose up --no-build -d
