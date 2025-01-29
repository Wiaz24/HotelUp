locals {
    pgadmin_production_parameters = {
        "email"     = { type = "String", value = "${var.pgadmin-default-email}" }
        "password"  = { type = "SecureString", value = "${var.pgadmin-default-password}" }
    }
}

resource "aws_ssm_parameter" "pgadmin_params" {
    for_each = local.pgadmin_production_parameters
    name        = "/HotelUp.Pgadmin/Production/${each.key}"
    description = "Production parameter"
    type        = each.value.type
    value       = each.value.value
    
    tier = "Standard"
    
    tags = {
        Environment = "Production"
        Application = "HotelUp.Pgadmin"
        ManagedBy   = "terraform"
    }
}