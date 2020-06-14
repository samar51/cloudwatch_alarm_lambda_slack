from botocore.vendored import requests
import json

def send_slack_message(message):
    #slack webhook url
    wekbook_url = 'put slack webhook here'
    data = {
        'text': str(message),
        'icon_emoji': ':bangbang:'
    }

    response = requests.post(wekbook_url, data=json.dumps(
        data), headers={'Content-Type': 'application/json'})
    return response
