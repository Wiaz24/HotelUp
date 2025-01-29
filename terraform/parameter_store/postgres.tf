locals {
    postgres_production_parameters = {
        "database"   = { type = "String", value = "${var.postgres-default-db}" }
        "user"       = { type = "String", value = "${var.postgres-default-user}" }
        "password"   = { type = "SecureString", value = "${var.postgres-default-password}" }
    }
}

resource "aws_ssm_parameter" "postgres_params" {
    for_each = local.postgres_production_parameters
    name        = "/HotelUp.Postgres/Production/${each.key}"
    description = "Production parameter"
    type        = each.value.type
    value       = each.value.value
    
    tier = "Standard"
    
    tags = {
        Environment = "Production"
        Application = "HotelUp.Postgres"
        ManagedBy   = "terraform"
    }
}