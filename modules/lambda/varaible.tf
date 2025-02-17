variable "function_name" {
  description = "name for lambda fucntion"
  type        = string
}

variable "iam_role_arn" {
  description = "arn for certain iam role"
  type        = string
}

variable "trigger_source_arn" {
  description = "arn for s3 bucket trigger"
  type        = string
}
