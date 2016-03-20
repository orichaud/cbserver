#!/bin/sh

source docker-env.sh

IMGNAME=cbserver
IMGVERSION=latest
NAME=cbserver

eval "$(docker-machine env $MACHINE_NAME)"

#$DOCKER run -it --rm -p 127.0.0.1:8080:8080 --name=$NAME $IMGNAME:$IMGVERSION
$DOCKER run -d -p 8080:8080 --name=$NAME $IMGNAME:$IMGVERSION

#--couchbase=172.17.0.3

exit 0
