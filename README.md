# Terraform files to create alert to Slack in-bound webhook channel!

- Alert for any instance created with public IP.
- Alert for any unencrypted s3 bucket creation.
- Alert for Non MFA User login.
- Alert for change in security group(addition or revoking of rule).
- Alert for any unencrypted volume creation.
- Alert for any Elastic Ip creation or attaching.


# How to use

- create aws configure prior for key and secret.
- clone the repo.
- change the bucket name in : change directory to  aws_cloudtrail and variable.tf
- add slack inbound Webhook: change directory to python_lambda_function and change slack webhook URL in slack_message.py
- terraform init
- terraform plan
- terraform apply
