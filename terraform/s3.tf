resource "aws_s3_bucket" "s3" {
  bucket = "beaver-excel-to-insert-query-application-bucket"   # bucket name
  tags = {
    Name = "beaver"
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.s3.id
  acl = "authenticated-read"
}

data "aws_iam_policy_document" "s3_iam_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cloudfront_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.s3_iam_policy.json
}