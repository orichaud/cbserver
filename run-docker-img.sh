#!/bin/bash

source docker-env.sh

$DOCKER run -d -p 8080:8080 --name=$CONTAINER_NAME $IMGNAME
exit 0
