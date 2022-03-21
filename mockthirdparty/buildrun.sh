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
    --env KEPTN_BASEURL=$KEPTN_BASEURL \
    --env KEPTN_API_TOKEN=$KEPTN_API_TOKEN \
    -p 8080:5000 \
    $IMAGE