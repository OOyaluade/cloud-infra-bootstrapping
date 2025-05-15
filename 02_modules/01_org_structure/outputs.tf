output "local_values" {
  description = "All organization account details"
  value = {
    developer_email = {
        name = local.developer_account_name
        email = local.developer_account_email
      }
          production_email = {
        name = local.production_account_name
        email = local.production_account_email
      }
          machine_learning_email = {
        name = local.machine_learning_account_name
        email = local.machine_learning_account_email
      }
    }
  }
