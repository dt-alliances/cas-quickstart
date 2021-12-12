# Overview

The guide shows how to setup and use the [Dynatrace Cloud Automation](https://www.dynatrace.com/platform/cloud-automation/) control plane that provides an easy, event-based integration point for external tools such as testing services, notification services, and incident management services.

This guide currently showcases webhook integrations, but the plan is to incorporate a Cloud Automation remote execution plane as to aide in the development and test of custom services.

For help or questions, email [Rob Jahn](https://www.linkedin.com/in/robjahn/) of the Dynatrace Tech Alliances team @ rob.jahn@dynatrace.com 

# Prerequisite knowledge

Dynatrace
* Understanding of Dynatrace, OneAgent and the Software Intelligence Platform
* Understanding of Process Groups, Process Group Instances and Services
* Know how to navigate the Dynatrace web interface to find Services, Release Overview, Dashboards

Cloud Automation Module
* Understanding of Cloud Automation architecture and design concepts

# Prerequisites

The following items comprise your environment

1. Dynatrace Accounts:
    * Dynatrace SaaS environment
    * Cloud Automation SaaS instance
1. Permissions:
    * You manage team members access using Dynatrace account settings. 
    * Cloud Automation uses the same SSO as Dynatrace, so you will use the same login for both  
1. Compute
    * You provide and manage a virtual machine that hosts the OneAgent and sample application. 
    * See the next section below for details

# Environment topology

1. **Virtual Machine** - to host the sample app
1. **Sample application** - runs within a local Docker compose network. The application runs in a single container. A load generator container is also sending web requests continuously.  The Docker images have already been created and published to dockerhub
1. **Sample application web interface** - viewable in a browser
1. **Dynatrace OneAgent** - monitor host and the sample application
1. **Dynatrace SaaS** - web interface with full-stack observability
1. **Cloud Automation Control Plane** - By default has the Dynatrace service that connects to the Dynatrace API
1. **Cloud Automation web UI (a.k.a. Cloud Automation "bridge")** - to view workflow execution and SLO results
1. **Command line utility** - allows creating projects, onboarding services, and sending new artifact events to CloudAutomation.

<img src="images/setup.png" width="75%" height="75%">

# Quick start guide

Follow the instructions for each step below in order shown.

1. [Provision Virtual Machine with the OneAgent](VM.md)

1. [Setup Dynatrace monitoring configuration](SETUP.md)

1. [Start the sample application](APP.md)

1. [Onboard sample application to Cloud Automation](ONBOARD.md)

1. [Configure Cloud Automation Webhook subscription](WEBHOOK.md)

1. [Trigger a sequence](TRIGGER.md)

1. [Add automated SLO evaluation task](SLO.md)

# Resources

* [Dynatrace Cloud Automation Docs](https://www.dynatrace.com/support/help/how-to-use-dynatrace/cloud-automation)
* [Keptn Website](https://keptn.sh)
* [Keptn Dynatrace Service](https://github.com/keptn-contrib/dynatrace-service)
* [Keptn community](https://keptn.sh/community)