variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "us-east-1"
}

variable "lab_role" {
    description = "ARN of the IAM role that has all the necessary permissions for the lab"
    type        = string
    default     = "arn:aws:iam::658583182001:role/LabRole"
}