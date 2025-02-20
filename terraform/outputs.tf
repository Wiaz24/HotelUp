output "cognito_user_pool_id" {
    value = module.cognito.user_pool_id
}

output "cognito_authority" {
    value = module.cognito.cognito_authority
}

output "cognito_domain" {
    value = module.cognito.cognito_domain
}

output "cognito_swagger_client_id" {
    value = module.cognito.swagger_client_id
}

output "cognito_swagger_client_secret" {
    sensitive = true
    value = module.cognito.swagger_client_secret
}

output "cognito_frontend_client_id" {
    value = module.cognito.frontend_client_id
}