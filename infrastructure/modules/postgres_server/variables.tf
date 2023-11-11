variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type = string
  # pre-created ami with postgres 14 installed
  default = "ami-0a6bf22d685e64482"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type = string
  default = "t2.micro"
}

variable "app_name" {
  description = "The name of the application"
  type = string
  default = "postgresql-server"
}

variable "postgres_security_group_name" {
  description = "The name of the security group for the postgres server"
  type = string
  default = "postgres-sg"
}
