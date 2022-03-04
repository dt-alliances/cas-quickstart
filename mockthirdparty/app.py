#Import the flask module
from flask import Flask, request, make_response
import json
import os
import sys
import requests
import threading
import time
from datetime import datetime

app = Flask(__name__)

# some contants and globals
request_log="request.log"
keptn_api_call_log="keptn_api_call.log"
logtext=""
responsejson={}
keptnbaseurl=""
keptnapitoken=""

# abort it there are no credentials as env. variables
def validate_keptn_credentials():
    global keptnbaseurl
    global keptnapitoken
    keptnbaseurl=os.environ.get("KEPTN_BASEURL")
    keptnapitoken=os.environ.get("KEPTN_API_TOKEN")
    if keptnbaseurl and keptnapitoken:
        print("Using KEPTN_BASEURL = " + keptnbaseurl)
    else:
        print("ABORT: KEPTN_BASEURL and KEPTN_API_TOKEN must be set as environment variables")
        sys.exit()

# Need to have as a thread so that the sequence start event can process
# before the finished event is sent in
def send_keptn_event():
    global keptnbaseurl
    global keptnapitoken
    global responsejson
    threading.Thread(target=send_keptn_event_thread, args=(keptnbaseurl,keptnapitoken,responsejson)).start()

def send_keptn_event_thread(keptnbaseurl,keptnapitoken,responsejson):
    global keptn_api_call_log
    url = keptnbaseurl + "/api/v1/event"
    theheaders = { 
        "accept": "application/json",
        "x-token": keptnapitoken,
        "Content-Type": "application/json" 
    }
    print("send_keptn_event_thread: Sleep before sending")
    # Need to have thread wait a little so that the sequence start event can process
    # before the finished event is sent in
    time.sleep(10)
    dt = datetime.now()
    keptnlogtext="----------------------------------------------------------------\n"
    keptnlogtext+="Date and Time  : " + str(dt) + "\n"
    keptnlogtext+="Event Type     : " + responsejson["type"] + "\n\n"
    keptnlogtext+="Calling URL:\n" + url + "\n\n"

    # need to truncate the token as to not display the whole token
    thetoken=theheaders["x-token"]
    theheaders["x-token"]="Last 8 characters --> " + theheaders["x-token"][-8:]
    keptnlogtext+="HEADERS:\n" + json.dumps(theheaders,indent=2) + "\n\n"
    keptnlogtext+="----------------------------------------------------------------\n"
    keptnlogtext+="RESPONSE BODY:\n" + json.dumps(responsejson,indent=2)
    keptnlogtext+="\n\n"
    f = open(keptn_api_call_log, "a")
    f.write(keptnlogtext)
    f.close()
    # set back to orginal value
    theheaders["x-token"]=thetoken    
    response = requests.post(url, json=responsejson, headers=theheaders)
    print("send_keptn_event_thread response: " + str(response))

    f = open(keptn_api_call_log, "a")
    keptnlogtext="RESPONSE\n"
    keptnlogtext+="status_code : " + str(response.status_code) + "\n"
    keptnlogtext+="reason      : " + str(response.reason) + "\n"
    keptnlogtext+="\n\n"
    f.write(keptnlogtext)
    f.close()

def process_request():
    global request
    global logtext
    global responsejson

    requestdata = request.json
    requesttype=requestdata["type"]

    dt = datetime.now()
    logtext="----------------------------------------------------------------\n"
    logtext+="Date and time       : "+str(dt) + "\n"
    logtext+="Webhook Request for : " + requesttype + "\n\n"
    logtext+="REQUEST HEADERS:\n" + str(request.headers)
    logtext+="\n\n"
    logtext+="----------------------------------------------------------------\n"
    logtext+="REQUEST BODY:\n" + json.dumps(requestdata,indent=2)
    logtext+="\n\n"

    # construct the cloud event - need to replace event with finished
    # example sh.keptn.event.mytask-interactive.started
    indexOfLast = requesttype.rindex(".")
    responsetype=requesttype[0:indexOfLast]+".finished"

    id=requestdata["id"]
    shkeptncontext=requestdata["shkeptncontext"]
    project=requestdata["data"]["project"]
    service=requestdata["data"]["service"]
    stage=requestdata["data"]["stage"]
    responsejson={
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
    # the triggeredid is the ID from the passed in triggered event
    responsejson["triggeredid"]=id
    responsejson["shkeptncontext"]=shkeptncontext
    responsejson["data"]["project"]=project
    responsejson["data"]["service"]=service
    responsejson["data"]["stage"]=stage
    responsejson["type"]=responsetype

def process_response():
    global request
    global logtext
    global responsejson

    f = open(request_log, "a")
    f.write(logtext)
    f.close()

    return json.dumps(responsejson,indent=2)

@app.route('/resetlog', methods=['GET'])
def resetlog():
    global request_log
    global keptn_api_call_log
    f = open(request_log, "w")
    f.write("")
    f.close()
    f = open(keptn_api_call_log, "w")
    f.write("")
    f.close()
    return "Reset Logs complete"

@app.route('/', methods=['GET'])
def activelog():
    global request
    global keptn_api_call_log
    responsetext="========================================================================================================\n"
    responsetext+="REQUESTS\n"
    responsetext+="========================================================================================================\n\n"
    responsetext+=open(request_log, "r").read()
    responsetext+="========================================================================================================\n"
    responsetext+="RESPONSES\n"
    responsetext+="========================================================================================================\n\n"
    responsetext+=open(keptn_api_call_log, "r").read()
    response=make_response(responsetext)
    response.mimetype = "text/plain"
    return response

@app.route('/runtask', methods=['POST'])
def openticket():
    global request
    global logtext
    global responsejson

    process_request()

    # Add some additonal attributes based on event type
    if responsejson["type"] == 'sh.keptn.event.openticket.finished':
        responsejson["data"]["openticket"] = {
                "incidentUrl": "https://incident-tool?incidentNum=123",
                "incidentNumber": "123"
            }
        responsejson["data"]["labels"] = {
            "incidentUrl": "https://incident-tool?incidentNum=123"
        }
    elif responsejson["type"] == 'sh.keptn.event.deployment.finished':
        responsejson["data"]["test"] = {
            "deploymentURL": "https://deployment-tool?jobNumber=123",
            "deploymentResults": "success"
            }
        responsejson["data"]["labels"] = {
            "deploymentURL": "https://deployment-tool?jobNumber=123"
        }
    elif responsejson["type"] == 'sh.keptn.event.test.finished':
        process_request()
        responsejson["data"]["test"] = {
            "testURL": "https://test-tool?testNumber=123",
            "testResults": "success"
            }
        responsejson["data"]["labels"] = {
            "testURL": "https://test-tool?testNumber=123"
        }

    send_keptn_event()
    return process_response()

#Create the main driver function
if __name__ == '__main__':
    #call the run method
    # In order for the web server to accept connections originating from outside of the container 
    # need to have it bind to the 0.0.0.0 IP address.
    validate_keptn_credentials()
    resetlog()
    app.run(host='0.0.0.0')
