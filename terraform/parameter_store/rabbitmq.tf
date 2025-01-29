locals {
    rabbitmq_production_parameters = {
        "username"      = { type = "String", value = "${var.rabbitmq-default-username}" }
        "password"      = { type = "SecureString", value = "${var.rabbitmq-default-password}" }
    }
}

resource "aws_ssm_parameter" "rabbitmq_params" {
    for_each = local.rabbitmq_production_parameters
    name        = "/HotelUp.Rabbitmq/Production/${each.key}"
    description = "Production parameter"
    type        = each.value.type
    value       = each.value.value
    
    tier = "Standard"
    
    tags = {
        Environment = "Production"
        Application = "HotelUp.Rabbitmq"
        ManagedBy   = "terraform"
    }
}