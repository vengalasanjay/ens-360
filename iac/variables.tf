variable "project" {
  description = "The project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
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
