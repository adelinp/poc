resource "aws_lambda_function" "backend" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = var.iam_role_arn
  filename      = "lambda.zip"

  environment {
    variables = {
      DB_HOST     = var.db_endpoint
      DB_USER     = var.db_username
      DB_PASSWORD = var.db_password
      DB_NAME     = "3tierDB"
    }
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.security_group_id]
  }
}
