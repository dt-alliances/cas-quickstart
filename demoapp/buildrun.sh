#!/bin/bash

clear
REPOSITORY=$1
if [ -z "$REPOSITORY" ]
then
    REPOSITORY=dtdemos
fi

IMAGE=$REPOSITORY/casdemoapp:1.0.0

#docker build -t $IMAGE .

echo ""
echo "========================================================"
echo "Ready to run $IMAGE ?"
echo "========================================================"

read -rsp "Press ctrl-c to abort. Press any key to continue"
echo ""

docker run \
    --env FEATURE_NUMBER=1 \
    -p 8080:8080 \
    -it \
    $IMAGE