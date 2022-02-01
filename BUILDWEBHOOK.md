# Build your own webhook

Now that you have seen and executed both types of webhooks, its time to define your own.  Below is a table of some of the possibilities.  But keep in mind a task will be part of sequences, so they can be reusable to different use cases like testing or problem management.

## Webhook Task Ideas

| Task Category | Silent Webhook | Interactive Webhook |
|---------------|----------------|--------------------|
| Chaos Testing |  Trigger a Test to start  |  Trigger and send back results of test |
|               |  Trigger a Test to stop   |  Trigger and send back confirmation it stopped |
| CI/CD         |  Trigger a Build          |  Trigger and send back results of job |
|               |  Trigger a Deployment     |  Trigger and send back results of job|
| Optimization  |  Trigger a Model to start |  Trigger and send back results of execution |
|               |  Trigger a Model to stop  |  Trigger and send back confirmation it stopped|
| Feature Flags |  Set a Flag ON / OFF      |  Set a Flag ON / OFF with confirmation status of update  |
| Incident Management |  Open a Ticket      |  Open and send back ticket # |
|                     |  Update a Ticket    |  Update and send back confirmation |
|                     |  Close a Ticket     |  Close and send back confirmation  |
|                     |  Run automated remediation runbook | Run and return result |
| Issue Ticketing     |  Open an Issue      |  Open and send back issue # |
|                     |  Update an Issue    |  Update and send back confirmation|
|                     |  Close an Issue     |  Close and send back confirmation |
| Load Testing        |  Trigger a Test to start  |  Trigger and send back results of test  |
|                     |  Trigger a Test to stop   | Trigger and send back confirmation it stopped |
| Notification        | Push update for SLO, Deployment, etc. | Approval: Handle approval triggered, send back an approval.started and the .finished when the user in the notification tool clicked on “approved” or “rejected” " |
| SLO                 |  Push SLO Evaluation Result as a “Report” to external tools |  Request the evaluation of an SLO and send back result |
| Remediation runbook  | Examples: Toggle Feature Flag, Run CD job | Trigger a remediation action and send back results of job |

# Suggested Recipe

1. Determine the best interface of the downstream platform to configure a Cloud Automation webhook against. For example, a configurable an inbound webhook or an API. If yes, then a Cloud Automation silent or interactive pattern is possible.
1. Determine if the downstream platform supports the ability to make the Cloud Automation API call to send back a tasks finished event. If yes, then a Cloud Automation interactive pattern is possible. For example, this could be implemented as:
    * use customer definable scripts
    * Predefined templates
    * This is one example for reference: https://artifacthub.io/packages/keptn/keptn-integrations/githubaction
1. If the interactive pattern is possible, also determine how a user would manage the the Cloud Automation URL and Token as secrets
1. Define one or more use cases
1. For each use case, review the interfaces HTTP method, headers, auth credentials, and payload requirements and map to how the Cloud Automation webhook would be configured
1. Setup a downstream platform account to use for development and testing
1. If creating an interactive use case, develop the script or template that will process the webhook and send back the event to the Cloud Automation API
1. Setup and test Cloud Automation webhooks to the downstream platform.
    * Delete the existing webhooks from the demos
    * Configure configure webhooks to the downstream platform API or webhooks
    * Reuse the the sequences and the `trigger.sh` script from this quick start guide to some initial tests
1. Document the examples
1. Demo and get feedback

# Tips

1. As you setup your webhook, add your API token as a Cloud Automation Secret and use it within subscription page to add it to your URL or Auth header.  This way your token will not be saved in the GIT project in clear text.  For example:

💥💥💥 **IMPORTANT NOTE** 💥💥💥

Pick `keptn-webhook-service` as the Scope

<img src="images/secret.png" width="75%" height="75%">

💥💥💥 **IMPORTANT NOTE** 💥💥💥

Many APIs require `Content-Type: application/json` so be sure to add that. And use the the "key" icon to add your secrets.

<img src="images/subscription-secret.png" width="75%" height="75%">


# Resources

See the [Dynatrace Lifecycle orchestration Docs](https://www.dynatrace.com/support/help/how-to-use-dynatrace/cloud-automation/lifecycle-orchestration#integrate-external-tools-with-webhooks) for additional details as well as the [Keptn Create a Webhook integration Docs](https://keptn.sh/docs/0.10.x/integrations/webhooks/#create-a-webhook-integration)

# Some upcoming changes

* [Webhook: ExtendPayload placeholders to reference full Cloud Event Payload](https://github.com/keptn/keptn/issues/6661)
* [Webhook: Allow filtering for data.result of event](https://github.com/keptn/keptn)
* [Bridge: Add checkbox to set the sendStarted flag ](https://github.com/keptn/keptn/issues/6059)
* [Bridge: task subscriptions UI does not provide a way to re-create a subscription for all events](https://github.com/keptn/keptn/issues/6627)
* [Bridge: Trigger a sequence](https://github.com/keptn/keptn/issues/4507)
* [Bridge: Restructuring of Bridge settings for project](https://github.com/keptn/keptn/issues/5282)
* [Bridge: Show secret scope and keys in overview table](https://github.com/keptn/keptn/issues/6296)

<hr>

[<img src="images/prev.png" width="50px" height="50"/>](INTERACTIVE.md) [<img src="images/next.png" width="50px" height="50"/>](README.md)