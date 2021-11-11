#!/bin/bash

clear
REPOSITORY=$1
if [ -z "$REPOSITORY" ]
then
    REPOSITORY=dtdemos
fi

IMAGE=$REPOSITORY/casdemoapp:1.0.0

docker build -t $IMAGE .

echo ""
echo "========================================================"
echo "Ready to push images ?"
echo "========================================================"
read -rsp "Press ctrl-c to abort. Press any key to continue"

echo "Pushing $IMAGE"
docker push $IMAGE
