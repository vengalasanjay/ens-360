terraform {
  required_version = ">= 0.12"

  backend "s3" {
    # Add your S3 backend configuration here
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Declare the IAM role data source
data "aws_iam_role" "existing_role" {
  name = "sentrics" # Replace with the actual IAM role name
}
