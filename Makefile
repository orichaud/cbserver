all: clean build run test

run:
	- ./clean.sh
	- ./setup.sh
	- ./run-couchbase.sh
	- ./run-docker-img.sh

test:
	- ./test.sh

build:
	- ./build-docker-img.sh

clean:
	- ./clean.sh
