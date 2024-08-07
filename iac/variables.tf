variable "project" {
  description = "The project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}
variable "region" {
  description = "AWS region"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
}

variable "bucketname" {
  description = "The name of the S3 bucket"
  type        = string
}
variable "rolename" {
  description = "Creation of IAM role"
  type        = string
}

variable "glue_job_script_locations" {
  type    = list(string)
}
variable "bucket_name" {
  description = "The Name of s3 destination bucker"
  type        = string
}

variable "crawlers" {
  description = "List of crawlers"
  type = list(object({
    name       = string
    s3_targets = list(string)
    db_name    = string
  }))
}
variable "state_machines" {
  description = "List of state machines"
  type = list(object({
    name       = string
    definition = string
  }))
}

variable "snf_role" {
  description = "Name of the IAM role"
}

variable "snf_policy" {
  description = "Name of the IAM policy"
}

