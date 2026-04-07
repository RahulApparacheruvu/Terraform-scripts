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
  description = "AWS Region"
  default     = "us-central-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-020510cc1127d41e9"
}

variable "key_pair_name" {
  description = "Your AWS Key Pair Name"
  type        = string
}