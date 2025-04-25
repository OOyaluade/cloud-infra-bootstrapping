terraform {
  backend "s3" {
    bucket = module.backend.var.bucket_name
    
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