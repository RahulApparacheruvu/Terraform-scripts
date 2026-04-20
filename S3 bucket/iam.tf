#-----------------------------------------
# IAM User — for specific user access
#-----------------------------------------
resource "aws_iam_user" "s3_user" {
  name = "s3-backup-user"
  tags = { Name = "S3-Backup-User" }
}

#-----------------------------------------
# IAM Access Keys for the user
#-----------------------------------------
resource "aws_iam_access_key" "s3_user_key" {
  user = aws_iam_user.s3_user.name
}

#-----------------------------------------
# IAM Policy — what the user can do
#-----------------------------------------
resource "aws_iam_user_policy" "s3_user_policy" {
  name = "s3-backup-user-policy"
  user = aws_iam_user.s3_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # List all buckets
      {
        Effect   = "Allow"
        Action   = "s3:ListAllMyBuckets"
        Resource = "*"
      },

      # Full access to this specific bucket
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetObjectVersion",
          "s3:DeleteObjectVersion"
        ]
        Resource = [
          aws_s3_bucket.main.arn,
          "${aws_s3_bucket.main.arn}/*"
        ]
      }
    ]
  })
}