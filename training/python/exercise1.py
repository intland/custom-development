import http.client
import json

conn = http.client.HTTPConnection("localhost", 8080)
payload = json.dumps({
  "name": "My first tracker item",
  "description": "It is too easy",
  "storyPoints": 42,
  "assignedTo": [
    {
      "id": 1,
      "type": "UserReference"
    }
  ]
})
headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Basic Ym9uZDowMDc='
}

for x in range(4):
  conn.request("POST", "/cb/api/v3/trackers/8361/items", payload, headers)
  res = conn.getresponse()
  data = res.read()
  print(data.decode("utf-8"))
