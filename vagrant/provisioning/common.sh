#! /bin/bash
#
# Provisioning script common for all servers

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
# TODO: put all variable definitions here. Tip: make them readonly if possible.

#------------------------------------------------------------------------------
# Provisioning tasks
#------------------------------------------------------------------------------

log 'Starting common provisioning tasks'


log 'Install EPEL repository and some additional packages'
# Install baseline packages
dnf install --assumeyes \
  epel-release \
  yum-utils \
  git \
  wget \


log 'Add Docker repository and install Docker on the server'
# Add Docker repository using yum-config-manager
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
dnf install --assumeyes \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-compose-plugin

log 'Add vagrant user to the Docker group'
# Ensure Vagrant user is added to the Docker group  
usermod -aG docker vagrant


log 'Enable and start Docker'
# Enable and start Docker
systemctl enable --now docker
systemctl start docker