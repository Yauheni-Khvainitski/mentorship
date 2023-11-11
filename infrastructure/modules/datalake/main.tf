resource "aws_s3_bucket" "datalake_bucket" {
  bucket = local.datalake_bucket_name
}

resource "aws_s3_bucket_lifecycle_configuration" "datalake_lifecycle_config" {
  bucket = aws_s3_bucket.datalake_bucket.id

  rule {
    id = "expiration_rule"

    filter {}

    transition {
      days          = local.transition_days
      storage_class = local.transition_s3_storage_class
    }

    expiration {
      days = local.expiration_days
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "datalake_versioning_config" {
  bucket = aws_s3_bucket.datalake_bucket.id
  versioning_configuration {
    status = local.versioning_status
  }
}
