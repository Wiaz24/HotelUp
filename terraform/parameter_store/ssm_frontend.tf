locals {
    frontend_production_parameters = {
        "BackendUrl"            = { type = "String", value = "${var.api-gateway-url}" }
        "RedirectUrl"           = { type = "String", value = "${var.api-gateway-url}" }
        "LogoutUrl"             = { type = "String", value = "${var.api-gateway-url}" }
        "Oidc/CognitoAuthority" = { type = "String", value = "${var.cognito-authority}" }
        "Oidc/ClientId"         = { type = "String", value = "${var.frontend-client-id}" }
        "Oidc/CognitoDomain"    = { type = "String", value = "${var.cognito-domain}" }
    }
}

resource "aws_ssm_parameter" "frontend_docker_params" {
    for_each = local.frontend_production_parameters
    name        = "/HotelUp.Frontend/Production/${each.key}"
    description = "Production parameter"
    type        = each.value.type
    value       = each.value.value
    
    tier = "Standard"
    
    tags = {
        Environment = "Production"
        Application = "HotelUp.Frontend"
        ManagedBy   = "terraform"
    }
}