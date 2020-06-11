variable "nonmfa_metric_name" {
  description = "metric name of Non Mfa Login"
  type        = "string"
}

variable "nonmfa_metric_namespace" {
  description = "Non Mfa Login Namespace"
  type        = "string"
}

variable "unencryptedvolume_metric_name" {
  description = "metric name of Unencrypted Volume"
  type        = "string"
}

variable "unencryptedvolume_metric_namespace" {
  description = "Unencrypted Volume Namespace"
  type        = "string"
}


variable "elasticip_metric_name" {
  description = "metric name of Elastic IP"
  type        = "string"
}

variable "elasticip_metric_namespace" {
  description = "Elastic IP Namespace"
  type        = "string"
}

variable "public_ec2_metric_name" {
  description = "metric name of public ec2 instances"
  type        = "string"
}

variable "public_ec2_metric_namespace" {
  description = "public ec2 instances Namespace"
  type        = "string"
}

variable "unencrypted_bucket_metric_name" {
  description = "metric name of unencrypted bucket"
  type        = "string"
}

variable "unencrypted_bucket_metric_namespace" {
  description = "unencrypted bucketNamespace"
  type        = "string"
}

variable "securitygroup_activity_metric_name" {
  description = "metric name of security group activity"
  type        = "string"
}

variable "securitygroup_activity_metric_namespace" {
  description = "metric namespace of security group activity"
  type        = "string"
}


variable "sns_topic" {
  description = "SNS Topic"
  type        = "string"
}
