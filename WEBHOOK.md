# Webhooks overview

Before you start, I encourage you to review these resources:

* [Cloud Automation Webhooks Overview blog](https://www.dynatrace.com/news/blog/dynatrace-enables-tool-agnostic-automation-for-your-application-lifecycle/)
* [Cloud Automation Webhooks for Slack video](https://www.youtube.com/watch?v=0vJS7ecayGw&t=267s)
* [Cloud Automation Webhooks for GitHub Actions video](https://www.youtube.com/watch?v=d32WHNmtqOs)

# Quick Start Use Case Overview

There a few webhook types that you will setup and review for this guide.

## #1 Silent webhook to task finished event

The picture below shows this silent webhook activation mode:

<img src="images/webhook-silent.png" width="50%" height="50%">

For this use case, you will start with the builtin task called `evaluation` that performs an automated SLO evaluation.  The `lighthouse` service subscribes to the `evaluation.triggered` event and will perform an automated SLO evaluation and then when complete, send back the `evaluation.finished` task event. 

Your webhook will simply subscribe to the `evaluation.finished` event as to get the results.  Doing this will let you see your first webhook in action!

## #2 Silent webhook to task triggered event

The picture below shows this silent webhook activation mode:

<img src="images/webhook-triggered-sendfinished.png" width="50%" height="50%">

For this use case, you let the webhook service complete the start and finish events for the task.  This can be helpful when you just want to trigger an external process and not require that process to send back confirmation.  Doing this allows you to understand how to run the silents model as to help you setup your custom integration.

In this guide, you will add a `mytask-silent` task and add a webhook subscription to the `mytask-silent.triggered` event. So that you can ask the webhook service to automatically send back the `mytask-silent.finished` event, you will add a `sendFinished: true` attribute in the webhook subscription.

## #3 Interactive webhook to task triggered event

The picture below shows the interactive webhook activation mode:

<img src="images/webhook-interative.png" width="50%" height="50%">

For this use case, you will simulate what a downstream system does by triggering a custom task and having that task send back with a `finished` event.  Doing this allows you to understand how to run the interactive model as to help you setup your custom integration.

In this guide, you will add a `mytask-interactive` task and add a webhook subscription to the `mytask-silent.triggered` event.  Then you will manually send in the `mytask-interactive.finished` event in order for the sequence to continue using a helper unix script. 

See [Dynatrace Docs](https://www.dynatrace.com/support/help/how-to-use-dynatrace/cloud-automation/lifecycle-orchestration) for additional details.

<hr>

[<img src="images/prev.png" width="50px" height="50"/>](ONBOARD.md) [<img src="images/next.png" width="50px" height="50"/>](SLO.md)