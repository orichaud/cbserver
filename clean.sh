#!/bin/bash

source ./docker-env.sh

containers=$(docker ps -a -q)
if [[ ! -z "$containers" ]]; then
    $DOCKER rm --force $containers
fi
$DOCKER rmi --force $IMGNAME:$IMGVERSION

exit 0
