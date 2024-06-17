terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.52.0"
    }
  }
  backend "s3" {
    bucket  = "rocketseat-state-bucket-tf-brsantos197"
    region  = "us-east-2"
    key     = "terraform.tfstate"
    encrypt = true
    profile = "brsantos197"
  }
}

provider "aws" {
  profile = "brsantos197"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [
    aws_s3_bucket.terraform_state
  ]
}