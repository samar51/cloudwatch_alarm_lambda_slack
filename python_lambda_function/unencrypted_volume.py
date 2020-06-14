############################################################################
##Function unencrypted Volume###############################################
#{ $.eventName = CreateVolume && $.responseElements.encrypted IS FALSE }####
###########################################################################
import json
def get_unencrypted(filtered_log):
    unencrypedVolume=[]
    class NonEncryptedVolume:
        def __init__(self,message,User,Size_of_disk,Region):
            self.message = message
            self.User = User
            self.Size_of_disk = Size_of_disk
            self.Region = Region
    if not filtered_log['events']:
        return "Events List is Empty Or Events dint fetch, Please check ...."
    else:
        number_of_event=len(filtered_log['events'])
        for event_no in range(number_of_event):
            message=json.loads(filtered_log['events'][event_no]['message'])
            if (message['userIdentity']['type'] == "Root"):
                User="Root"
            else:
                User=message['userIdentity']['userName']
            unencrypedVolume.append(NonEncryptedVolume("Un-encrypted Volume is Created",User,message['requestParameters']['size'],message['awsRegion']))

        list_of_unencrypedVolume= [json.dumps(volume.__dict__) for volume in unencrypedVolume ]
        return list_of_unencrypedVolume
