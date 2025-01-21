resource "aws_cognito_user_pool_domain" "main" {
    domain       = "hotelup"
    user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_pool" "main" {
    name = "hotelup-users"

    # Username configuration
    username_attributes      = ["email"]
    auto_verified_attributes = ["email"]
    
    # Password policy
    password_policy {
        minimum_length                   = 8
        require_lowercase               = true
        require_numbers                 = true
        require_symbols                 = true
        require_uppercase               = true
        temporary_password_validity_days = 7
    }

    # Email configuration
    email_configuration {
        email_sending_account = "COGNITO_DEFAULT"
    }

    # Account recovery setting
    account_recovery_setting {
        recovery_mechanism {
            name     = "verified_email"
            priority = 1
        }
    }

    # MFA configuration
    mfa_configuration = "OFF"

    # Email verification message
    verification_message_template {
        default_email_option = "CONFIRM_WITH_CODE"
        email_subject       = "Your verification code"
        email_message      = "Your verification code is {####}"
    }

    # Schema attributes
    schema {
        name                = "email"
        attribute_data_type = "String"
        required            = true
        mutable            = true

        string_attribute_constraints {
        min_length = 0
        max_length = 2048
        }
    }

    # lambda_config {
    #     post_confirmation = aws_lambda_function.cognito_post_confirmation.arn
    # }
}

resource "aws_cognito_user_pool_client" "frontend_client" {
    name         = "frontend-client"
    user_pool_id = aws_cognito_user_pool.main.id

    allowed_oauth_flows_user_pool_client = true
    allowed_oauth_flows = ["code"]
    allowed_oauth_scopes = ["email", "openid", "phone"]

    callback_urls   = var.frontend_redirect_urls
    logout_urls     = var.frontend_redirect_urls

    generate_secret = false
    
    explicit_auth_flows = [
        "ALLOW_USER_AUTH",
        "ALLOW_REFRESH_TOKEN_AUTH",
        "ALLOW_USER_SRP_AUTH"
    ]
    supported_identity_providers = ["COGNITO"]
}

resource "aws_cognito_user_group" "Clients" {
    name         = "Clients"
    user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_group" "Cleaners" {
    name         = "Cleaners"
    user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_group" "Janitors" {
    name         = "Janitors"
    user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_group" "Cooks" {
    name         = "Cooks"
    user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_group" "Receptionists" {
    name         = "Receptionists"
    user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_group" "Admins" {
    name         = "Admins"
    user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_pool_client" "swagger_client" {
    name         = "swagger-client"
    user_pool_id = aws_cognito_user_pool.main.id

    allowed_oauth_flows_user_pool_client = true
    allowed_oauth_flows = ["code"]
    allowed_oauth_scopes = ["email", "openid", "phone"]

    callback_urls   = var.swagger_redirect_urls
    # logout_urls     = var.swagger_redirect_urls

    generate_secret = true
    
    explicit_auth_flows = [
        "ALLOW_USER_AUTH",
        "ALLOW_REFRESH_TOKEN_AUTH",
        "ALLOW_USER_SRP_AUTH"
    ]
    supported_identity_providers = ["COGNITO"]
}


