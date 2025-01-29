variable "postgres-default-db" {
    description = "Default database for the postgres database"
    type        = string
    default     = "hotelup"
}

variable "postgres_default_user" {
    description = "Default user for the postgres database"
    type        = string
    default     = "postgres"
}

variable "postgres_default_password" {
    description = "Password for the default postgres user"
    type        = string
    sensitive   = true
}