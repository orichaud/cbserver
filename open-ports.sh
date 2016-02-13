#!/bin/sh

source ./docker-env.sh

$VBOX_MANAGE controlvm dev natpf1 "couchbase-admin,tcp,127.0.0.1,8091,,8091"
$VBOX_MANAGE controlvm dev natpf1 "couchbase-srv-0,tcp,127.0.0.1,8092,,8092"
$VBOX_MANAGE controlvm dev natpf1 "couchbase-srv-1,tcp,127.0.0.1,11210,,11210"
$VBOX_MANAGE controlvm dev natpf1 "couchbase-srv-2,tcp,127.0.0.1,11211,,11211"

$VBOX_MANAGE controlvm dev natpf1 "docker-ui,tcp,127.0.0.1,9000,,9000"

exit 0
