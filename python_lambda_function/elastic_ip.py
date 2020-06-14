####################################################################
###Function For Elastic IP AllocateAddress##########################
#{ $.eventName = AssociateAddress || $.eventName = AllocateAddress }
####################################################################
###for checking if the elastic ip is created or assoicted###########

import json
def get_elastic_ip(filtered_log):
    elastic_ips=[]
    class ElasticIp:
        def __init__(self,message,User,Elastic_IP,Instance_id):
            self.message = message
            self.User = User
            self.Elastic_IP = Elastic_IP
            self.Instance_id = Instance_id
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
            if (message['eventName'] == 'AssociateAddress'):
                elastic_ip = "!!!!check the instance to get the elastic ip.."
                instance_id = message['requestParameters']['instanceId']
                messageslack = "Elastic IP is Attached To An Instance"
            else:
                messageslack = "ELasticIP is Created!!!!"
                instance_id = "ElasticIP Not Yet Associated to Instance..."
                elastic_ip = message['responseElements']['publicIp']
            elastic_ips.append(ElasticIp(messageslack,User,elastic_ip,instance_id))
        list_of_elasticip = [json.dumps(elasticip.__dict__) for elasticip in elastic_ips ]
        return list_of_elasticip
