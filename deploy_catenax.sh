#
# Copyright (c) 2021-2022 T-Systems International GmbH (Catena-X Consortium)
#
# See the AUTHORS file(s) distributed with this work for additional
# information regarding authorship.
#
# See the LICENSE file(s) distributed with this work for
# additional information regarding license terms.
#

#
# Shell script to build & push images to ghcr.
#
# Prerequisites:
#   Windows, (git)-bash shell, java 11 (java) and maven (mvn) in the $PATH.
#
# Synposis:
#   ./deploy_catenax.sh
#
# Comments:
#

export DOCKER_PLATFORM=linux/amd64
docker compose build

echo "Please enter your credentials (username/personal access token) for github. See https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry"
docker login ghcr.io
docker push ghcr.io/catenax-ng/product-knowledge/data-plane-agent:0.0.1
docker push ghcr.io/catenax-ng/product-knowledge/control-plane:0.0.1
docker push ghcr.io/catenax-ng/product-knowledge/portal:0.0.1
