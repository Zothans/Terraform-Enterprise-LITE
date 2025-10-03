provider "aws" {
  region = var.region
}

variable "region" {
  default = "ap-southeast-2"
}

variable "bucket_name" {
  type = string
}

resource "aws_s3_bucket" "demo" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "demo" {
  bucket = aws_s3_bucket.demo.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "demo" {
  depends_on = [aws_s3_bucket_ownership_controls.demo]
  bucket = aws_s3_bucket.demo.id
  acl    = "private"
}

output "bucket_name" {
  value = aws_s3_bucket.demo.bucket
}
