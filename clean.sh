#!/bin/sh

source ./docker-env.sh

$DOCKER rm --force $(docker ps -a -q)

exit 0
