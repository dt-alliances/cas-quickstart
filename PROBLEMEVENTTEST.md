# Trigger a problem event using Cloud Automation API

## Step 1: Create a webhook subscription for the problem event

## Step 2: Send a problem event to the Cloud Automation control plane

1. Within your Cloud Automation web UI, click on the person icon on the top right to expand the `Get started` popup.  From the popup, use the `copy keptn api token` button.

1. In a browser, open a new tab and goto `https://[YOUR-CLOUD-AUTOMATION-URL/api/swagger-ui/` to open the Cloud Automation Swagger API interface.

1. From the `Select a definition` drop down list at the top, select `api-service` option.

1. In the row for `Event` on the far right, click the `lock` icon.  This will open a popup to enter the Cloud Automation token.  

1. On the popup, paste the Cloud Automation token and click the `Authorize` button.  Once you see the `Authorized` text on the popup page, click the `Close` button. 

1. Click the `Try it Out` button to allow the Event body to be editable.

1. Paste in this value for the body and then click the big `Execute` button below the body field.

    ```
    {
    "shkeptncontext": "string",
    "triggeredid": "string",
    "specversion": "string",
    "contenttype": "string",
    "data": "Unknown Type: object,string",
    "id": "string",
    "time": "2021-10-21T18:14:39.539Z",
    "type": "string",
    "extensions": {},
    "source": "string"
    }
    ```

    You should see in the `Server response` HTTP code of XXX and sequence number in the response body that looks like this.

    ```
    ```

## Step 3: Verify the subscription