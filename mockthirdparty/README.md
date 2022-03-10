# Overview

This `mockthirdparty` application is used to **"Mock"** the behavior of downstream third party platforms as to facilitate `active` [webhook subscriptions](https://keptn.sh/docs/0.12.x/integrations/webhooks/). The application in written in python and runs within Docker. 

## Usage

Start up the `mockthirdparty` application on a host with a public IP.  Then configure webhooks subscriptions that call the `runtask` endpoint.  This application will then parse and send a `finished` event to the defined Keptn or Cloud Automation Environment `/api/v1/event` API.  A log of requests can be viewed by just opening the `mockthirdparty` application in a browser.

## Compatibility

| Keptn Version | Image Tag                    | Description |  
|---------------|:-----------------------------|:------------|
| 0.10+         | dtdemos/mockthirdparty:1.0.0 | Initial version |

## Endpoints

These are opened in browser or from a subscription.

| endpoint | method | description |  
|----------|:------:|:------------|
| /        | GET | Open in browser to shows a log of requests. Syntax example: `http://YOUR-IP-ADDRESS:8080` | 
| runtask  | POST | Called from a subscription task `triggered` event. Requires header `Content-Type: application/json`. It will parse and send a `finished` event to the defined Keptn or Cloud Automation Environment `/api/v1/event` API. A detailed request log is written for each request. See more details in the next section | 
| resetlog | GET | Just open this URL in a browser to clear the request log. Syntax example: `http://YOUR-IP-ADDRESS:8080/resetlog` |

## Prerequisite and starting the application

1. VM running Ubuntu, Docker and Docker Compose. 
    * This can be adjusted in the `docker-compose.yaml` file, but the default port is 8080 and that needs to be opened
1. Clone this repo as to get the docker-compose files. Or just copy the `docker-compose.yaml` file to the VM.
1. The `docker-compose.yaml` script uses an environment file called `.env` to store credentials. To make this, copy the `env.template` file to a files named `.env`
1. In the `.env` file, adjust values for `KEPTN_BASEURL` and `KEPTN_API_TOKEN`
    * `KEPTN_BASEURL` is just for example `https://abc.cloudautomation.live.dynatrace.com` with no `\` at the end
    * `KEPTN_API_TOKEN` is the API token from this same environment 
1. Start up the application
    ```
    sudo docker-compose up -d
    ```
1. Verify its running

    ```
    sudo docker ps
    ```

    you should see, something like
    ```
    CONTAINER ID   IMAGE                          COMMAND                  CREATED         STATUS         PORTS                                       NAMES
    1986da43a9a7   dtdemos/mockthirdparty:1.0.0   "python3 ./app.py"       2 minutes ago   Up 2 minutes   0.0.0.0:8080->5000/tcp, :::8080->5000/tcp   ec2-user_demoapp_1
    ```

# Stop the application

    ```
    sudo docker-compose down
    ```

# Webhook subscription setup

Add a [webhook subscription](https://keptn.sh/docs/0.12.x/integrations/webhooks/) as follows.

* TASK suffix = `triggered`
* URL HEADERS
    ```
    http://YOUR-IP-ADDRESS:8080/runtask
    Content-Type  application/json
    ```
* METHOD = `POST`
* PAYLOAD
    ```
    {
    "data": {
        "project": "{{.data.project}}",
        "service": "{{.data.service}}",
        "stage": "{{.data.stage}}"
    },
    "shkeptncontext": "{{.shkeptncontext}}",
    "id": "{{.id}}",
    "type": "{{.type}}"
    }
    
### Mock `runtask` request processing

The mock service will parse the passed in payload and fill in the values of the cloud event it sends back as follows:

* `project`, `service`, `stage`, `shkeptncontext` from passed in request
* `triggeredid` is replaced with passed in `id` from passed in request
* The `type` will be adjust the `triggered` to `finished` from passed in request.  For example `sh.keptn.event.openticket.triggered` becomes `sh.keptn.event.openticket.finished`
* Using the Docker environment variables, call the `KEPTN_BASEURL + /api/v1/event` endpoint with the `KEPTN_API_TOKEN` header and the generated cloud event in the `POST` request payload

### Posted cloud event template

```
{
    "data": {
        "project":"REPLACE_PROJECT",
        "stage":"REPLACE_STAGE",
        "service": "REPLACE_SERVICE",
        "status": "succeeded",
        "result": "pass"
    },
    "source": "mockthirdparty",
    "specversion": "1.0",
    "type": "REPLACE_TYPE",
    "shkeptncontext": "REPLACE_ID",
    "triggeredid": "REPLACE_TRIGGER_ID"
}
```

### Additional Mockup details

The application does look for certain `tasks` and appends `labels` and cloud event attributes. 
* sh.keptn.event.openticket
* sh.keptn.event.test
* sh.keptn.event.deployment

For example, the following is added for the `openticket` task:

```
...
"data": 
    "openticket": {
        "incidentUrl": "https://incident-tool?incidentNum=123",
        "incidentNumber": "123"
    },
    "labels": {
        "incidentUrl": "https://incident-tool?incidentNum=123"
    }
...
```

### Viewing results

Open in browser the ip of where the services is running to view a log of requests and the cloud event request send back. Syntax example: `http://YOUR-IP-ADDRESS:8080`

# Development

### Development and running as python

* install python3, pip
* install packages `pip install -r requirements.txt`
* set environment variables
    ```
    export KEPTN_BASEURL=REPLACE_VALUE. For example: https://abc.cloudautomation.live.dynatrace.com
    export KEPTN_API_TOKEN=REPLACE_VALUE
    ```
* run app `python app.py`

### Building Image

Use the helper scripts `buildrun.sh` and `buildpush.sh`

### Testing

Adjust and use the helper scripts `tests/test.sh`
