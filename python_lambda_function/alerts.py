import json
import boto3

def get_alarm_log_fromCWL(message,metricFilterData):
    from datetime import datetime
    logs = boto3.client('logs')
    time_stamp=datetime.strptime(message['StateChangeTime'],'%Y-%m-%dT%H:%M:%S.%f%z')
    time_stamp=int(time_stamp.timestamp()*1000)
    offset=(message['Trigger']['Period'] * message['Trigger']['EvaluationPeriods'] * 2000)
    metricFilter = metricFilterData['metricFilters'][0]
    filter_response = logs.filter_log_events(
        logGroupName=metricFilterData['metricFilters'][0]['logGroupName'],
        filterPattern=metricFilterData['metricFilters'][0]['filterPattern'],
        startTime=time_stamp-offset,
        endTime=time_stamp
        )
    return filter_response

def lambda_handler(event, context):
    logs = boto3.client('logs')
    message=json.loads(event['Records'][0]['Sns']['Message'])
    alarmName=message['AlarmName']
    oldState=message['OldStateValue']
    newState=message['NewStateValue']
    reason=message['NewStateReason']
    metricname=message['Trigger']['MetricName']
    metricnamespace=message['Trigger']['Namespace']

    metric_filter_response = logs.describe_metric_filters(
        metricName=metricname,
        metricNamespace=metricnamespace
    )

    filtered_log=get_alarm_log_fromCWL(message,metric_filter_response)

    from slack_message import send_slack_message

    if alarmName == "NO_MFA":
        from non_mfa_login import get_NonMfa_user
        response=get_NonMfa_user(filtered_log)
        if response is not None and type(response) == list:
            slack_response=send_slack_message(response)
            print(slack_response)
        else:
            print("No Message To Send")
    elif alarmName ==  "UN_ENCRYPTED_VOLUME":
        from unencrypted_volume import get_unencrypted
        response=get_unencrypted(filtered_log)
        if response is not None and type(response) == list:
            slack_response=send_slack_message(response)
            print(slack_response)
        else:
            print("No Message To Send")

    elif alarmName == "ELASTIC_IP":
        from elastic_ip import get_elastic_ip
        response=get_elastic_ip(filtered_log)
        if response is not None and type(response) == list:
            slack_response=send_slack_message(response)
            print(slack_response)
        else:
            print("No Message To Send")
    elif alarmName == "SECURITYGROUP_ACTIVITY":
        from security_group_change import get_security_group
        response=get_security_group(filtered_log)
        if response is not None and type(response) == list:
            slack_response=send_slack_message(response)
            print(slack_response)
        else:
            print("No Message To Send")
    elif alarmName == "PUBLIC_EC2":
        from public_ec2_instances import get_ec2_public
        response=get_ec2_public(filtered_log)
        if response is not None and type(response) == list:
            slack_response=send_slack_message(response)
            print(slack_response)
        else:
            print("No Message To Send")
    elif alarmName == "UNENCRYPTED_BUCKET":
        from unencrypted_s3_buckets import get_unencrypted_bucket
        response=get_unencrypted_bucket(filtered_log)
        if response is not None and type(response) == list:
            slack_response=send_slack_message(response)
            print(slack_response)
        else:
            print("No Message To Send")
    else:
        print("No Message to send")

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
