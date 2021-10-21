# Onboard sample application to Cloud Automation

Cloud Automation requires the sample application to be configured within the Cloud Automation project.  

This guide will have you:
1. Install and authenticate the Keptn CLI
1. Make a project and add a service within Cloud Automation
1. Configure project with Dynatrace integration

## Step 1: Install and authenticate the Keptn CLI

The [keptn CLI](https://keptn.sh/docs/0.9.x/reference/cli/) allows creating projects, onboarding services, and sending new artifact events to CloudAutomation.

In the AWS CloudShell, run these commands to install and authenticate the Keptn CLI

1. Download and install the Keptn CLI

    ```
    export KEPTN_VERSION="0.9.2"
    curl -LO https://github.com/keptn/keptn/releases/download/${KEPTN_VERSION}/keptn-${KEPTN_VERSION}-linux-amd64.tar.gz
    tar -xvf keptn-${KEPTN_VERSION}-linux-amd64.tar.gz
    mv keptn-${KEPTN_VERSION}-linux-amd64 keptn
    chmod +x keptn && mv keptn $HOME/bin/
    ```

1. Verify the Keptn CLI is installed. Run the `keptn version` command. You should see output similar to this:

```
[CloudShell-user@ip-10-0-139-113 ~]$ keptn version

Keptn CLI version: 0.9.2
Keptn cluster version: 0.9.2
```

1. Within your Cloud Automation web UI, click on the person icon on the top right to expand the `Get started` popup.  From the popup, use the `copy keptn auth command` button

1. Authenticate the Keptn CLI by pasting the `keptn auth` command into the AWS CloudShell.  You should see output similar to this:

    ```
    [CloudShell-user@ip-10-0-139-113 ~]$ keptn auth --endpoint=https://[YOUR-URL]/api --api-token=[YOUR_TOKEN]
    keptn creates the folder /home/CloudShell-user/.keptn/ to store logs and possibly creds.
    * Warning: could not check Keptn server version: This command requires to be authenticated. See "keptn auth" for details
    Starting to authenticate
    Successfully authenticated against the Keptn cluster https://[YOUR-URL]/api
    Using a file-based storage for the key because the password-store seems to be not set up.
    ```

## Step 2: Make a project and add a service within Cloud Automation

The following set of command are run in the AWS CloudShell and then verified in the Cloud Automation web UI.

1. Clone the quick start repo

    ```
    cd ~
    git clone https://github.com/robertjahn/cas-quickstart.git
    cd cas-quickstart/keptn
    ```

1. Setup variables for the arguments

    ```
    export KEPTN_PROJECT=dt-orders
    export KEPTN_SERVICE=frontend
    export KEPTN_STAGE=staging
    export KEPTN_SHIPYARD_FILE=shipyard.yaml
    export DT_CONF_FILE=dynatrace.conf.yaml
    ```

1. Create project

    ```
    keptn create project $KEPTN_PROJECT --shipyard=$KEPTN_SHIPYARD_FILE
    ```
    Output should look like:

    ```
    Starting to create project
    Project created successfully
    ```

1. Create service within the project

    ```
    keptn create service $KEPTN_SERVICE --project=$KEPTN_PROJECT
    ```
    Output should look like:

    ```
    Starting to create service
    Service created successfully
    ```

1. Configure the service to use a Dynatrace dashboard query for SLOs

    ```
    keptn add-resource --project=$KEPTN_PROJECT --stage=$KEPTN_STAGE --service=$KEPTN_SERVICE --resource=$DT_CONF_FILE --resourceUri=dynatrace/dynatrace.conf.yaml
    ```
    Output should look like:

    ```
    Adding resource dynatrace.conf.yaml to service frontend in stage staging in project dt-orders
    Resource has been uploaded.
    ```

1. From the Cloud Automation UI, verify that you have a `dt-orders` project and a `frontend` service within it

## Step 3: Configure project with Dynatrace integration

This is needed to support SLO evaluations where Dynatrace is the data source.

1. Create an API token to be used by Cloud Automation

    Within Dynatrace make a new API token called `dynatrace-cas`. Follow `Dynatrace requirements` step from [this guide](https://www.dynatrace.com/support/help/how-to-use-dynatrace/cloud-automation/release-validation/prerequisites-quality-gates/#dynatrace). Expand both the API v1 and V2 permissions for the ones to include in the API Token scope.  You don't need to do the other step on that docs page.

1. Configure Dynatrace secret

    From the Cloud Automation UI, configure the Dynatrace URL and API token as a secret. Follow `2. Connect Cloud Automation to Dynatrace` step from [this guide](https://www.dynatrace.com/support/help/shortlink/qg-start#h2-connect-cloud-automation-to-dynatrace) using the `Via the CA bridge` instructions.  You don't need to do the other step on that docs page.

1. Configure Dynatrace Monitoring for the project

    ```
    keptn configure monitoring dynatrace --project=$KEPTN_PROJECT
    ```
    Output should look like:

    ```
    ID of Keptn context: e9602eb6-c66d-44e9-b119-de4aa48b0a47
    Dynatrace monitoring setup done.
    The following entities have been configured:

    ---Keptn API Connection Check:--- 
    - Keptn API URL: https://[YOUR-CAS-URL]/api
    - Connection Successful: true. 
    ```
