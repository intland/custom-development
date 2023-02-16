import requests

url = "http://localhost:8080/cb/api/v3/items/query?page=1&pageSize=25&queryString=project.id IN (3) AND tracker.id IN (8361) AND workItemStatus IN ('InProgress')"

payload={}
headers = {
  'Accept': 'application/json',
  'Authorization': 'Basic Ym9uZDowMDc='
}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)
