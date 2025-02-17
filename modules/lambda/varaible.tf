variable "function_name" {
  description = "name for lambda fucntion"
  type        = string
}

variable "iam_role_arn" {
  description = "arn for certain iam role"
  type        = string
}

variable "s3_bucket_name" {
  description = "name or arn in S3 bucket"
  type        = string
}
