provider "aws" {
  region = "eu-north-1"
}

module "s3-bucket" {
  source        = "./modules/s3-bucket"
  bucket_prefix = "resource"
}
