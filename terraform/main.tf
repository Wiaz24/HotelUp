# Configure AWS Provider
provider "aws" {
    region = "us-east-1"  # Change this to your desired region
    profile = "default"
}

module "cognito" {
    source = "./cognito"
    aws_region = var.aws_region
    lab_role = var.lab_role
    cognito_user_password = var.cognito_user_password
}