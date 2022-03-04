#!/bin/bash

clear
REPOSITORY=$1

if [ -z "$REPOSITORY" ]
then
    REPOSITORY=dtdemos
fi

IMAGE=$REPOSITORY/mockthirdparty:1.0.0

echo ""
echo "========================================================"
echo "Building image $IMAGE"
echo "========================================================"
docker build -t $IMAGE .

echo ""
echo "========================================================"
echo "Ready to push image $IMAGE ?"
echo "========================================================"
read -rsp "Press ctrl-c to abort. Press any key to continue"
docker push $IMAGE
