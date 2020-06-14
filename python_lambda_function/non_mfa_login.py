#Function for Non-Mfa user Logging################################################
#Event Filter { $.eventName = ConsoleLogin && $.additionalEventData.MFAUsed = No }
##################################################################################
import json
def get_NonMfa_user(filtered_log):
    nonmfa_userlogin=[]
    class NonMfaUser:
        def __init__(self,message,User):
            self.message = message
            self.User = User
    if not filtered_log['events']:
        return "Events List is Empty Or Events dint fetch check ...."
    else:
        number_of_event=len(filtered_log['events'])
        for event_no in range(number_of_event):
            message=json.loads(filtered_log['events'][0]['message'])
            if (message['userIdentity']['type'] == "Root"):
                User = "Root"
            else:
                User = message['userIdentity']['userName']
            nonmfa_userlogin.append(NonMfaUser("User Logged-in Without MFA",User))
        list_of_nonmfa_userlogin = [json.dumps(user.__dict__) for user in nonmfa_userlogin ]
        return list_of_nonmfa_userlogin
