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
  bucket        = var.bucket_name
  force_destroy = true
}
