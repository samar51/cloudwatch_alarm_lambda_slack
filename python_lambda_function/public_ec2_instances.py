###########################################################
###Function For ec2 Instance with Public IP ###
###{ $.eventName = RunInstances }
##########################################################

import boto3
import json
def get_ec2_public(filtered_log):
    public_instances=[]
    class PublicInstance:
        def __init__(self,message,User,Region,availabilityZone,Instance_Id,Public_Ip):
            self.message = message
            self.User = User
            self.Region = Region
            self.availabilityZone = availabilityZone
            self.Instance_Id = Instance_Id
            self.Public_Ip = Public_Ip

    if not filtered_log['events']:
        return "Events List is Empty Or Events dint fetch, Please check ...."
    else:
        number_of_event=len(filtered_log['events'])
        for event_no in range(number_of_event):
            message=json.loads(filtered_log['events'][event_no]['message'])
            for i in range(len(message['responseElements']['instancesSet']['items'])):
                instance_id=message['responseElements']['instancesSet']['items'][i]['instanceId']
                #print(instance_id)
                ec2 = boto3.client('ec2')
                try:
                    if (message['userIdentity']['type'] == "Root"):
                        User="Root"
                    else:
                        User=message['userIdentity']['userName']
                    Region=message['awsRegion']
                    availabilityZone=message['responseElements']['instancesSet']['items'][i]['placement']['availabilityZone']
                    response = ec2.describe_instances(
                    InstanceIds=[
                        instance_id
                    ])

                    Public_Ip=response['Reservations'][0]['Instances'][0]['PublicIpAddress']
                    public_instances.append(PublicInstance("Instance With Public IP Created",User,Region,availabilityZone,instance_id,Public_Ip))
                    #print(public_instances)

                except:
                    pass
        if not public_instances:
            pass
        else:
            list_of_public_instance = [json.dumps(publicinstance.__dict__) for publicinstance in public_instances ]
            return list_of_public_instance
