resource "random_string" "bucket_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "resource_bucket" {
  bucket        = "${var.bucket_prefix}-${random_string.bucket_suffix}"
  force_destroy = true

  tags = {
    Name        = "image resource bucket"
    Environment = var.environment
  }
}
