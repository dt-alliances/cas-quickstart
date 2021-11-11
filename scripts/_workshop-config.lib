#!/bin/bash

CREDS_FILE=credentials.json
if [ -f "$CREDS_FILE" ]
then
    DT_BASEURL=$(cat $CREDS_FILE | jq -r '.DT_BASEURL')
    DT_API_TOKEN=$(cat $CREDS_FILE | jq -r '.DT_API_TOKEN')
else 
  echo "ABORT: CREDS_FILE: $CREDS_FILE not found"
  exit 1
fi

# generic add function
addConfig() {

  CONFIG_API_NAME=$1
  CONFIG_NAME=$2
  CONFIG_FILE=$3

  if ! [ -f "$CONFIG_FILE" ]; then
    echo "==================================================================================="
    echo "SKIPPING $CONFIG_API_NAME $CONFIG_NAME"
    echo "Missing $CONFIG_FILE file"
    exit
  fi

  echo "==================================================================================="
  echo "Checking if $CONFIG_API_NAME $CONFIG_NAME exists"

  if [ "$CONFIG_API_NAME" == "dashboards" ]; then
    # list stored in an array called dashboards[]
    DT_ID=$(curl -s -X GET \
      "$DT_BASEURL/api/config/v1/$CONFIG_API_NAME?Api-Token=$DT_API_TOKEN" \
      -H 'Content-Type: application/json' \
      -H 'cache-control: no-cache' \
      | jq -r '.dashboards[] | select(.name == "'${CONFIG_NAME}'") | .id')
  else
     # list stored in an array called values[]
    DT_ID=$(curl -s -X GET \
    "$DT_BASEURL/api/config/v1/$CONFIG_API_NAME?Api-Token=$DT_API_TOKEN" \
    -H 'Content-Type: application/json' \
    -H 'cache-control: no-cache' \
    | jq -r '.values[] | select(.name == "'${CONFIG_NAME}'") | .id')
  fi

  # if exists, then delete it
  if [ "$DT_ID" != "" ]
  then
    echo "Deleting $CONFIG_API_NAME $CONFIG_NAME (ID = $DT_ID)"
    curl -X DELETE \
    "$DT_BASEURL/api/config/v1/$CONFIG_API_NAME/$DT_ID?Api-Token=$DT_API_TOKEN" \
    -H 'Content-Type: application/json' \
    -H 'cache-control: no-cache'
    
    echo "Waiting 10 seconds to ensure $CONFIG_NAME is deleted"
    sleep 10
  else
    echo "$CONFIG_API_NAME $CONFIG_NAME does not exist"
  fi

  echo "Adding $CONFIG_API_NAME $CONFIG_NAME"
  DT_ID=$(curl -s -X POST \
    "$DT_BASEURL/api/config/v1/$CONFIG_API_NAME?Api-Token=$DT_API_TOKEN" \
    -H 'Content-Type: application/json' \
    -H 'cache-control: no-cache' \
    -d @$CONFIG_FILE \
    | jq -r '.id')
  echo "Created $CONFIG_NAME (ID=$DT_ID)"

}

deleteConfig() {

  CONFIG_API_NAME=${1}
  CONFIG_NAME=${2}

  echo "==================================================================================="
  echo "Checking if $CONFIG_API_NAME $CONFIG_NAME exists"
  if [ "$CONFIG_API_NAME" == "dashboards" ]; then
    # list stored in an array called dashboards[]
    DT_ID=$(curl -s -X GET \
      "$DT_BASEURL/api/config/v1/$CONFIG_API_NAME?Api-Token=$DT_API_TOKEN" \
      -H 'Content-Type: application/json' \
      -H 'cache-control: no-cache' \
      | jq -r '.dashboards[] | select(.name == "'${CONFIG_NAME}'") | .id' | head -1)
  else
    # list stored in an array called values[] - ONLY get the first one.  
    DT_ID=$(curl -s -X GET \
      "$DT_BASEURL/api/config/v1/$CONFIG_API_NAME?Api-Token=$DT_API_TOKEN" \
      -H 'Content-Type: application/json' \
      -H 'cache-control: no-cache' \
      | jq -r '.values[] | select(.name == "'${CONFIG_NAME}'") | .id' | head -1)
  fi

  # if exists, then delete it
  if [ "$DT_ID" != "" ];then
    echo "Deleting $CONFIG_API_NAME $CONFIG_NAME (ID = $DT_ID)"
    curl -X DELETE \
    "$DT_BASEURL/api/config/v1/$CONFIG_API_NAME/$DT_ID?Api-Token=$DT_API_TOKEN" \
    -H 'Content-Type: application/json' \
    -H 'cache-control: no-cache'
  else
    echo "$CONFIG_API_NAME $CONFIG_NAME does not exist"
  fi

}

# this function used to create the JSON files
# be sure to delete the 'metadata' and 'id' before using it in the add
getConfig() {

  CONFIG_API_NAME=${1}
  CONFIG_NAME=${2}

  echo "==================================================================================="
  echo "Getting $CONFIG_API_NAME $CONFIG_NAME"

  DT_ID=$(curl -s -X GET \
    "$DT_BASEURL/api/config/v1/$CONFIG_API_NAME?Api-Token=$DT_API_TOKEN" \
    -H 'Content-Type: application/json' \
    -H 'cache-control: no-cache' \
    | jq -r '.values[] | select(.name == "'${CONFIG_NAME}'") | .id')

  # if exists, then get it
  if [ "$DT_ID" != "" ]
  then
    curl -s -X GET \
        "$DT_BASEURL/api/config/v1/$CONFIG_API_NAME/$DT_ID?Api-Token=$DT_API_TOKEN" \
        -H 'Content-Type: application/json' \
        -H 'cache-control: no-cache'  \
        | jq -r '.'
  else
    echo "$CONFIG_API_NAME $CONFIG_NAME does not exist"
  fi
}

setServiceAnomalyDetection() {
  CONFIG_FILE=$1

  echo "==================================================================================="
  echo "Setting ServiceAnomalyDetection"

  curl -L -X PUT \
    "$DT_BASEURL/api/config/v1/anomalyDetection/services?Api-Token=$DT_API_TOKEN" \
    -H 'Content-Type: application/json' \
    -H 'cache-control: no-cache' \
    -d @$CONFIG_FILE
}

setFrequentIssueDetectionOff() {
  echo "==================================================================================="
  echo "Setting FrequentIssueDetection OFF"

  curl -L -X PUT \
    "$DT_BASEURL/api/config/v1/frequentIssueDetection?Api-Token=$DT_API_TOKEN" \
    -H 'Content-Type: application/json' \
    -H 'cache-control: no-cache' \
    --data-raw '{
        "frequentIssueDetectionApplicationEnabled": false,
        "frequentIssueDetectionServiceEnabled": false,
        "frequentIssueDetectionInfrastructureEnabled": false
    }'
}

setFrequentIssueDetectionOn() {
  echo "==================================================================================="
  echo "Setting FrequentIssueDetection ON"

  curl -L -X PUT \
    "$DT_BASEURL/api/config/v1/frequentIssueDetection?Api-Token=$DT_API_TOKEN" \
    -H 'Content-Type: application/json' \
    -H 'cache-control: no-cache' \
    --data-raw '{
        "frequentIssueDetectionApplicationEnabled": true,
        "frequentIssueDetectionServiceEnabled": true,
        "frequentIssueDetectionInfrastructureEnabled": true
    }'
}

