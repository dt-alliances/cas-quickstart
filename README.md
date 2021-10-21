# Overview

This is a quick start guide for the Dynatrace Cloud Automation Solution (CAS).  

The guide shows how to setup a sample application and configure the Dynatrace problem notification webhook to send problem events to the Cloud Automation control plane. Once events are in the control plane, subscriptions to this event can be configured a downstream system.

# Prerequisites

In order to provide early access to partners, Dynatrace will provision a “sprint” Dynatrace account and "sprint" environments.

1.  Within this account, Dynatrace will create:
    * Dynatrace instance with full admin rights. For example https://[YOUR-DT-ENVIRONMENT].sprint.dynatracelabs.com
    * Cloud Automation Solution instance. For example https://[YOUR-CAS-ENVIRONMENT].cloudautomation.sprint.dynatracelabs.com 
1. Partner manages team members access using Dynatrace account settings
1. Partner provides and manages a virtual machine with OneAgent and sample application. See Quick start guide below.

# Quick start guide

Follow the instructions for each step below in order.

1. [Setup Virtual Machine with the OneAgent and a sample application](SETUP.md)

1. [Onboard sample application to Cloud Automation](ONBOARD.md)

1. [Configure Cloud Automation Webhook subscription](WEBHOOK.md)

1. [Trigger a problem event using Cloud Automation API](PROBLEMEVENTTEST.md) 

1. [Trigger a problem event end-to-end from Dynatrace](PROBLEMEVENT.md) 

1. [Trigger a SLO evaluation using API](SLO.md)

# Support

For help or questions, email [Rob Jahn](https://www.linkedin.com/in/robjahn/) of the Dynatrace Technical Alliances team (based in Boston) @ rob.jahn@dynatrace.com