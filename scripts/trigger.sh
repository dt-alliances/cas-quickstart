#!/bin/bash

send_event() {
    TEMPLATE_FILE=$1
    KEPTN_CMD="keptn send event --file $TEMPLATE_FILE"
    echo "Running '$KEPTN_CMD'"

    OUTPUT=$($KEPTN_CMD)
    ID=$(echo $OUTPUT | awk -F': ' '{print $2}')
    echo "Saving Keptn context ID to $SEQUENCE_FILE"
    echo $ID > $SEQUENCE_FILE
    echo ""
    echo "keptn send event output = $OUTPUT"
    echo ""
    echo "Goto the Cloud Automation web UI and review the new sequence"
    echo ""
}

clear

SEQUENCE_FILE="./sequence.txt"
TRIGGER_FILE="./trigger.txt"

while true
do
    if [ -z $EVENT_NUMBER ]; then

        echo "============================================================================="
        echo "1) SLO-DEMO      - Send 'sh.keptn.event.production.getslo.triggered' event"
        echo "2) RELEASE-DEMO  - Send 'sh.keptn.event.staging.release.triggered' event"
        echo "3) INCIDENT-DEMO - Send 'sh.keptn.event.production.incident.triggered' event"
        echo "-----------------------------------------------------------------------------"
        echo "q) quit and exit"
        echo "============================================================================="
        read -p "Pick the number for the event to trigger : " EVENT_NUMBER;
        echo ""
    fi

    case "$EVENT_NUMBER" in
        "1") 
            TEMPLATE_FILE="../projects/slo-demo/events/sh.keptn.event.production.getslo.triggered.json"
            send_event $TEMPLATE_FILE
            EVENT_NUMBER=""
            ;;
        "2") 
            TEMPLATE_FILE="../projects/release-demo/events/sh.keptn.event.staging.release.triggered.json"
            send_event $TEMPLATE_FILE
            EVENT_NUMBER=""
            ;;  
        "3") 
            TEMPLATE_FILE="../projects/incident-demo/events/sh.keptn.event.production.incident.triggered.json"
            send_event $TEMPLATE_FILE
            EVENT_NUMBER=""
            ;;          
        q)
            echo ""
            exit
            ;;
        *)
            echo ""
            echo "-----------------------------------------------------------------------------------"
            echo "ERROR: Invalid selection"
            echo "-----------------------------------------------------------------------------------"
            exit 1
            ;;
    esac
    echo ""
    echo ""
done

