#!/bin/bash

clear
HOSTNAME=$1
REPOSITORY=$2

if [ -z "$HOSTNAME" ]
then
    # default to host the docker image runs on
    HOSTNAME=172.17.0.1
fi

if [ -z "$REPOSITORY" ]
then
    REPOSITORY=dtdemos
fi

IMAGE=$REPOSITORY/casdemoappload:1.0.0

echo ""
echo "========================================================"
echo "Building $IMAGE"
echo "========================================================"
docker build -t $IMAGE .

echo ""
echo "========================================================"
echo "Ready to run $IMAGE ?"
echo "========================================================"
read -rsp "Press ctrl-c to abort. Press any key to continue"
echo ""
docker run \
    --env HOSTNAME=$HOSTNAME \
    --env SERVER_PORT=80 \
    --env NUM_LOOPS=1 \
    --env NUM_THREADS=1 \
    --env TEST_SCRIPT="/load.jmx" \
    --env THINK_TIME=250 \
    --env TEST_DEBUG=true \
    $IMAGE
