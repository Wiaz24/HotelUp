variable "rabbitmq-default-username" {
    type = string
    description = "The default username of the rabbitmq"
}

variable "rabbitmq-default-password" {
    type = string
    sensitive = true
    description = "The default password of the rabbitmq"
}

variable "postgres-default-user" {
    type = string
    description = "The default username of the postgres"
}

variable "postgres-default-password" {
    type = string
    sensitive = true
    description = "The default password of the postgres"
}

variable "postgres-default-db" {
    type = string
    description = "The default database of the postgres"
}

variable "pgadmin-default-email" {
    type = string
    description = "The default email of the pgadmin"
}

variable "pgadmin-default-password" {
    type = string
    sensitive = true
    description = "The default password of the pgadmin"
}

variable "cognito-user-pool-id" {
    type = string
    description = "The cognito user pool id"
}

variable "cognito-metadata-address" {
    type = string
    description = "The metadata address of the OIDC provider"
}

variable "swagger-client-id" {
    type = string
    description = "The client id of the swagger"
}

variable "swagger-client-secret" {
    type = string
    sensitive = true
    description = "The client secret of the swagger"
}