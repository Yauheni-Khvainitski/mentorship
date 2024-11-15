variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "airflow_user_name" {
  description = "Username for the airflow backend database"
  type = string
}

variable "airflow_password" {
  description = "Password for the airflow backend database"
  type = string
}
