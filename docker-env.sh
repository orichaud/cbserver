DOCKER_MACHINE=/usr/local/bin/docker-machine
DOCKER=/usr/local/bin/docker
DRIVER=virtualbox
MACHINE_NAME=dev

VBOX_MANAGE=/usr/local/bin/VBoxManage

IMGNAME=orichaud/cbserver
IMGVERSION=1.0
CONTAINER_NAME=cbserver

eval "$(docker-machine env $MACHINE_NAME)"
