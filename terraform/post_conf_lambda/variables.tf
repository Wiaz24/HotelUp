variable "cognito_user_pool_arn" {
    type = string
    description = "ARN of the Cognito User Pool"
    # default = "arn:aws:cognito-idp:us-east-1:658583182001:userpool/us-east-1_Y15zULckX"
}

variable "cognito_user_pool_id" {
    type = string
    description = "ID of the Cognito User Pool" 
}

variable "target_url" {
    type = string
    description = "URL to which the lambda function should send post confirmation data"
    default = "http://localhost:5000/api/customer/commands/publish-user-created-event"
}

variable "lambda_role" {
    type = string
    description = "ARN of the IAM role to be used by the Lambda function"
    default = "arn:aws:iam::539247454940:role/hotelup-lambda-role"
}