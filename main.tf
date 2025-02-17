provider "aws" {
  region = "eu-north-1"
}

module "s3-bucket" {
  source        = "./modules/s3-bucket"
  bucket_prefix = "resource"
}

module "iam-role" {
  source    = "./modules/iam-role"
  role_name = "lambda_rekognition_s3_sns_role"
}
