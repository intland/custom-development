import http.client
import mimetypes
from codecs import encode

conn = http.client.HTTPConnection("localhost", 8080)
dataList = []
boundary = 'wL36Yn8afVp8Ag7AmP8qZ0SA4n1v9T'
dataList.append(encode('--' + boundary))
dataList.append(encode('Content-Disposition: form-data; name=comment;'))

dataList.append(encode('Content-Type: {}'.format('text/plain')))
dataList.append(encode(''))

dataList.append(encode("My first comment"))
dataList.append(encode('--' + boundary))
dataList.append(encode('Content-Disposition: form-data; name=commentFormat;'))

dataList.append(encode('Content-Type: {}'.format('text/plain')))
dataList.append(encode(''))

dataList.append(encode("PlainText"))
dataList.append(encode('--'+boundary+'--'))
dataList.append(encode(''))
body = b'\r\n'.join(dataList)
payload = body
headers = {
  'Accept': 'application/json',
  'Authorization': 'Basic Ym9uZDowMDc=',
  'Content-type': 'multipart/form-data; boundary={}'.format(boundary)
}
conn.request("POST", "/cb/api/v3/items/2319/comments", payload, headers)
res = conn.getresponse()
data = res.read()
print(data.decode("utf-8"))