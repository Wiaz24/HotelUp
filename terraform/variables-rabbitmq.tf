variable "rabbitmq_default_username" {
    description = "Username for the default rabbitmq user"
    type        = string
    default     = "admin"
}

variable "rabbitmq_default_password" {
    description = "Password for the default rabbitmq user"
    type        = string
    sensitive   = true
}