#!/bin/sh

source ./docker-env.sh

$VBOX_MANAGE controlvm dev natpf1 "couchbase-admin,tcp,127.0.0.1,8091,,8091"
$VBOX_MANAGE controlvm dev natpf1 "couchbase-srv-0,tcp,127.0.0.1,8092,,8092"
$VBOX_MANAGE controlvm dev natpf1 "couchbase-srv-4,tcp,127.0.0.1,8093,,8093"
$VBOX_MANAGE controlvm dev natpf1 "couchbase-srv-3,tcp,127.0.0.1,11207,,11207"
$VBOX_MANAGE controlvm dev natpf1 "couchbase-srv-1,tcp,127.0.0.1,11210,,11210"
$VBOX_MANAGE controlvm dev natpf1 "couchbase-srv-2,tcp,127.0.0.1,11211,,11211"

$VBOX_MANAGE controlvm dev natpf1 "docker-ui,tcp,127.0.0.1,9000,,9000"

$VBOX_MANAGE controlvm dev natpf1 "cbserver,tcp,127.0.0.1,8080,,8080"

exit 0
