# References: https://stackoverflow.com/questions/76049290/error-accesscontrollistnotsupported-when-trying-to-create-a-bucket-acl-in-aws

resource "aws_s3_bucket" "state-bucket-manjiro" {
  # Name bucket must unique
  bucket = "state-bucket-manjiro"

  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "S3 bucket for saving state file"
  }
}

# A resource to enable versioning on bucket
resource "aws_s3_bucket_versioning" "version-s3" {
  bucket = aws_s3_bucket.state-bucket-manjiro.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

# Encryption configuration for S3
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption-s3" {
  bucket = aws_s3_bucket.state-bucket-manjiro.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket     = aws_s3_bucket.state-bucket-manjiro.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.state-bucket-manjiro.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "public-block-s3" {
  bucket = aws_s3_bucket.state-bucket-manjiro.bucket

  # List Acccess control list
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}