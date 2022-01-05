#!/bin/bash

# this is optonal.  If dont pass it in, then you get a menu to enter it
EVENT_NUMBER=$1
# this may be required for some events. Logic is script will check
TRIGGER_ID=$2

clear
while true
do
    if [ -z $EVENT_NUMBER ]; then

        echo "==================================================================="
        echo "1) Send 'production.mysequence.triggered' event"
        echo "2) Send 'sh.keptn.event.mytask-interactive.finished' event"
        #echo "3) sh.keptn.event.mytask-silent.started"
        #echo "4) sh.keptn.event.mytask-silent.finished"
        echo "-------------------------------------------------------------------"
        echo "q) quit and exit"
        echo "==================================================================="
        read -p "Pick the number for the event to trigger : " EVENT_NUMBER;
        echo ""

    fi

    SEQUENCE_FILE="./events/sequence.txt"
    TRIGGER_FILE="./events/trigger.txt"

    case "$EVENT_NUMBER" in
        "1") 
            TEMPLATE_FILE="./events/mysequence-triggered.template"
            KEPTN_CMD="keptn send event --file $TEMPLATE_FILE"
            echo "Running '$KEPTN_CMD'"

            OUTPUT=$($KEPTN_CMD)
            ID=$(echo $OUTPUT | awk -F': ' '{print $2}')
            echo "keptn send event output = $OUTPUT"
            echo "Saving Keptn context ID to $SEQUENCE_FILE"
            echo $ID > $SEQUENCE_FILE
            echo ""
            echo "Goto the Cloud Automation web UI and review the new sequence"
            echo ""
            ;;
        "2") 
            TEMPLATE_FILE="./events/mytask-interactive-finished.template"
            EVENT_FILE="./events/mytask-interactive-finished.json"
            KEPTN_CMD="keptn send event --file $EVENT_FILE"

            ID=$(cat $SEQUENCE_FILE)
            if [ -z $TRIGGER_ID ]; then
                echo "Open the Cloud Automation web UI to the running sequence"
                echo "Expand the mytask-interactive task and view the started event payload"
                echo "To get the triggeredid"
                echo ""
                read -p "Enter triggeredid value : " TRIGGER_ID;
            fi
            if [ -z $TRIGGER_ID ]; then
                echo "ABORT: Missing TRIGGER_ID as parameter or in $TRIGGER_FILE"
                exit 1
            fi
            cat $TEMPLATE_FILE | \
                sed 's~REPLACE_ID~'"$ID"'~' | \
                sed 's~REPLACE_TRIGGER_ID~'"$TRIGGER_ID"'~' > $EVENT_FILE
            
            echo ""
            echo "Running '$KEPTN_CMD'"
            OUTPUT=$($KEPTN_CMD)
            echo "keptn send event output = $OUTPUT"
            echo ""
            echo "Goto the Cloud Automation web UI and confirm the sequence has completed"
            echo ""
            ;;
        "SKIP-3") 
            TEMPLATE_FILE="./events/mytask-silent-started.template"
            EVENT_FILE="./events/mytask-silent-started.json"
            KEPTN_CMD="keptn send event --file $EVENT_FILE"
            ID=$(cat $SEQUENCE_FILE)

            if [ -z $TRIGGER_ID ]; then
                read -p "Enter TRIGGER_ID : " TRIGGER_ID;
            fi
            if [ -z $TRIGGER_ID ]; then
                echo "ABORT: Missing TRIGGER_ID as parameter or in $TRIGGER_FILE"
                exit 1
            fi
            cat $TEMPLATE_FILE | \
                sed 's~REPLACE_ID~'"$ID"'~' | \
                sed 's~REPLACE_TRIGGER_ID~'"$TRIGGER_ID"'~' > $EVENT_FILE

            echo "Running '$KEPTN_CMD'"
            OUTPUT=$($KEPTN_CMD)
            echo "keptn send event output = $OUTPUT"
            ;;
        "SKIP-4") 
            TEMPLATE_FILE="./events/mytask-silent-finished.template"
            EVENT_FILE="./events/mytask-silent-finished.json"
            KEPTN_CMD="keptn send event --file $EVENT_FILE"
            ID=$(cat $SEQUENCE_FILE)
            if [ -z $TRIGGER_ID ]; then
                read -p "Enter TRIGGER_ID : " TRIGGER_ID;
            fi
            if [ -z $TRIGGER_ID ]; then
                echo "ABORT: Missing TRIGGER_ID as parameter or in $TRIGGER_FILE"
                exit 1
            fi
            cat $TEMPLATE_FILE | \
                sed 's~REPLACE_ID~'"$ID"'~' | \
                sed 's~REPLACE_TRIGGER_ID~'"$TRIGGER_ID"'~' > $EVENT_FILE
                
            echo "Running '$KEPTN_CMD'"
            OUTPUT=$($KEPTN_CMD)
            echo "keptn send event output = $OUTPUT"
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
    # reset for another input
    EVENT_NUMBER=
    TRIGGER_ID=
done

