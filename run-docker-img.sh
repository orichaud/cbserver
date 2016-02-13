#!/bin/sh

source docker-env.sh

IMGNAME=cbserver
IMGVERSION=latest
NAME=cbserver

eval "$(docker-machine env $MACHINE_NAME)"

$DOCKER run -it --rm --name $NAME $IMGNAME:$IMGVERSION

exit 0
