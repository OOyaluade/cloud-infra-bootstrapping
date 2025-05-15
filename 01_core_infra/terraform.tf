terraform {
  backend "s3" {
    bucket = "caremesh-tf-2723"
    key    = "tfstatefiles"
    region = "us-east-1"
    use_lockfile = true


  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}