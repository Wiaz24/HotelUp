variable "aws_region" {
    type = string
    description = "AWS region"
}

variable "lab_role" {
    type = string
    description = "ARN of the IAM role to be used by the Lambda function"
}

variable "swagger_redirect_urls" {
    type = list(string)
    description = "List of swagger URLs to which the cognito should redirect"
    default = [
        "http://localhost:5000/api/customer/swagger/oauth2-redirect.html",
        "http://localhost:5001/api/repair/swagger/oauth2-redirect.html",
        "http://localhost:5002/api/employee/swagger/oauth2-redirect.html",
        "http://localhost:5003/api/information/swagger/oauth2-redirect.html",
        "http://localhost:5004/api/cleaning/swagger/oauth2-redirect.html",
        "http://localhost:5006/api/kitchen/swagger/oauth2-redirect.html",
        "http://localhost:5007/api/payment/swagger/oauth2-redirect.html"
        ]
}

variable "frontend_redirect_urls" {
    type = list(string)
    description = "List of frontend URLs to which the cognito should redirect"
    default = ["http://localhost:5173"]
}