variable "aws_region" {
    type = string
    description = "AWS region"
}

variable "api_gateway_url" {
    type = string
    description = "URL of the API Gateway"
}

variable "cognito_user_password" {
    type = string
    description = "Password for the cognito user"
    sensitive = true
}
