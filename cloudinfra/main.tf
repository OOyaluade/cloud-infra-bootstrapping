module "vpc" {
  
  source          = "./modules/vpc"
  public_subnets = [
  "10.0.1.0/24", # AZ1
  "10.0.2.0/24"  # AZ2
]
  private_subnets = [
  "10.0.101.0/24", # AZ1
  "10.0.102.0/24"  # AZ2
]
  azs_public      = ["us-east-1a", "us-east-1b"]
  azs_private     = ["us-east-1a", "us-east-1b"]

}