#!/bin/bash

source ./_workshop-config.lib

CUSTOM_CONFIG_PATH=./custom-config
MONACO_PROJECT_BASE_PATH=./monaco/projects
MONACO_ENVIONMENT_FILE=./monaco/environment.yaml

run_monaco_delete() {
    # run monaco as code script
    PROJECT=$1

    echo "-------------------------------------------------------------------"
    echo "Deleting project: $PROJECT"
    echo "-------------------------------------------------------------------"
    cp $MONACO_PROJECT_BASE_PATH/$PROJECT/delete.txt $MONACO_PROJECT_BASE_PATH/delete.yaml 
    export NEW_CLI=1 && export DT_BASEURL=$DT_BASEURL && export DT_API_TOKEN=$DT_API_TOKEN && monaco deploy -v --environments $MONACO_ENVIONMENT_FILE --project $PROJECT $MONACO_PROJECT_BASE_PATH
    rm $MONACO_PROJECT_BASE_PATH/delete.yaml 
}

reset_custom_dynatrace_config() {
    setFrequentIssueDetectionOn
    setServiceAnomalyDetection $CUSTOM_CONFIG_PATH/service-anomalydetectionDefault.json
}

# this supports the clean up to run without a prompt.  
# Just pass in an argument ./cleanup-workshop-config.sh Y
if [ -z $1 ]; then
    echo "==================================================================="
    echo "About to Delete Workshop Dynatrace configuration on $DT_BASEURL"
    echo "==================================================================="
    read -p "Proceed? (y/n) : " REPLY;
else
    REPLY=$1
fi

if [[ $REPLY =~ ^[Yy]$ ]]; then

    echo ""
    echo "*** Removing Dynatrace config ***"
    echo

    # need to do this so that the monaco valdiation does not fail
    # even though you are not running the dashboard project, monaco
    # still valdiates all the projects in the projects folders 
    export OWNER=DUMMY_PLACEHOLDER
    run_monaco_delete setup
    reset_custom_dynatrace_config

    echo ""
    echo "*** Done Removing Dynatrace config ***"
    echo ""
fi