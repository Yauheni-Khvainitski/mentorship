locals {
  datalake_bucket_name = "datalake-mentorship-bucket"
  transition_s3_storage_class = "STANDARD_IA"
  transition_days = 30
  expiration_days = 60
  versioning_status = "Disabled"
}