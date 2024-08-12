module "gluejob" {
  # depends_on = [module.iam, module.s3]
  source                    = "git::https://github.com/satuluriakhil420/terraform.git//modules/gluejob?ref=main"
  iam_role_arn              = data.aws_iam_role.existing_role.arn
  glue_job_script_locations = var.glue_job_script_locations
}

output "glue_job_names" {
  value = module.gluejob.glue_job_names
}

module "gluecrawler" {
  depends_on = [
    module.lambda_iam_role,
    module.lambda_function,
    module.iam-sfn,
    module.sfn
  ]
  source       = "git::https://github.com/satuluriakhil420/terraform.git//modules/gluecrawler?ref=main"
  iam_role_arn = data.aws_iam_role.existing_role.arn
  bucket_name  = var.bucketname
  crawlers     = var.crawlers
}

module "lambda_iam_role" {
  source = "git::https://github.com/satuluriakhil420/terraform.git//modules/lambda/lambda_iam_role?ref=main"

  region    = var.region
  role_name = "lambda"
  tags      = {
    Environment = var.environment
    Project     = "Sentrics"
  }
}

module "lambda_function" {
  source                  = "git::https://github.com/satuluriakhil420/terraform.git//modules/lambda/lambda_function?ref=main"
  region                  = var.region
  lambda_function_name    = var.lambda_function_name
  lambda_role_arn         = module.lambda_iam_role.lambda_iam_role
  lambda_source_file      = "./lambda.js"
  lambda_output_path      = "./lambda_function_payload.zip"
  lambda_handler          = "lambda.handler"
  lambda_runtime          = "nodejs18.x"
  lambda_environment_vars = {
    environment = var.environment
  }
}

module "iam-sfn" {
  source      = "git::https://github.com/satuluriakhil420/terraform.git//modules/iam-step-function/iam-sfn?ref=main"
  role_name   = var.sfn_role
  policy_name = var.sfn_policy
}

module "sfn" {
  source         = "git::https://github.com/satuluriakhil420/terraform.git//modules/iam-step-function/sfn?ref=main"
  state_machines = var.state_machines
  role_arn       = module.iam-sfn.step_function_role_arn
}
