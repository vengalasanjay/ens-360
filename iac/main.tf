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

module "iam" {
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/iam?ref=main"
  rolename = var.rolename
}

module "gluejob" {
  depends_on = [module.iam,module.s3]
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/gluejob?ref=main"
  iam_role_arn = module.iam.myrole_arn
  glue_job_script_locations = var.glue_job_script_locations
}

module "gluecrawler" {
  depends_on = [module.iam,module.s3,module.lambda_iam_role,module.lambda_function,module.iam-sfn,module.sfn]
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/gluecrawler?ref=main"
  iam_role_arn = module.iam.myrole_arn
  bucket_name  = module.s3.bucket_name
}

module "s3" {
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/s3?ref=main"
  project = var.project
  environment = var.environment
  bucketname = var.bucketname
}

data "aws_s3_bucket" "existing" {
  bucket = "dashboard-sl-non-prod-345"
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

  region    = "us-east-1"
  role_name = "lambda"
  tags      = {
    Environment = "Dev"
    Project     = "Sentrics"
  }
}

module "lambda_function" {
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/lambda/lambda_function?ref=main"

  region                  = "us-east-1"
  lambda_function_name    = "ensure360-dashboard-qs-dev-dev-01"
  lambda_role_arn         = module.lambda_iam_role.role_arn
  lambda_source_file      = "./lambda.js"  
  lambda_output_path      = "./lambda_function_payload.zip"
  lambda_handler          = "lambda.handler"
  lambda_runtime          = "nodejs18.x"
  lambda_environment_vars = {
    environment = "dev"
  }
}

module "iam-sfn" {
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/iam-step-function/iam-sfn?ref=main"
  role_name   = "step_function_role"
  policy_name = "step_function_policy"
}

module "sfn" {
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/iam-step-function/sfn?ref=main"
  state_machine_name = "ens-360-dashboard-wf-dev"
  role_arn           = module.iam-sfn.step_function_role_arn
}
