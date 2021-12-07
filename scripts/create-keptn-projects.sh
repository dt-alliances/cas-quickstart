#!/bin/bash

create_project() {

  KEPTN_PROJECT=$1
  KEPTN_SERVICE=$2
  KEPTN_STAGE=$3
  KEPTN_SHIPYARD_FILE=$4
  DT_CONF_FILE=$5

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

  if [ -z $DT_CONF_FILE ]; then
    echo "Skipping adding dynatrace.conf.yaml"
  else
    echo "Adding dynatrace.conf.yaml config used for Dynatrace dashboard query of SLOs"
    keptn add-resource --project=$KEPTN_PROJECT --stage=$KEPTN_STAGE --service=$KEPTN_SERVICE --resource=$DT_CONF_FILE --resourceUri=dynatrace/dynatrace.conf.yaml
  fi
}

echo "Creating demo project"
KEPTN_PROJECT=demo
KEPTN_SERVICE=casdemoapp
KEPTN_STAGE=production
KEPTN_SHIPYARD_FILE=keptn/shipyard.yaml
DT_CONF_FILE=keptn/dynatrace.conf.yaml
create_project $KEPTN_PROJECT $KEPTN_SERVICE $KEPTN_STAGE $KEPTN_SHIPYARD_FILE $DT_CONF_FILE