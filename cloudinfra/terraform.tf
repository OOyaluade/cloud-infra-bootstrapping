terraform {
  backend "s3" {
    bucket = local.bucket_name
    key = "tfstatefiles"
    
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}