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
  region = "us-east-1"
}

module "s3-module" {
  source = "git::https://git-codecommit.us-east-1.amazonaws.com/v1/repos/terraform.git//s3"
  project = var.project
  environment = var.environment
  bucketname = var.bucketname
}
module "iam-module" {
  source = "git::https://git-codecommit.us-east-1.amazonaws.com/v1/repos/terraform.git//iam"
  rolename = var.rolename
}
module "glujob-module" {
  source = "git::https://git-codecommit.us-east-1.amazonaws.com/v1/repos/terraform.git//gluejob"
  iam_role_arn = var.iam_role_arn
  glue_job_script_locations = var.glue_job_script_locations
}
module "gluecrawler-module" {
  source = "git::https://git-codecommit.us-east-1.amazonaws.com/v1/repos/terraform.git//gluecrawler"
  iam_role_arn = var.iam_role_arn
  bucket_name = var.bucket_name
  crawlers = var.crawlers
}






