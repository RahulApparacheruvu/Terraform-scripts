variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Unique S3 Bucket Name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  default     = "dev"
}