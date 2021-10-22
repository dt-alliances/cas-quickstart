# Trigger a problem event end-to-end from Dynatrace

For this step, you will enable a problem in the sample application to see an end to end flow. See this [README](https://github.com/dt-orders/overview) for more details on the problem patterns.

For this quick start, you will just use one problem pattern. 

## Step 1: Configure Dynatrace problem notification webhook to send events to Cloud Automation

## Step 2: Trigger a problem in the sample application

Using a browser, use the URLs below to enable the problems:

```
# enable High Response time for all requests
http://[hostname or IP]/customer/setversion/3

# go back to home page to verify version change
http://[hostname or IP]
```

## Step 3: Verify the subscription

## Step 4: Revert the problem in the sample application

Using a browser, use the URLs below to disable the problems:

```
# revert bake to normal response time 
http://[hostname or IP]/customer/setversion/1

# go back to home page to verify version change
http://[hostname or IP]
```

## Step 5: Verify the subscription
