locals {
    kitchen_production_parameters = {
        "AWS/Cognito/UserPoolId"    = { type = "String", value = "${var.cognito-user-pool-id}" }
        "AllowedOrigins"            = { type = "StringList", value = "${var.allowed-origins-local}" }
        "MessageBroker/RabbitMQ/UserName"   = { type = "String", value = "${var.rabbitmq-default-username}" }
        "MessageBroker/RabbitMQ/Password"   = { type = "SecureString", value = "${var.rabbitmq-default-password}" }
        "Oidc/ClientSecret"         = { type = "SecureString", value = "${var.swagger-client-secret}" }
        "Oidc/ClientId"             = { type = "String", value = "${var.swagger-client-id}" }
        "Oidc/MetadataAddress"      = { type = "String", value = "${var.cognito-metadata-address}" }
        "Postgres/ConnectionString" = { type = "SecureString", value = "Host=postgres-service;Port=5432;Database=${var.postgres-default-db};Username=kitchen_user;Password=kitchen_${var.postgres-default-password}" }
    }
}

resource "aws_ssm_parameter" "kitchen_docker_params" {
    for_each = local.kitchen_production_parameters
    name        = "/HotelUp.Kitchen/Production/${each.key}"
    description = "Production parameter"
    type        = each.value.type
    value       = each.value.value
    
    tier = "Standard"
    
    tags = {
        Environment = "Production"
        Application = "HotelUp.Kitchen"
        ManagedBy   = "terraform"
    }
}