# module "vpc" {
#   source          = "../03_modules/vpc"
#   vpc_cidr        = local.vpc_cidr_block
#   private_subnets = local.private_subnets
#   public_subnets  = local.public_subnets
#   azs_private     = local.azs_private
#   azs_public      = local.azs_public

#


module "org_structure" {
  source = "../03_modules/01_org_structure"
}

module "permission_sets" {
  source         = "aws-ia/permission-sets/aws"  # <- No cloning needed!
  version        = "0.1.0"                        # <-- Optional: use latest stable
  templates_path = "./templates"
}
