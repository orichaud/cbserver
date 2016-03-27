all: clean setup build run

run:
	- ./run-couchbase.sh
	- ./run-docker-img.sh

setup:
	- ./setup.sh

test:
	- robot api.robot

build:
	- ./build-docker-img.sh

clean:
	- ./clean.sh
