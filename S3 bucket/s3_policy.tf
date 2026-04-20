#-----------------------------------------
# Bucket Policy
# Controls who can access what
#-----------------------------------------
resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # Statement 1 — Public read access for /public/ folder only
      {
        Sid       = "PublicReadForPublicFolder"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.main.arn}/public/*"
      },

      # Statement 2 — Full access for bucket owner (your AWS account)
      {
        Sid       = "OwnerFullAccess"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "s3:*"
        Resource = [
          aws_s3_bucket.main.arn,
          "${aws_s3_bucket.main.arn}/*"
        ]
      },

      # Statement 3 — IAM user access (read/write to /uploads/ folder)
      {
        Sid       = "IAMUserAccess"
        Effect    = "Allow"
        Principal = {
          AWS = aws_iam_user.s3_user.arn
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.main.arn,
          "${aws_s3_bucket.main.arn}/*"
        ]
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.main]
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}