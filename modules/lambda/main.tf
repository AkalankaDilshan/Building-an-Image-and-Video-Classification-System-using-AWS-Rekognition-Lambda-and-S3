resource "aws_lambda_function" "s3_trigger_lambda" {
  function_name = var.function_name
  role          = var.iam_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  #path to the lambda  code package
  filename         = "${path.module}/fucntion.zip"
  source_code_hash = filebase64sha256("${path.module}/function.zip")
}

# DynamoDB Stream Trigger for Lambda
resource "aws_lambda_event_source_mapping" "s3_trigger" {
  event_source_arn  = var.trigger_source_arn #here i added aws_s3_bucket.resource_bucket.arn
  function_name     = aws_lambda_function.s3_trigger_lambda.arn
  starting_position = "LATEST"
}
