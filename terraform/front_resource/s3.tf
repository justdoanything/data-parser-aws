resource "aws_s3_bucket" "s3" {
  bucket        = var.env_variable.s3.bucket_name
  force_destroy = true
  tags = {
    name = var.aws.author
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "PolicyForCloudFrontPrivateContent",
  "Statement": [
    {
      "Sid": "AllowCloudFrontServicePrincipal",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.s3.id}/*",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::${var.aws.account_id}:distribution/${aws_cloudfront_distribution.cloudfront_distribution.id}"
        }
      }
    }
  ]
}
EOF
}