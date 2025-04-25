## 📦 Prerequisites

Ensure the following before starting:

- AWS CLI is installed and configured (`aws configure`)
    
- Terraform is installed (`terraform -version`)
    
- S3 bucket and DynamoDB table for backend state are created (or ready to be created via bootstrap)
    

---

## 🧱 Step 1: Bootstrap Backend Resources (Optional)

If the S3 bucket and DynamoDB table do **not** already exist, start with the `01_terraform_s3_state_file/` module to provision them.

```bash
cd 01_terraform_s3_state_file/

terraform init
terraform apply -auto-approve
```

> 🔁 This step creates:
> 
> - `S3 bucket` for remote state
>     
> - `DynamoDB table` for state locking
>     

Once created, you can proceed to enable remote backend in your main infrastructure module.

---

## 🌐 Step 2: Initialize Remote Backend

Go to your main infrastructure code directory (`02_cloudinfra/`) and ensure the backend block is properly configured in `terraform.tf`.

Then run:

```bash
cd ../02_cloudinfra/
terraform init
```

> ⚠️ If you've already deployed infra using local state and now want to migrate to remote state, use:

```bash
terraform init -migrate-state
```

Terraform will prompt you to confirm the migration.

---

## 🏗️ Step 3: Apply Infrastructure

Now deploy your infrastructure:

```bash
terraform apply -auto-approve
```

This provisions all resources defined in the module (e.g., VPC, subnets, gateways).

---

## 📥 Optional: Plan Before Applying

For safer changes:

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

This ensures you're only applying what you've previewed.

---

## 🔁 Reinitialize or Reconfigure

You may re-run initialization if you:

- Change the backend settings
    
- Clone the project into a new machine
    
- Migrate between backends
    

```bash
terraform init -reconfigure
```

---

## 🧼 Cleanup Resources

To destroy resources:

```bash
terraform destroy
```

> 💡 This only works with the same `terraform.tfstate`. If you're using remote state, ensure you’re authenticated and pointing to the correct backend.

---

## 📌 Pro Tips

- Run `terraform fmt` to auto-format configs
    
- Run `terraform validate` to check for syntax issues
    
- Use `terraform output` to retrieve values after provisioning
    
- For multiple environments (e.g., dev/prod), use workspaces or separate state folders
    

---

## ✅ Summary

|Command|Purpose|
|---|---|
|`terraform init`|Initializes Terraform working directory|
|`terraform apply`|Applies the changes to reach desired state|
|`terraform destroy`|Destroys the infrastructure|
|`terraform init -migrate-state`|Migrates existing state to remote backend|
|`terraform init -reconfigure`|Reinitializes backend config|

---

You're all set to build! 🛠️

---

Need to automate these steps in a CI pipeline or script? Let me know and I’ll help set that up too.