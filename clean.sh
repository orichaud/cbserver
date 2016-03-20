#!/bin/sh

source ./docker-env.sh

$DOCKER rm --force $(docker ps -a -q)
$DOCKER network rm cb-net

exit 0
