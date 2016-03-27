#!/bin/bash

source ./docker-env.sh

$DOCKER run -d -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock --name DockerUI dockerui/dockerui

exit 0
