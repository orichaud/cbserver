#!/bin/sh

source ./docker-env.sh

$DOCKER network create -d bridge $NETWORK

$DOCKER run -d -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock \
--net=$NETWORK --name DockerUI dockerui/dockerui


exit 0
