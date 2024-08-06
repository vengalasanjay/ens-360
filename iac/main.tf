terraform {
  required_version = ">= 0.12"

  backend "s3" {
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

module "iam" {
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/iam?ref=main"
  rolename = var.rolename
}

module "s3" {
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/s3?ref=main"
  bucketname = var.bucketname
}

data "aws_s3_bucket" "existing" {
  bucket = var.bucketname
  depends_on = [module.s3]
}

resource "aws_s3_bucket_ownership_controls" "example" {
  depends_on = [module.s3]

  bucket = data.aws_s3_bucket.existing.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    module.s3
  ]

  bucket = data.aws_s3_bucket.existing.id
  acl    = "private"
}

module "lambda_iam_role" {
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/lambda/lambda_iam_role?ref=main"

  region    = var.region
  role_name = "lambda"
  tags      = {
    Environment = "Dev"
    Project     = "Sentrics"
  }
}






