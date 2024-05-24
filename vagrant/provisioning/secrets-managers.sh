#! /bin/bash
#
# Provisioning script for ssecrets-managers

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

# Location of provisioning scripts and files
declare PROVISIONING_SCRIPTS="/vagrant/provisioning/"
# Location of files to be copied to this server
declare PROVISIONING_FILES="${PROVISIONING_SCRIPTS}files/"

#------------------------------------------------------------------------------
# "Imports"
#------------------------------------------------------------------------------

# Utility functions
source ${PROVISIONING_SCRIPTS}/util.sh
# Actions/settings common to all servers
source ${PROVISIONING_SCRIPTS}/common.sh

#------------------------------------------------------------------------------
# Provision server
#------------------------------------------------------------------------------

log "Starting server specific provisioning tasks on ${HOSTNAME}"


log "------------------------------------------------------------"
log "Installing Infisical"
log "------------------------------------------------------------"

# Create Infisical directory
log "Creating Infisical directory"
mkdir -p /home/vagrant/Infisical

# Provision docker-compose and .env file
log "Provisioning docker-compose and .env file"
cp "${PROVISIONING_FILES}"/Infisical/docker-compose.yml /home/vagrant/Infisical/docker-compose.yml
cp "${PROVISIONING_FILES}"/Infisical/.env-example /home/vagrant/Infisical/.env

# Start the Infisical container 
log "Starting Infisical container"

docker compose -f /home/vagrant/Infisical/docker-compose.yml up -d

log "------------------------------------------------------------"
log "Installing OpenBao"    
log "------------------------------------------------------------"

log "Clone OpenBao release RPM from GitHub"

# Clone OpenBao release RPM from GitHub
wget https://github.com/openbao/openbao/releases/download/v2.0.0-alpha20240329/openbao-2.0.0.alpha20240329-1.x86_64.rpm.zip

# Unzip OpenBao release RPM
unzip openbao-2.0.0.alpha20240329-1.x86_64.rpm.zip

# Install OpenBao release RPM
dnf install --assumeyes openbao-2.0.0~alpha20240329-1.x86_64.rpm

log "------------------------------------------------------------"
log "Installing CyberArk Conjur"    
log "------------------------------------------------------------"

# Ensure CyberArk Conjur directory exists
mkdir -p /home/vagrant/CyberArk

# Provision CyberArk Conjur docker-compose file
cp "${PROVISIONING_FILES}"CyberArk/docker-compose.yml /home/vagrant/CyberArk/docker-compose.yml

# Start CyberArk Conjur container
docker compose -f /home/vagrant/CyberArk/docker-compose.yml up -d

