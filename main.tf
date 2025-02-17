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

module "lambda_function" {
  source         = "./modules/lambda"
  function_name  = "image-classification-function"
  iam_role_arn   = module.iam-role.lambda_role_arn
  s3_bucket_name = module.s3-bucket.bucket_name
  depends_on     = [module.iam-role, module.s3-bucket]
}
