# Overview

The guide shows how to setup and use the [Dynatrace Cloud Automation](https://www.dynatrace.com/platform/cloud-automation/) that provides an easy, event-based integration platform for external tools such as testing services, notification services, and incident management services. 

The main goal of Dynatrace Cloud Automation is to enable Development, DevOps and SRE teams to build better quality software faster by bringing Observability, Orchestration, Automation, and Intelligence by:

* Breaking the dependency between process and tooling
* Using standards-based tool interoperability through Cloud Events and control plane
* Having data driven, declarative orchestration without the need to write pipeline code
* Supporting Declarative SLO and SLI specification based on SRE principles supporting and metric data source
* Using GitOps based delivery and operational workflows based on Git

This guide currently showcases Cloud Automation webhook integrations, but the plan is to incorporate a Cloud Automation remote execution plane as to aide in the development and test of custom Cloud Automation services.

For help or questions, email [Rob Jahn](https://www.linkedin.com/in/robjahn/) of the Dynatrace Technical Alliances team @ rob.jahn@dynatrace.com 

# Quick start prerequisite knowledge

### Dynatrace (15 minutes)

* [Dynatrace platform](https://www.dynatrace.com/support/help/get-started/what-is-dynatrace)
* [Dynatrace web interface](https://www.dynatrace.com/support/help/get-started/navigation)
* [Dynatrace OneAgent](https://www.dynatrace.com/support/help/setup-and-configuration/dynatrace-oneagent)
* [Dynatrace service monitoring](https://www.dynatrace.com/support/help/how-to-use-dynatrace/transactions-and-services)

### Cloud Automation architecture and design concepts (10 minutes)

* [Read Cloud Automation Overview Blog](https://www.dynatrace.com/news/blog/deliver-cloud-native-applications-faster-with-dynatrace-cloud-automation-module/)
* [Read Cloud Automation webhooks Blog](https://www.dynatrace.com/news/blog/dynatrace-enables-tool-agnostic-automation-for-your-application-lifecycle)

# Quick start guide

Follow the instructions for each step below in order.

### 1. Environment Setup (30-45 minutes)

* [Quick Start Environment Overview](01-QUICKSTART.md)
* [Provision Virtual Machine with the OneAgent](02-VM.md)
* [Setup Dynatrace monitoring configuration](03-DTCONFIG.md)
* [Start the sample application](04-APP.md)
* [Onboard sample applications to Cloud Automation](05-ONBOARD.md)

### 2. Quick start use cases (30 minutes per use case)

First read this [Webhooks Subscriptions Overview](10-WEBHOOK.md), then move to these use cases:

1. [SLO evaluation demo](11-SLO.md) - try out the three variants of webhook subscriptions using a demo sequence
1. [Software Release demo](12-RELEASE.md) - Trigger a software delivery sequence
1. [Incident Management demo](13-INCIDENT.md) - trigger a Dynatrace problem to start a incident management sequence

### 3. Build your own webhook integration

* [Webhooks Development Recipe](20-BUILDWEBHOOK.md)

# More Resources

## Dynatrace Cloud Automation

* [Dynatrace Docs](https://www.dynatrace.com/support/help/how-to-use-dynatrace/cloud-automation)
* [Release Notes](https://www.dynatrace.com/support/help/shortlink/release-notes#cloud-automation)

## Keptn

* [Keptn Website](https://keptn.sh)
* [Keptn Dynatrace Service](https://github.com/keptn-contrib/dynatrace-service)
* [Keptn community](https://keptn.sh/community)
* [Keptn Release Notes](https://github.com/keptn/keptn/releases)
