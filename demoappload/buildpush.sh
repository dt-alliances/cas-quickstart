#!/bin/bash

clear
REPOSITORY=$1

if [ -z "$REPOSITORY" ]
then
    REPOSITORY=dtdemos
fi

IMAGE=$REPOSITORY/casdemoappload:1.0.0

echo ""
echo "========================================================"
echo "Building images"
echo "========================================================"
docker build -t $IMAGE .

echo ""
echo "========================================================"
echo "Ready to push images ?"
echo "========================================================"
read -rsp "Press ctrl-c to abort. Press any key to continue"
docker push $IMAGE
