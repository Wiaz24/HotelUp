locals {
  encoded_password = replace(replace(var.postgres-default-password, "@", "%40"), "#", "%23")
}

locals {
    repair_production_parameters = {
        "MessageBroker/RabbitMQ/UserName"   = { type = "String", value = "${var.rabbitmq-default-username}" }
        "MessageBroker/RabbitMQ/Password"   = { type = "SecureString", value = "${var.rabbitmq-default-password}" }
        "Oidc/ClientSecret"         = { type = "SecureString", value = "${var.swagger-client-secret}" }
        "Oidc/ClientId"             = { type = "String", value = "${var.swagger-client-id}" }
        "Oidc/MetadataAddress"      = { type = "String", value = "${var.cognito-metadata-address}" }
        "Postgres/ConnectionString" = { type = "SecureString", value = "postgresql://repair_user:repair_${local.encoded_password}@postgres-service:5432/${var.postgres-default-db}" }
    }
}

resource "aws_ssm_parameter" "repair_docker_params" {
    for_each = local.repair_production_parameters
    name        = "/HotelUp.Repair/Production/${each.key}"
    description = "Production parameter"
    type        = each.value.type
    value       = each.value.value
    
    tier = "Standard"
    
    tags = {
        Environment = "Production"
        Application = "HotelUp.Repair"
        ManagedBy   = "terraform"
    }
}