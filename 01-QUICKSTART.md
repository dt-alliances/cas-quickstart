# Quick Start Environment

Refer to the picture below for the components that make up this quick start guide and that you will setup and use.

<img src="images/setup.png" width="75%" height="75%">

1. **Virtual Machine** - hosts the demo app, Dynatrace OneAgent, and Keptn CLI 
1. **Mock third party service** - This application is used in the demo webhook subscriptions.  It will receive requests and send back Cloud Automation Events.  It is run within a local Docker compose network in a single container. Logs of requests are application is viewable in a browser
1. **Sample application** - This is the demo app used in the guide. It runs within a local Docker compose network as single container. A load generator container is run in the Docker compose network and send web requests continuously.  The Docker images have already been created and published to Dockerhub. Application is viewable in a browser.
1. **Dynatrace OneAgent** - monitor host and the sample application
1. **Dynatrace** - web interface with full-stack observability
1. **Dynatrace Cloud Automation web UI** - Used to view the Cloud Automation workflows called sequences and configuration of webhooks
1. **Command line utility** - allows creating projects, onboarding services, and sending new artifact events to CloudAutomation.
1. **Upstream Repo** - stores all the configuration files for the Cloud Automation demo application
1. **webook.site** - used to quickly see the events that would be send to a downstream tool

# Quick start environment prerequisites

1. Dynatrace Accounts:
    * Dynatrace SaaS environment
    * Dynatrace Cloud Automation instance  
1. Compute
    * You provide and manage a virtual machine that hosts the OneAgent and sample application. 
    * See the next section below for details for setting this up

💥💥💥 **IMPORTANT NOTE** 💥💥💥

The Dynatrace Cloud Automation instance DOES NOT come automatically with a Dynatrace SaaS trial. Ask your Dynatrace point of contact to have this provisioned.

# Dynatrace UI versus Cloud Automation UI

There are two different web user interfaces that you need to have open for this guide.  Each has its own URL as shown below.
* On the left is the **Dynatrace SaaS** - Used for monitoring of the demo application
* On the right is the **Cloud Automation web UI (a.k.a. Cloud Automation "bridge")** - Used to view the Cloud Automation workflows, called sequences, and configuration of webhooks

<img src="images/dt-and-bridge.png" width="75%" height="75%">

💥💥💥 **IMPORTANT NOTE** 💥💥💥

These environments use Single Sign On (SSO) so you will have the same login for both.  But to add user or have access to the Cloud Automation UI, you need the `Cloud Automation Admin` role. See this [user admin README](21-USERADMIN.md) for more details.

<hr>

[<img src="images/prev.png" width="50px" height="50"/>](README.md) [<img src="images/next.png" width="50px" height="50"/>](02-VM.md)