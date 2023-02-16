import requests

url = "http://localhost:8080/cb/api/v3/items/2319/attachments"

payload={}
files=[
  ('attachments',('dogpic4.jpeg',open('/Users/patrikpasztor/Downloads/dogpic4.jpeg','rb'),'image/jpeg')),
  ('attachments',('dogpic5.jpeg',open('/Users/patrikpasztor/Downloads/dogpic5.jpeg','rb'),'image/jpeg'))
]
headers = {
  'Accept': 'application/json',
  'Authorization': 'Basic Ym9uZDowMDc='
}

response = requests.request("POST", url, headers=headers, data=payload, files=files)

print(response.text)
