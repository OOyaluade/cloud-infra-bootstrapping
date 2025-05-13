# module "vpc" {
#   source          = "../03_modules/vpc"
#   vpc_cidr        = local.vpc_cidr_block
#   private_subnets = local.private_subnets
#   public_subnets  = local.public_subnets
#   azs_private     = local.azs_private
#   azs_public      = local.azs_public

#


module "org_structure" {
  source = "../03_modules/02_org_structure"
}