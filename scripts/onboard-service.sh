#!/bin/bash

# Setup variables use for the arguments.  

KEPTN_PROJECT=demo
KEPTN_SERVICE=casdemoapp
KEPTN_STAGE=production
KEPTN_SHIPYARD_FILE=keptn/shipyard.yaml
DT_CONF_FILE=keptn/dynatrace.conf.yaml

# Create project
keptn create project $KEPTN_PROJECT --shipyard=$KEPTN_SHIPYARD_FILE

# Validate that project was created
sleep 5
if keptn get project $KEPTN_PROJECT | grep -q "No project"; then
  echo "Create Project failed. Aborting creation of project"
  exit 1
fi 

# Create service within the project
keptn create service $KEPTN_SERVICE --project=$KEPTN_PROJECT

# Validate that service was created
sleep 5
if ! keptn get service --project=$KEPTN_PROJECT | grep -q $KEPTN_SERVICE; then
  echo "Create Service failed. Aborting creation of project"
  exit 1
fi 

# Configure the service to use a Dynatrace dashboard query for SLOs
keptn add-resource --project=$KEPTN_PROJECT --stage=$KEPTN_STAGE --service=$KEPTN_SERVICE --resource=$DT_CONF_FILE --resourceUri=dynatrace/dynatrace.conf.yaml
