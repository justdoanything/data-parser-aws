resource "aws_s3_bucket" "s3" {
  bucket        = var.env_variable.s3.bucket_name
  force_destroy = true
  tags = {
    name = var.aws.author
  }
}