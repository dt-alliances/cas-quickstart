#!/bin/bash

source ./_workshop-config.lib

export OWNER=$1    # This is required for the dashboard monaco project
if [ -z $OWNER ]; then
    echo "ABORT dashboard owner email is required argument"
    echo "      this must be a valid Dynatrace users email"
    echo "syntax: ./setup-dynatrace-config.sh your-email@company.com"
    exit 1
fi

if [ "$OWNER" = "your-email@company.com" ]; then
    echo "ABORT: You must YOUR dashboard owner email"
    echo "      this must be a valid Dynatrace users email"
    echo "syntax: ./setup-dynatrace-config.sh your-email@company.com"
    exit 1
fi

CUSTOM_CONFIG_PATH=./custom-config
MONACO_PROJECT_BASE_PATH=./monaco/projects
MONACO_ENVIONMENT_FILE=./monaco/environment.yaml

run_monaco() {
    MONACO_PROJECT=$1

    if [ -z $MONACO_PROJECT ]; then
        echo "ERROR: run_monaco() Missing MONACO_PROJECT argument"
        exit 1
    fi

    echo "Running monaco for project = $MONACO_PROJECT"
    echo "monaco deploy -v --environments $MONACO_ENVIONMENT_FILE --project $MONACO_PROJECT $MONACO_PROJECT_BASE_PATH"

    # add the --dry-run argument during testing
    export NEW_CLI=1 && export DT_BASEURL=$DT_BASEURL && export DT_API_TOKEN=$DT_API_TOKEN && \
        monaco deploy -v \
        --environments $MONACO_ENVIONMENT_FILE \
        --project $MONACO_PROJECT \
        $MONACO_PROJECT_BASE_PATH
}

run_custom_dynatrace_config() {
    setFrequentIssueDetectionOff
    setServiceAnomalyDetection $CUSTOM_CONFIG_PATH/service-anomalydetection.json
}

echo ""
echo "-----------------------------------------------------------------------------------"
echo "Setting up Dynatrace config"
echo "Dynatrace  : $DT_BASEURL"
echo "Starting   : $(date)"
echo "-----------------------------------------------------------------------------------"
echo ""

run_monaco setup
run_custom_dynatrace_config

echo ""
echo "-----------------------------------------------------------------------------------"
echo "Done Setting up Dynatrace config"
echo "End: $(date)"
echo "-----------------------------------------------------------------------------------"
