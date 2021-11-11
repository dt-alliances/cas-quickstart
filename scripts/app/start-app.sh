#!/bin/bash

APP_SCRIPTS_PATH="$(pwd)"

LOGFILE='/tmp/start-app.log'
START_TIME="$(date)"

rm $LOGFILE
touch $LOGFILE
chmod 666 $LOGFILE

START_TIME="$(date)"
echo "***** Init Log ***" | tee -a $LOGFILE
echo "START_TIME       : $START_TIME " | tee -a $LOGFILE
echo "APP_SCRIPTS_PATH : $APP_SCRIPTS_PATH" | tee -a $LOGFILE

$APP_SCRIPTS_PATH/stop-app.sh $SCRIPT_HOME | tee -a $LOGFILE

echo "***** Starting App ***" | tee -a $LOGFILE
docker-compose -f "$APP_SCRIPTS_PATH/docker-compose.yaml" up -d | tee -a $LOGFILE

echo "***** Sleeping 10 seconds to let application start ***" | tee -a $LOGFILE
sleep 10

echo "***** Getting docker processes ***" | tee -a $LOGFILE
docker ps | tee -a $LOGFILE

END_TIME="$(date)"
echo ""
echo "START_TIME: $START_TIME     END_TIME: $END_TIME" | tee -a $LOGFILE
echo ""