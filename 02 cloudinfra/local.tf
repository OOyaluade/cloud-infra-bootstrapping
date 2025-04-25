locals {
  vpc_cidr_block  = "172.16.0.0/16"
  vpc_cidr        = [for cidr_block in range(8) : cidrsubnet("172.16.0.0/16", 3, cidr_block)]
  private_subnets = slice(local.vpc_cidr, 4, 8)
  public_subnets  = slice(local.vpc_cidr, 0, 4)
  azs_private     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  azs_public      = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]

}

