all: clean setup build run

run:
	- ./run-couchbase.sh
	- ./run-docker-img.sh

setup:
	- ./setup.sh

test:
	- ./test.sh

build:
	- ./build-docker-img.sh

clean:
	- ./clean.sh
