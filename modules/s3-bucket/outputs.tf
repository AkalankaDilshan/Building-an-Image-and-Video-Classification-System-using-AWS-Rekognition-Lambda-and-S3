output "bucket_name" {
  value = aws_s3_bucket.resource_bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.resource_bucket.arn
}
