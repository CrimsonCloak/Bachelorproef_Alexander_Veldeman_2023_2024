#! /bin/bash

docker exec jenkins -u root curl -1sLf 'https://dl.cloudsmith.io/public/infisical/infisical-cli/setup.deb.sh' | sudo -E  bash
docker exec jenkins -u root apt-get update
docker exec jenkins -u root apt-get install infisical