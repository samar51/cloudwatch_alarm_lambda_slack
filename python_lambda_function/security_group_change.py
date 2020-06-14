
################################################
#Function for change in  Security Group##########
################################################

import json
def get_security_group(filtered_log):
    action_on_SG=[]
    class SecurityGroupActivity:
        def __init__(self,message,User,security_group_id,security_activity):
            self.message = message
            self.User = User
            self.security_group_id = security_group_id
            self.security_activity = security_activity
    if not filtered_log['events']:
        return "Events List is Empty Or Events dint fetch,Please check ...."
    else:
        number_of_event=len(filtered_log['events'])
        for event_no in range(number_of_event):
            message = json.loads(filtered_log['events'][event_no]['message'])
            if (message['userIdentity']['type'] == "Root"):
                User="Root"
            else:
                User=message['userIdentity']['userName']
            if (message['eventName'] == "AuthorizeSecurityGroupIngress"):
                sgmessage="Security Group Inbound Added."
            else:
                sgmessage="Security Group Inbound Removed."

            sg_id = message['requestParameters']['groupId']
            sg_activity = message['requestParameters']['ipPermissions']

            action_on_SG.append(SecurityGroupActivity(sgmessage,User,sg_id,sg_activity))

        list_of_action_on_SG = [json.dumps(action.__dict__) for action in action_on_SG ]
        return list_of_action_on_SG
