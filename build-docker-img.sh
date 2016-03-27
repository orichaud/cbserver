#!/bin/sh

source ./docker-env.sh

$DOCKER build -t $IMGNAME:$IMGVERSION .

$DOCKER images

exit 0
