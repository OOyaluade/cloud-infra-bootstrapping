resource "aws_organizations_account" "CareMesh_Developers_Account" {
  name  = local.developer_account_name
  email = local.developer_account_email
}

resource "aws_organizations_account" "CareMesh_Production_Account" {
  name  = local.production_account_name
  email = local.production_account_email
}

resource "aws_organizations_account" "CareMesh_Machine_Learning_Account" {
  name  = local.machine_learning_account_name
  email = local.machine_learning_account_email
}