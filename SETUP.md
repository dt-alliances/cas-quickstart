# Setup Virtual Machine with the OneAgent and a sample application

This setup guide assumes you will use AWS to run the sample application. You will need permission to add/delete: VPCs/subnets/Routes/IGWs/Route tables, CloudFormation Stacks, and EC2s/security groups/keypairs.

This guide will have you:
1. Add a new Dynatrace token
    * Create a Dynatrace Token needed to install the OneAgent 
    * Make file with the Dynatrace URL and Token that are used for the Dynatrace configuration setup script
1. Provision EC2 instance with OneAgent and the sample application
    * Create an AWS KeyPair needed for the EC2 creation
    * Provision a EC2 instance using a CloudFormation template. This template will:
        * Prompt for the Key Pair name and Dynatrace URL and Token
        * Install the Dynatrace OneAgent
        * Install [this](https://github.com/dt-orders/overview) sample application.  This setup also automatically setups up a service that generates requests against the sample application so that Dynatrace has something to monitor.
1. Verify application is running and is being monitored by Dynatrace

**NOTE:** The setup will leverage scripts from this [Dynatrace workshop](https://aws-modernize-workshop-stg.alliances.dynatracelabs.com/) and run within the AWS CloudShell.

## Step 1: Add a new Dynatrace token

1. Within your AWS console, open up the CloudShell. 

    CloudShell is a browser-based shell that makes it easy to securely manage, explore, and interact with your AWS resources. To open the CloudShell, click on the CloudShell icon at the top of the AWS console. This make take a minute to open the first time.

1. Clone setup scripts

    ```
    git clone -b add-stg-vm https://github.com/dt-alliances-workshops/aws-modernization-dt-orders-setup.git
    ```

1. Add a new Dynatrace token within the Dynatrace web UI

    Follow the instructions within the `Prerequisites --> Capture the Dynatrace token` page in [this guide](https://aws-modernize-workshop-stg.alliances.dynatracelabs.com/).  Just follow the instructions on this one page.

1. Capture setup script inputs values

    Follow the instructions within the `Prerequisites --> Capture Setup Inputs` page in [this guide](https://aws-modernize-workshop-stg.alliances.dynatracelabs.com/).  Just follow the instructions on this one page.

## Step 2: Provision EC2 instance with OneAgent and the sample application

1. Create AWS Key pair

    Follow the instructions within the `Prerequisites --> AWS Key pair` page in [this guide](https://aws-modernize-workshop-stg.alliances.dynatracelabs.com/).  Just follow the instructions on this one page.

    **NOTE:** In the create Stack form, use the key pair to be `dynatrace-cas-quickstart` and save your PEM file that gets downloaded.

1. Create Dynatrace configuration and Run CloudFormation script

    Follow the instructions within the `Lab 1 - OneAgent Observability --> Lab 1 Setup` page in [this guide](https://aws-modernize-workshop-stg.alliances.dynatracelabs.com/).  Just follow the instructions on this one page.

    **NOTE:** For the CloudFormation input page, use the Key Par name of `dynatrace-cas-quickstart`

## Step 3: Verify application is running and is being monitored by Dynatrace

1. Open application in a browser

    Follow the instructions within the `Lab 1 - OneAgent Observability --> Sample App` page in [this guide](https://aws-modernize-workshop-stg.alliances.dynatracelabs.com/)

1. Review application within Dynatrace

    Follow the instructions within the `Lab 1 - OneAgent Observability --> Host View` page in [this guide](https://aws-modernize-workshop-stg.alliances.dynatracelabs.com/).  You are welcome to review the other pages in `Lab 1` to get familiar with the the built-in views of Dynatrace 

<hr>

[<img src="images/prev.png" width="50px" height="50"/>](README.md) [<img src="images/next.png" width="50px" height="50"/>](ONBOARD.md)

