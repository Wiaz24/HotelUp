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

module "post_confirmation_lambda" {
    source = "./post_conf_lambda"

    cognito_user_pool_arn = module.cognito.user_pool_arn
    cognito_user_pool_id = module.cognito.user_pool_id
}