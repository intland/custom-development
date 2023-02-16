import requests
import json

url = "http://localhost:8080/cb/api/v3/items/2319/fields?quietMode=false"

payload = json.dumps({
  "fieldValues": [
    {
      "fieldId": 2,
      "name": "Priority",
      "values": [
        {
          "id": 1,
          "name": "Highest",
          "type": "ChoiceOptionReference"
        }
      ],
      "type": "ChoiceFieldValue"
    },
    {
      "fieldId": 10,
      "name": "Planned Effort",
      "type": "DurationFieldValue",
      "value": 43200000
    }
  ]
})
headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Basic Ym9uZDowMDc='
}

response = requests.request("PUT", url, headers=headers, data=payload)

print(response.text)
