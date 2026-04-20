output "bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "S3 Bucket ARN"
  value       = aws_s3_bucket.main.arn
}

output "bucket_domain_name" {
  description = "S3 Bucket Domain"
  value       = aws_s3_bucket.main.bucket_domain_name
}

output "iam_user_name" {
  description = "IAM User for S3 access"
  value       = aws_iam_user.s3_user.name
}

output "iam_user_access_key" {
  description = "IAM User Access Key"
  value       = aws_iam_access_key.s3_user_key.id
}

output "iam_user_secret_key" {
  description = "IAM User Secret Key"
  sensitive   = true
  value       = aws_iam_access_key.s3_user_key.secret
}