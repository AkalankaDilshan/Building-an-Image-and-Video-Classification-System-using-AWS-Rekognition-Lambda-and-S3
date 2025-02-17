resource "aws_lamda_function" "s3_trigger_lambda" {
  function_name = var.function_name
  role          = var.iam_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

}
