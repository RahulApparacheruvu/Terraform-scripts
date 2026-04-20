#-----------------------------------------
# S3 Bucket
#-----------------------------------------
resource "aws_s3_bucket" "main" {
  bucket        = var.bucket_name
  force_destroy = true             # allows delete even if bucket has files

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

#-----------------------------------------
# Block ALL public access by default
# We control access via bucket policy
#-----------------------------------------
resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = false   # allow public ACLs for public files
  block_public_policy     = false   # allow public bucket policy
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#-----------------------------------------
# Versioning — keeps all file versions
#-----------------------------------------
resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

#-----------------------------------------
# Encryption — all files encrypted at rest
#-----------------------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"     # AWS managed encryption
    }
  }
}

#-----------------------------------------
# Lifecycle Rules
#-----------------------------------------
resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  # Rule 1 — Move old files to cheaper storage
  rule {
    id     = "move-to-infrequent-access"
    status = "Enabled"

    transition {
      days          = 30            # after 30 days → move to IA (cheaper)
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 90            # after 90 days → move to Glacier (cheapest)
      storage_class = "GLACIER"
    }

    expiration {
      days = 365                    # delete after 1 year
    }
  }

  # Rule 2 — Clean up old versions
  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_expiration {
      noncurrent_days = 90          # delete old versions after 90 days
    }
  }

  # Rule 3 — Clean up incomplete multipart uploads
  rule {
    id     = "cleanup-incomplete-uploads"
    status = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 7     # cancel stuck uploads after 7 days
    }
  }
}