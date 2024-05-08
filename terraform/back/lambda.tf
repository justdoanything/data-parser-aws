resource "aws_iam_role" "iam_role_lambda" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda" {
  function_name = var.env_variable.lambda.function_name
  s3_bucket     = var.env_variable.s3.bucket_name
  s3_key        = var.lambda.jar_name
  handler       = var.lambda.handler
  runtime       = var.lambda.runtime
  role          = aws_iam_role.iam_role_lambda.arn
}