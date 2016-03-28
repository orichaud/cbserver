SRC=server.js

all: clean setup build run

run:
	./run-couchbase.sh
	./run-docker-img.sh

setup:
	./setup.sh

test:
	robot api.robot

build: $(SRC)
	esvalidate $<
	./build-docker-img.sh

clean:
	./clean.sh
