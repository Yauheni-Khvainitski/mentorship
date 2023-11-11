terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.24"
    }
  }

  required_version = ">= 1.2.0"

  # TODO: Add backend config to s3
  # check benefits of DynamoDB lock table
  #  backend "s3" {
  #    bucket         = "my-terraform-state-bucket"
  #    key            = "path/to/my/terraform.tfstate"
  #    region         = "us-east-1"
  #    encrypt        = true
  #    dynamodb_table = "my-lock-table"
  #  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Purpose = "Mentorship"
    }
  }
}
