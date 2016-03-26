#!/bin/sh

source docker-env.sh

IMGNAME=cbserver
IMGVERSION=latest
NAME=cbserver

eval "$(docker-machine env $MACHINE_NAME)"

$DOCKER run -d -p 8080:8080 --name=$NAME $IMGNAME:$IMGVERSION
exit 0
