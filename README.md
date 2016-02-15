# Git
* [https://github.com/orichaud/cbserver](https://github.com/orichaud/cbserver)

# Node.js modules

Commander is needed to parse arguments and the Express framework to build a simple ReST application:
```sh
npm -g install commander express
```
Couchbase SDK:
```sh
npm -g install couchbase
```

Environment for node (optional):
```sh
export NODE_PATH=/usr/local/lib:/usr/local/lib/node_modules
```



# Docker support

## Preparation

Check the docker machine is running:
```sh
16:28 orichaud@ahpmcproexp ~/Amadeus/dev/cbjs% docker-machine ls     
NAME   ACTIVE   URL          STATE     URL   SWARM   DOCKER    ERRORS
dev    -        virtualbox   Stopped                 Unknown   
```

if the docker machine is not running:
```sh
docker-machine start dev
```

if the docker machine is not created, use the script and upgrade the VM if need be:
```sh
./build-docker-vm.#!/bin/sh
docker-machine upgrade dev
```

Then check and update the environment:
```sh
docker-machine env dev
eval "$(docker-machine env dev)"
```

## Docker supervision
With `DockerUI` you can manage with a web interface the containers:
```sh
docker run -d -p 9000:9000 --privileged -v /var/run/docker.sock:/var/run/docker.sock --name DockerUI dockerui/dockerui
```
The web us is accessible at: [http://localhost:9000](http://localhost:9000)


## Deployment of Couchbase

Run the couchbase server with the shell script provided, running couchbase into containers with 3 containers and persistent volumes. The script create the date storage into sub directories.
```sh
./run-couchbase.sh
```
Note: [Useful link for couchbase containerization](http://developer.couchbase.com/documentation/server/4.0/install/docker-singlehost-miltiplecont.html)

The cluster will have to be set up via the Admin UI at [http://localhost:8091](http://localhost:8091).
To find the IP address of the nodes to be added to the cluster, run `docker ps` and then add node 2 and node 3. The nod e1 is the node which exposes the port 8091. To get the IP:
```sh
docker inspect --format '{{ .NetworkSettings.IPAddress }}' <ID of node>
```
The IP address will be passed to the couchbase cluster wizard.
Once the servers are added as nodes of the couchbase cluster, request a full rebalance of the cluster. 3 actives servers must then be available.

## Containerization of node.js application
The base image is based on the node image: [https://hub.docker.com/_/node/](https://hub.docker.com/_/node/)

The docker file is `Dockerfile` in the root dir. To build the image"
```sh
./build-docker-img.sh
```
The build assumes there exists a `package.json` file which lists all the dependencies.

## CB Server
The `cbserver` is built with the `build-docker-img.sh` sheel script.
By defaut, the server run on port `8080`and can be accessed at [http://localhost:8080](http://localhost:8080]).
The server tries connecting to the a Couchbase cluster at `127.0.0.1`. Option `--couchbase` allows changing the IP address.

## Port NATing

On MacOS, ports need to be open:
```sh
./open-ports.sh
```

# Others

## Editor

### Atom
Install `language-docker`
```sh
apm install language-docker
```
