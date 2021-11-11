#!/bin/bash

# this is optonal.  If dont pass it in, then you get a menu to enter it
EVENT_NUMBER=$1

if [ -z $EVENT_NUMBER ]; then

    echo "==================================================================="
    echo "1) production.mysequence.triggered"
    echo "2) sh.keptn.event.mytask.started"
    echo "3) sh.keptn.event.mytask.finished"
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
        echo "OUTPUT = $OUTPUT"
        echo $ID > $SEQUENCE_FILE
        ;;
    "2") 
        TEMPLATE_FILE="./events/mytask-started.template"
        EVENT_FILE="./events/mytask-started.json"
        KEPTN_CMD="keptn send event --file $EVENT_FILE"
        ID=$(cat $SEQUENCE_FILE)
        TRIGGER_ID=$(cat $TRIGGER_FILE)

        cat $TEMPLATE_FILE | \
            sed 's~REPLACE_ID~'"$ID"'~' | \
            sed 's~REPLACE_TRIGGER_ID~'"$TRIGGER_ID"'~' > $EVENT_FILE

        echo "Running '$KEPTN_CMD'"
        OUTPUT=$($KEPTN_CMD)
        echo "OUTPUT = $OUTPUT"
        ;;
    "3") 
        TEMPLATE_FILE="./events/mytask-finished.template"
        EVENT_FILE="./events/mytask-started.json"
        KEPTN_CMD="keptn send event --file $EVENT_FILE"
        ID=$(cat $SEQUENCE_FILE)
        TRIGGER_ID=$(cat $TRIGGER_FILE)

        cat $TEMPLATE_FILE | \
            sed 's~REPLACE_ID~'"$ID"'~' | \
            sed 's~REPLACE_TRIGGER_ID~'"$TRIGGER_ID"'~' > $EVENT_FILE

        echo "Running '$KEPTN_CMD'"
        OUTPUT=$($KEPTN_CMD)
        echo "OUTPUT = $OUTPUT"
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
