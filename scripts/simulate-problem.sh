#!/bin/bash

source ./_workshop-config.lib

# Usage   ./simulate-problem.sh {PROBLEM MESSAGE} {EVENT TYPE}
# Example ./simulate-problem.sh "Critical Performance Issue" PERFORMANCE_EVENT

# Reference https://www.dynatrace.com/support/help/dynatrace-api/environment-api/events-v2/post-event

PROBLEM_TITLE=$1
if [[ -z "$PROBLEM_TITLE" ]]; then
  PROBLEM_TITLE="Simulated problem"
fi 

EVENT_TYPE=$2
if [[ -z "$EVENT_TYPE" ]]; then
  EVENT_TYPE="CUSTOM_ALERT"
fi 

echo "============================================================="
echo "Sending '$EVENT_TYPE' event to "
echo "$DT_BASEURL"
echo "============================================================="
#read -rsp $'Press ctrl-c to abort. Press any key to continue...\n' -n1 key

PAYLOAD='
{
  "title": "'$PROBLEM_TITLE'",
  "eventType": "'$EVENT_TYPE'",
  "source" : "Demo Script",
  "description" : "There was a problem detected which should trigger the Cloud Automation Sequence",
  "entitySelector": "type(SERVICE),tag(keptn_project:casdemo,keptn_service:casdemoapp,keptn_stage:production)",
  "properties":{
    "Triggered by": "Demo Script"
  }
}
'
echo "=============================================================="
echo "SENDING THE FOLLOWING HTTP PAYLOAD TO "
echo "  $DT_BASEURL/api/v2/events/ingest"
echo "=============================================================="
echo $PAYLOAD
echo "=============================================================="
curl -s -X POST \
          "$DT_BASEURL/api/v2/events/ingest" \
          -H 'accept: application/json; charset=utf-8' \
          -H "Authorization: Api-Token $DT_API_TOKEN" \
          -H 'Content-Type: application/json; charset=utf-8' \
          -d "$PAYLOAD" \
          -o curloutput.txt

echo "API RESPONSE:"
echo "=============================================================="
cat curloutput.txt
echo ""
echo ""