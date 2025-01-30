# Configure AWS Provider
provider "aws" {
    region = "us-east-1"  # Change this to your desired region
    profile = "wiaz"
}

module "cognito" {
    source = "./cognito"

    aws_region = var.aws_region
    cognito_user_password = var.cognito_user_password
}

# Depends on the cognito module
module "parameter_store" {
    source = "./parameter_store"

    api-gateway-url = "https://localhost"
    postgres-default-db = var.postgres-default-db
    postgres-default-user = var.postgres_default_user
    postgres-default-password = var.postgres_default_password
    pgadmin-default-email = var.pgadmin-default-email
    pgadmin-default-password = var.pgadmin-default-password
    cognito-user-pool-id = module.cognito.user_pool_id
    cognito-metadata-address = module.cognito.metadata_address
    cognito-authority = module.cognito.cognito_authority
    cognito-domain = module.cognito.cognito_domain
    frontend-client-id = module.cognito.frontend_client_id
    swagger-client-id = module.cognito.swagger_client_id
    swagger-client-secret = module.cognito.swagger_client_secret
    rabbitmq-default-username = var.rabbitmq_default_username
    rabbitmq-default-password = var.rabbitmq_default_password
    lambda-api-key = var.lambda_api_key
}

module "post_confirmation_lambda" {
    source = "./post_conf_lambda"

    cognito_user_pool_arn = module.cognito.user_pool_arn
    cognito_user_pool_id = module.cognito.user_pool_id
}