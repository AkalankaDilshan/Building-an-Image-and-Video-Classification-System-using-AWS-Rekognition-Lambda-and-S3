variable "bucket_prefix" {
  description = "prefix name for resource bucket"
  type        = string
}
variable "environment" {
  description = "environment for development"
  type        = string
  default     = "development"
}
