#!/bin/sh

source docker-env.sh

IMGNAME=cbserver
IMGVERSION=latest
NAME=cbserver

eval "$(docker-machine env $MACHINE_NAME)"

$DOCKER run -it --rm --name $NAME $IMGNAME:$IMGVERSION

#--couchbase=172.17.0.3

exit 0
