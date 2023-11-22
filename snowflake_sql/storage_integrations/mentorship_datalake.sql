CREATE OR REPLACE STORAGE INTEGRATION mentorship_datalake
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
-- TODO: create role with Terraform
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::538213298977:role/snowflake-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://datalake-mentorship-bucket/')
  COMMENT = 'Datalake S3 paths for the mentorship project';