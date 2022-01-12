#!/bin/bash

APP_SCRIPTS_PATH="$(pwd)"

echo "*** Stopping App ***"
docker-compose -f "$APP_SCRIPTS_PATH/docker-compose.yaml" down

echo "***** Sleeping 10 seconds to let application stop ***" | tee -a $LOGFILE
sleep 10

#echo "***** Reclaiming space ***"
#docker system prune -a -f

echo "***** Getting docker processes ***"
docker ps

echo "*** Stopping App Done. ***"