variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "The AWS region to deploy resources in."
}

variable "aws_account_id" {
  type        = number
  description = "The AWS account ID where resources will be deployed."
}