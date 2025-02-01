variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "us-east-1"
}

variable "api_gateway_url" {
    description = "URL of the API Gateway"
    type        = string
    default = "https://a8068b321814c427c8b6784a65c47cc8-964586252.us-east-1.elb.amazonaws.com"
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

variable "lambda_api_key" {
    description = "API key for the lambda"
    type        = string
    sensitive   = true
}