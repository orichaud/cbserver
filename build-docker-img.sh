#!/bin/sh

source ./docker-env.sh

$DOCKER build -t $IMGNAME:$IMGVERSION -t $IMGNAME:latest .

nones=$($DOCKER images | grep "^<none>" | awk "{print $3}")
if [[ ! -z "$nones" ]]; then
    $($DOCKER rmi $nones)
fi

$DOCKER images

exit 0
