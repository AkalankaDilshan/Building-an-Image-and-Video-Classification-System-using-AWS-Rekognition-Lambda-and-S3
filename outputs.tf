#get S3 bucket name
output "s3-bucket-name" {
  value = module.s3-bucket.bucket_name
}
