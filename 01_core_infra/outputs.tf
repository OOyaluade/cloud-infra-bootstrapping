output "private_subnets" {

  value = local.private_subnets
}
output "public_subnets" {

  value = local.public_subnets
}



output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}



# output "organization_account_details" {
#   description = "All organization account details"
#   value = {
#     developer_email = {
#         name = module.developer_account_name
#         email = module.developer_account_email
#       }
#           production_email = {
#         name = module.production_account_name
#         email = module.production_account_email
#       }
#           machine_learning_email = {
#         name = module.machine_learning_account_name
#         email = module.machine_learning_account_email
#       }
#     }
#   }

