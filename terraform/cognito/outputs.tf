output "user_pool_id" {
    description = "ID of the Cognito user pool"
    value       = aws_cognito_user_pool.main.id
}

output "frontend_client_id" {
    description = "ID of the Cognito frontend client"
    value       = aws_cognito_user_pool_client.frontend_client.id
}

output "swagger_client_id" {
    description = "ID of the Cognito swagger client"
    value       = aws_cognito_user_pool_client.swagger_client.id
}

output "swagger_client_secret" {
    description = "Secret of the Cognito swagger client"
    value       = aws_cognito_user_pool_client.swagger_client.client_secret
}

output "user_types" {
    description = "List of user types"
    value       = local.UserTypes
}

output "user_pool_arn" {
    description = "ARN of the Cognito user pool"
    value       = aws_cognito_user_pool.main.arn
}

output "metadata_address" {
    description = "Metadata address of the Cognito user pool"
    value       = "https://cognito-idp.us-east-1.amazonaws.com/${aws_cognito_user_pool.main.id}/.well-known/openid-configuration"
}