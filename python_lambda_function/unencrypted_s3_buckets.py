##########################################################
####Function for Un-Encrypted bucket######################
#### {$.eventName=CreateBucket} ##########################
import boto3
import json
def get_unencrypted_bucket(filtered_log):
    Unecrypted_bucket=[]
    class UnecryptedBucket:
        def __init__(self,message,User,bucket_name):
            self.message = message
            self.User = User
            self.bucket_name = bucket_name

    if not filtered_log['events']:
        return "Events List is Empty Or Events dint fetch, Please check ...."
    else:
        number_of_event=len(filtered_log['events'])
        for event_no in range(number_of_event):
            message=json.loads(filtered_log['events'][event_no]['message'])
            bucket_name=message['requestParameters']['bucketName']
            s3 = boto3.client('s3')
            try:
                response = s3.get_bucket_encryption(
                Bucket=bucket_name
                )
            except:
                if (message['userIdentity']['type'] == "Root"):
                    User="Root"
                else:
                    User=message['userIdentity']['userName']
                Unecrypted_bucket.append(UnecryptedBucket("Un-encrypted Bucket",User,bucket_name))
        if not Unecrypted_bucket:
            pass
        else:
            list_of_Unecrypted_bucket = [json.dumps(unencryptbucket.__dict__) for unencryptbucket in Unecrypted_bucket ]
            return list_of_Unecrypted_bucket
