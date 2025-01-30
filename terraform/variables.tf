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

variable "cognito_user_password" {
    description = "Password for the cognito user"
    type        = string
    sensitive   = true
}

variable "target_url" {
    description = "URL of the target API"
    type        = string
    default     = "https://jsonplaceholder.typicode.com/posts"
}

variable "lambda_api_key" {
    description = "API key for the lambda"
    type        = string
    sensitive   = true
}