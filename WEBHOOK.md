# Cloud Automation Webhook types

There are two webhook types that you will setup and review.

## #1 Silent webhook

These subscribe to the `task.started` or `task.finished` events of some sequence task.  Downstream system does NOT need to response back.

<img src="images/webhook-silent.png" width="50%" height="50%">

## #2 Interactive webhook

These subscribe to the `task.triggered` events of some sequence task.  Downstream system does MUST response back with a `task.finished` event in order for the sequence to continue

<img src="images/webhook-interative.png" width="50%" height="50%">

See [Dynatrace Docs](https://www.dynatrace.com/support/help/how-to-use-dynatrace/cloud-automation/lifecycle-orchestration) for additional details.

# Webhook demo

For a quick demonstration, you will configure both types of webhooks to send the HTTP request and payload to a web site, https://webhook.site, in order to simulate the events that would be send to a down stream tool.

The project you setup in the previous step has a simple sequence with a single task.  Once you setup the webhook subscriptions, you will trigger a sequence and view the webhook payloads in the https://webhook.site as shown below.

<img src="images/mysequence-flow.png" width="75%" height="75%">

# Configure webhooks

Follow these steps to configure two webhooks.  

## Step 1: Get a webhook target

To get you unique webhook target, just open `https://webhook.site` page in a new browser tab and keep it open.

Copy the unique URL that is generated.

<img src="images/webhook-site-copy-url.png" width="75%" height="75%">

## Step 2: Configure the `silent` webhook

1. From the Cloud Automation UI, click on the project `demo`

1. On the left menu click on the `Uniform` option

1. Click on the `web-hook` service.

1. Click the `Add subscription` button

1. On the `New subscription` page, fill in the following values as shown below.
    * task = `mytask-interative`
    * Task suffix = `finished`
    * request method = `POST`
    * URL = the wehbook.site URL you copied
    * custom payload below
        ```
        {
            "event": "{{.type}}",
            "stage": "{{.data.stage}}",
            "custom": "{{.data.custom}}",
            "shkeptncontext": "{{.shkeptncontext}}",
            "triggeredid": "{{.id}}"
        }
        ```

1. Click the `Create subscription` button

## Step 3: Configure the `interactive` webhook

1. Click the `Add subscription` button

1. On the `New subscription` page, fill in the following values as shown below.
    * task = `mytask-interactive`
    * Task suffix = `triggered`
    * request method = `POST`
    * URL = the webbook.site URL you copied
    * custom payload below
        ```
        {
            "event": "{{.type}}",
            "stage": "{{.data.stage}}",
            "custom": "{{.data.custom}}",
            "shkeptncontext": "{{.shkeptncontext}}",
            "triggeredid": "{{.id}}"
        }
        ```

1. Click the `Create subscription` button

## Step 4: Review

The webhooks should look like this

<img src="images/webhook-list.png" width="75%" height="75%">

## Step 5: Adjust the `interactive` webhook configuration in GIT

A UI enhancement is coming, but for now you need to manually adjust the webhook.yaml for the interactive webhook.  

Open up the project in your git upstream repo and adjust the `webhook.yaml` file in the `master` branch to add the `sendFinished: false` row as shown below.

```
apiVersion: webhookconfig.keptn.sh/v1alpha1
kind: WebhookConfig
metadata:3
  name: webhook-configuration
spec:
  webhooks:
    - type: sh.keptn.event.mytask-interactive.triggered
      sendFinished: false    <<-------------------------- **** ADD THIS ROW ****
      requests:
        - curl --request POST --data
    ...
    ...
```

<hr>

[<img src="images/prev.png" width="50px" height="50"/>](ONBOARD.md) [<img src="images/next.png" width="50px" height="50"/>](TRIGGER.md)