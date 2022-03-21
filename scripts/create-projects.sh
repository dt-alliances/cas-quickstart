#!/bin/bash

create_project() {

  KEPTN_PROJECT=$1
  KEPTN_SERVICE=$2
  KEPTN_STAGE=$3
  KEPTN_SHIPYARD_FILE=$4
  DT_CONF_FILE=$5

  echo "----------------------------------------"
  echo "Creating project: $KEPTN_PROJECT"
  echo "----------------------------------------"

  if keptn get project $KEPTN_PROJECT | grep -q "CREATION DATE"; then
    echo "$KEPTN_PROJECT already exists.  Skipping."
  else 

    command="keptn create project $KEPTN_PROJECT --shipyard=$KEPTN_SHIPYARD_FILE"
    echo "----------------------------------------"
    echo "Creating project"
    echo $command
    echo "----------------------------------------"
    $command

    # Validate that project was created
    sleep 5
    if keptn get project $KEPTN_PROJECT | grep -q "No project"; then
      echo "ABORT: Create Project failed."
      exit 1
    fi 

    # Create service within the project
    command="keptn create service $KEPTN_SERVICE --project=$KEPTN_PROJECT"
    echo "----------------------------------------"
    echo "Creating service"
    echo $command
    echo "----------------------------------------"
    $command

    # Validate that service was created
    sleep 5
    if ! keptn get service --project=$KEPTN_PROJECT | grep -q $KEPTN_SERVICE; then
      echo "ABORT: Create Service failed"
      exit 1
    fi 

    if [ -z $DT_CONF_FILE ]; then
      echo "----------------------------------------"
      echo "Skipping adding dynatrace.conf.yaml"
      echo "----------------------------------------"
    else
      command="keptn add-resource --project=$KEPTN_PROJECT --resource=$DT_CONF_FILE --resourceUri=dynatrace/dynatrace.conf.yaml"
      echo "----------------------------------------"
      echo "Adding dynatrace.conf.yaml config used for Dynatrace dashboard query of SLOs"
      echo $command
      echo "----------------------------------------"
      $command
    fi
    echo "----------------------------------------"
    echo "Complete create project: $KEPTN_PROJECT"
    echo "----------------------------------------"
  fi
}

##################################################################################
KEPTN_PROJECT=slo-demo
KEPTN_SERVICE=casdemoapp
KEPTN_STAGE=production
PROJECT_BASE_FOLDER=../projects/$KEPTN_PROJECT
KEPTN_SHIPYARD_FILE=$PROJECT_BASE_FOLDER/keptn/shipyard.yaml
DT_CONF_FILE=$PROJECT_BASE_FOLDER/keptn/dynatrace.conf.yaml
echo "##################################################################################"
create_project $KEPTN_PROJECT $KEPTN_SERVICE $KEPTN_STAGE $KEPTN_SHIPYARD_FILE $DT_CONF_FILE
echo ""

##################################################################################
KEPTN_PROJECT=incident-demo
KEPTN_SERVICE=casdemoapp
KEPTN_STAGE=production
PROJECT_BASE_FOLDER=../projects/$KEPTN_PROJECT
KEPTN_SHIPYARD_FILE=$PROJECT_BASE_FOLDER/keptn/shipyard.yaml
DT_CONF_FILE=$PROJECT_BASE_FOLDER/keptn/dynatrace.conf.yaml
echo "##################################################################################"
create_project $KEPTN_PROJECT $KEPTN_SERVICE $KEPTN_STAGE $KEPTN_SHIPYARD_FILE $DT_CONF_FILE
echo ""

##################################################################################
KEPTN_PROJECT=release-demo
KEPTN_SERVICE=casdemoapp
KEPTN_STAGE=production
PROJECT_BASE_FOLDER=../projects/$KEPTN_PROJECT
KEPTN_SHIPYARD_FILE=$PROJECT_BASE_FOLDER/keptn/shipyard.yaml
DT_CONF_FILE=$PROJECT_BASE_FOLDER/keptn/dynatrace.conf.yaml
echo "##################################################################################"
create_project $KEPTN_PROJECT $KEPTN_SERVICE $KEPTN_STAGE $KEPTN_SHIPYARD_FILE $DT_CONF_FILE
echo ""
echo "Done"