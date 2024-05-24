#! /bin/bash
#
# Provisioning script for integrations.sh

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

log "------------------------------------------------------------"
log "Installing Jenkins"    
log "------------------------------------------------------------"


log "Provision Jenkins docker-compose file"

# Ensure Jenkins directory exists
mkdir -p /home/vagrant/jenkins

# Provision Jenkins docker compose file

cp "${PROVISIONING_FILES}"jenkins/docker-compose.yml /home/vagrant/jenkins/docker-compose.yml

log "Starting Jenkins container"
# Start Jenkins container
docker compose -f /home/vagrant/jenkins/docker-compose.yml up -d

log "------------------------------------------------------------"
log "Installing Puppet"    
log "------------------------------------------------------------"

log "Provision Puppet docker-compose file"

# Ensure Puppet directory exists
mkdir -p /home/vagrant/puppet

# Provision Puppet docker compose file

cp "${PROVISIONING_FILES}"puppet/docker-compose.yml /home/vagrant/puppet/docker-compose.yml

log "Starting Puppet container"
docker compose -f /home/vagrant/puppet/docker-compose.yml up -d

log "------------------------------------------------------------"
log "Installing GitLab"    
log "------------------------------------------------------------"

log "Provision GitLab docker-compose file"

# Ensure GitLab directory exists
mkdir -p /home/vagrant/gitlab

# Provision GitLab docker compose file

cp "${PROVISIONING_FILES}"GitLab/docker-compose.yml /home/vagrant/gitlab/docker-compose.yml

log "Starting GitLab container"

# Start GitLab container
docker compose -f /home/vagrant/gitlab/docker-compose.yml up -d
