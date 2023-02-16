import requests
import json

url = "http://localhost:8080/cb/api/v3/items/2307/fields?quietMode=false"

payload = json.dumps({
  "fieldValues": [
    {
      "fieldId": 7,
      "name": "Status",
      "values": [
        {
          "id": 3,
          "name": "In progress",
          "type": "ChoiceOptionReference"
        }
      ],
      "type": "ChoiceFieldValue"
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
