#!/bin/sh

source ./docker-env.sh

$DOCKER_MACHINE create \
    --driver $DRIVER \
    --engine-label type=$MACHINE_NAME \
    $MACHINE_NAME
$DOCKER_MACHINE ls $MACHINE_NAME

exit 0
