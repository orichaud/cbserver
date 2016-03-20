#!/bin/bash

source ./docker-env.sh

user=Administrator
password=password
cluster_ramsize=512
bucket_ramsize=384
nodes=2
replicas=2
bucket=buckor
bucket_port=11211
node_prefix=CB

COUCHBASE_CLI="docker run --rm --entrypoint=/opt/couchbase/bin/couchbase-cli couchbase/server"

rm -rf data
echo "Data directory cleaned up"

mkdir -p data/node0

$DOCKER run -d -v $(pwd)/data/node1:/opt/couchbase/var \
-p 11207:11207 -p 11210:11210 -p 11211:11211 -p 8091-8093:8091-8093 \
--name=$node_prefix-0 couchbase/server

ip_master=$($DOCKER inspect -f '{{ .NetworkSettings.IPAddress }}' $node_prefix-0)
echo "Master created: $ip_master"

for (( i=1; i <= nodes; i++ ))
do
    mkdir -p data/node$i

    $DOCKER run -d -v $(pwd)/data/node$id:/opt/couchbase/var --name $node_prefix-$i couchbase/server
    ip=$($DOCKER inspect -f '{{ .NetworkSettings.IPAddress }}' $node_prefix-$i)

    echo "New node [$node_prefix-$i] created: $ip"
done

sleep 30

$COUCHBASE_CLI cluster-init -c $ip_master:8091 \
--cluster-init-username=$user --cluster-init-password=$password --cluster-init-ramsize=$cluster_ramsize \
-u $user -p $password
echo "Cluster initialized"

sleep 10

$COUCHBASE_CLI bucket-create -c $ip_master:8091 \
--bucket=$bucket \
--bucket-type=couchbase \
--bucket-port=$bucket_port \
--bucket-ramsize=$bucket_ramsize \
--bucket-replica=$replicas \
--wait \
-u $user -p $password
echo "Bucket initialized"

for (( i=1; i <= nodes; i++ ))
do
    ip=$($DOCKER inspect -f '{{ .NetworkSettings.IPAddress }}' $node_prefix-$i)

    $COUCHBASE_CLI server-add -c $ip_master:8091 \
    --server-add=$ip:8091 --server-add-username=$user --server-add-password=$password \
    -u $user -p $password

    echo "Node [$node_prefix-$i] added to master at $ip_master"
done

$COUCHBASE_CLI rebalance -c $ip_master:8091 -u $user -p $password
echo "Couchbase cluster rebalanced"

echo "Couchbase cluster ready. Nodes available:"
$COUCHBASE_CLI server-list -c $ip_master:8091 -u $user -p $password
$COUCHBASE_CLI bucket-list -c $ip_master:8091 -u $user -p $password


echo "Cluster initialized"

exit 0
