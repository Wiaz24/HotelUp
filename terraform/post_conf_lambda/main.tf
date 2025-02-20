data "archive_file" "lambda_zip" {
    type        = "zip"
    source_file = "${path.module}/lambda_function.py"
    output_path = "${path.module}/lambda_function.zip"
}

# resource "local_file" "domain_cert" {
#     content  = var.domain_certificate_pem
#     filename = "${path.module}/certs/certificate.pem"
# }

# resource "null_resource" "archive_layer" {
#     provisioner "local-exec" {
#         command = <<-EOF
#             bash ${path.module}/archive_layer.sh
#         EOF
#     }
#     # depends_on = [ local_file.domain_cert]
# }

resource "aws_lambda_layer_version" "requests_layer" {
    filename            = "${path.module}/lambda-layer/lambda-layer.zip"  # Spakowana warstwa z requests i certyfikatem
    layer_name          = "requests_pika_layer"
    compatible_runtimes = ["python3.10"]
    
    description = "Layer containing pika library (RabbitMQ client) and SSL certificate"

    # depends_on = [ null_resource.archive_layer ]
}

# Lambda permissions to be triggered by Cognito
resource "aws_lambda_permission" "allow_cognito_invoke" {
    statement_id  = "AllowExecutionFromCognito"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.cognito_post_confirmation.function_name
    principal     = "cognito-idp.amazonaws.com"
    source_arn    = var.cognito_user_pool_arn
}

# Define Lambda function for Cognito Post Confirmation trigger
resource "aws_lambda_function" "cognito_post_confirmation" {
    function_name = "CognitoPostConfirmationHandler"
    handler       = "lambda_function.lambda_handler"
    runtime       = "python3.10"
    role          = var.lambda_role
    source_code_hash = data.archive_file.lambda_zip.output_base64sha256

    # Path to your Lambda code file
    filename        = data.archive_file.lambda_zip.output_path
    layers          = [aws_lambda_layer_version.requests_layer.arn]
    
    # Environment variables
    environment {
        variables = {
            USER_POOL_ID = var.cognito_user_pool_id
            TARGET_URL   = var.target_url
        }
    }
}