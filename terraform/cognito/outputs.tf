output "cognito_user_pool_id" {
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

output "user_emails" {
    description = "List of user emails"
    value       = [for user in aws_cognito_user.users : user.value.attributes.email]
}