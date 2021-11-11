# Overview

This is a quick start guide for the Dynatrace Cloud Automation Solution (CAS).  

The guide shows how to setup a sample application and configure the Dynatrace problem notification webhook to send problem events to the Cloud Automation control plane. Once events are in the control plane, subscriptions to this event can be configured a downstream system.

The Quick start will setup an environment as follows:

1. **Virtual Machine** - to host the sample app
1. **Sample application** - runs within a local Docker compose network. The application runs in a single container. A load generator container is also sending web requests continuously.  The Docker images have already been created and published to dockerhub
1. **Sample application web interface** - viewable in a browser
1. **Dynatrace OneAgent** - monitor host and the sample application
1. **Dynatrace SaaS** - web interface with full-stack observability
1. **Cloud Automation Control Plane (Powered by Keptn)** - Installed with a Dynatrace Keptn service that connects to the Dynatrace API
1. **Cloud Automation web UI (a.k.a. Cloud Automation "bridge")** - to view workflow execution and SLO results
1. **Keptn command line utility** - allows creating projects, onboarding services, and sending new artifact events to CloudAutomation.

<img src="images/setup.png" width="75%" height="75%">

# Prerequisite Knowledge

Dynatrace
* Understanding of Dynatrace, OneAgent and the Software Intelligence Platform
* Understanding of Process Groups, Process Group Instances and Services
* Know how to navigate the Dynatrace web interface to find Services, Release Overview, Dashboards

Cloud Automation Module
* Understanding of Keptn and Cloud Automation architecture and design conceptss

# Your Environment

In order to provide early access to partners, Dynatrace will provision a “sprint” Dynatrace account and "sprint" environments.

1.  Within this account, Dynatrace will create:
    * Dynatrace instance with full admin rights. For example `https://[YOUR-DT-ENVIRONMENT].sprint.dynatracelabs.com`
    * Cloud Automation Solution instance. For example `https://[YOUR-CAS-ENVIRONMENT].cloudautomation.sprint.dynatracelabs.com` 
1. Partner manages team members access using Dynatrace account settings
1. Partner provides and manages a virtual machine with OneAgent and sample application. See Quick start guide below.

# Quick start guide

Follow the instructions for each step below in order.

1. [Provision Virtual Machine with the OneAgent](VM.md)

1. [Setup Dynatrace monitoring configuration](SETUP.md)

1. [Start the sample application](APP.md)

1. [Onboard sample application to Cloud Automation](ONBOARD.md)

1. [Configure Cloud Automation Webhook subscription](WEBHOOK.md)

1. [Trigger a sequence](TRIGGER.md)

# Resources

### Documentation

* Dynatrace  - https://www.dynatrace.com/support/help/how-to-use-dynatrace/cloud-automation
* Keptn - https://keptn.sh 
* Keptn community - https://keptn.sh/community/ 	

### Support

* For help or questions, email [Rob Jahn](https://www.linkedin.com/in/robjahn/) of the Dynatrace Tech Alliances team @ rob.jahn@dynatrace.com 