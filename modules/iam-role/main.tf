#IAM Role for Lambda 
resource "aws_iam_role" "lambda_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# create Iam role policy data 
data "aws_iam_policy_document" "polices" {
  version = "2012-10-17"
  # Allow Rekognition action
  statement {
    effect = "Allow"
    actions = [
      "rekognition:*"
    ]
    resources = ["*"]
  }

  # Allow S3 action 
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = ["*"]
  }

  # Allow SNS action 
  statement {
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = ["*"]
  }

  # Allow CloudWatch Logs actions 
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

# Create IAM Policy 
resource "aws_iam_policy" "custom_policy" {
  name        = "rekognition_s3_sns_policy"
  description = "Policy for Amazon Rekognition. S3, and SNS access"
  policy      = data.aws_iam_policy_document.polices.json
}

# Attach policy to IAM Role 
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.custom_policy.arn
}
