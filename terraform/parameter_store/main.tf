variable "allowed-origins-local" {
    type = string
    description = "The allowed origins for the CORS policy"
    default = "http://localhost:5173, http://localhost:5002, http://localhost, https://localhost"
}