variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type = string
  default = "ami-0fc5d935ebf8bc3bc"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type = string
  default = "t2.micro"
}

variable "app_name" {
  description = "The name of the application"
  type = string
  default = "my-app"
}
