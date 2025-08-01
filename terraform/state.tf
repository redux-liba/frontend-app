provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket         = "liba-tfm-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-reactapp-tfstate-locking"
    encrypt        = true
  }
}
