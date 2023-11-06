terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.24"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-04b107e90218672e5"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
