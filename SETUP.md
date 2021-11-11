# Setup Dynatrace monitoring configuration

Follow these steps to automate the setup the Dynatrace monitoring configuration

## Step 1: Add Dynatrace API token

A Dynatrace API token is needed for by Dynatrace service to support SLO evaluations where Dynatrace is the data source. To add your token:

1. Within Dynatrace, using the left side menu click on `Manage --> Access tokens`. 
1. Click `Generate new token` button
1. Given the token a name and add these scopes:
    * Access problem and event feed, metrics, and topology (API v1)
    * Create and read synthetic monitors, locations, and nodes (API v1)
    * Read configuration (API v1)
    * Write configuration (API v1)
    * Capture request data (API v1)
    * Data ingest, e.g.: metrics and events (API v1)
    * Read metrics (API v2)
    * Ingest metrics (API v2)
    * Read entities (API v2)
    * Read problems (API v2)
    * Write problems (API v2)
1. Save your token to a safe place, for you only get to see it once

## Step 2: Download and install monaco

This setup of the Dynatrace configuration uses the [Dynatrace Monitoring as Code](https://dynatrace-oss.github.io/dynatrace-monitoring-as-code/) (Monaco) utility.  To download and install:

1. In the SSH terminal, run these commands to download and install the monaco binary. 

    ```
    curl -L https://github.com/dynatrace-oss/dynatrace-monitoring-as-code/releases/download/v1.6.0/monaco-linux-amd64 -o monaco
    chmod +x monaco
    sudo mv ~/Downloads/monaco /usr/local/bin/
    ```

1. Verify the monaco binary, by running this command. The output should display 1.6.0

    ```
    monaco --version
    ```
1. Clone this repo to the home directory

    ```
    cd ~
    git clone https://github.com/robertjahn/cas-quickstart
    ```

## Step 3: Call the script to add Dynatrace Monitoring configuration

A custom script called `setup-dynatrace-config.sh` is used to call both monaco and the Dynatrace API to configure your environment.  This script requires your Dynatrace URL and API token, so you need to put those into a `credentials.json` file.  

1. Copy the `credentials.template` to `credentials.json` file.  

    ```
    cd ~/cas-quickstart/scripts
    cp credentials.template credentials.json
    ```

1. Edit `credentials.json` with your Dynatrace URL and API token you just created

1. Lastly, run the Dynatrace configuration script. 

    **BUT** for this you need to provide a dashboard owner email as a required argument. This must be a valid Dynatrace user's email as shown below.

    ```
    cd ~/cas-quickstart/scripts
    ./setup-dynatrace-config.sh yourname@company.com
    ```

    Output should look like:

    ```
    -----------------------------------------------------------------------------------
    Setting up Dynatrace config
    Dynatrace  : https://XXXXX.sprint.dynatracelabs.com
    Starting   : Mon Nov  8 13:48:47 EST 2021
    -----------------------------------------------------------------------------------
    Running monaco for project = setup
    ...
    ...
    -----------------------------------------------------------------------------------
    Done Setting up Dynatrace config
    End: Mon Nov  8 13:48:48 EST 2021
    -----------------------------------------------------------------------------------
    ```

## Step 4: Verify Dynatrace Configuration

The script adds the following Dynatrace configuration:

These can be viewed within the settings:
* Set global [Frequent Issue Detection](https://www.dynatrace.com/support/help/how-to-use-dynatrace/problem-detection-and-analysis/problem-detection/detection-of-frequent-issues/) settings to Off to make testing of problems easier
* Adjust the [Service Anomaly Detection](https://www.dynatrace.com/support/help/how-to-use-dynatrace/problem-detection-and-analysis/problem-detection/adjust-sensitivity-anomaly-detection/) to make testing of problems easier
* Add [Auto Tagging Rules](https://www.dynatrace.com/support/help/how-to-use-dynatrace/tags-and-metadata/) to drive service tags for the default keptn services

These can be viewed in the dashboard page:
* Add a custom [dashboard](https://www.dynatrace.com/support/help/how-to-use-dynatrace/dashboards-and-charts/) that will be used during SLO automated evaluation

<hr>

[<img src="images/prev.png" width="50px" height="50"/>](VM.md) [<img src="images/next.png" width="50px" height="50"/>](APP.md)