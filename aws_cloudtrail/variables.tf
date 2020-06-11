variable "cloudwatch_log_group_arn" {
  description = "Log Group ARN"
  type        = "string"
}

variable "cloudwatch_log_group_role_arn" {
  description = "Log Group Role ARN"
  type        = "string"
}

variable "cloudwatch_s3_bucket" {
  description = "cloudwatch s3 bucket"
  type        = "string"
  default     = "cloudtraillog-for-alert-bucket-v1"
}
