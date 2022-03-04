# Adjsut HOST_URL for your needs
HOST_URL=http://localhost:5000

# RESET LOG
curl -X GET "$HOST_URL/resetlog"
echo ""
echo ""

# RUN A TASK
# Adjust values like "project", "service", "stage", and "type" as required
PAYLOAD='
{
  "data": {
    "project": "mockthirdparty",
    "service": "demo",
    "stage": "production"
  },
  "id": "0f8eef01-9504-4b1c-a3f7-dedda230b0bd",
  "shkeptncontext": "db0c7efe-064d-4efa-be80-564ed46cb207",
  "type": "sh.keptn.event.openticket.triggered"
}
'
curl -X POST "$HOST_URL/runtask" \
    -H "Content-Type: application/json" \
    -d "$PAYLOAD"
echo ""
echo ""    
exit

# GET LOG
curl -X GET "$HOST_URL"
echo ""
echo ""