output "local_values" {
  description = "All organization account details"
  value = {
    developer_email = {
        name = local.developer_account_name
        name = local.developer_account_email
      }
    }
  }
