# 📌 AWS CLI & IAM Setup

> ✉️ For full configuration steps, see [`docs/AWSCLI-setup`](https://github.com/OOyaluade/cloud-infra-bootstrapping/blob/main/docs/awscli-setup.md))

---
A complete guide for provisioning infrastructure with Terraform, including backend initialization, resource deployment, and backend state migration [available here]().
###  ![[Resource Provisioning Guide#📦 Prerequisites]]

### 🏛️ Account Design (Planned Structure)

|Account|Purpose|
|---|---|
|**Management**|Root account, billing, SCPs|
|**Dev**|All non-prod resources & testing|
|**Prod**|Critical workloads (future setup)|

---

### 🗃️ Terraform Backend Setup (S3 + DynamoDB)

> [!IMPORTANT]  
> Terraform requires that the **S3 bucket** (for storing the state file) and the **DynamoDB table** (for state locking) already exist before initializing the backend.  
> This creates a _“chicken-and-egg” problem_ because you can’t create them using Terraform if Terraform itself hasn’t been initialized yet.

#### ✅ Solution: Manual or Bootstrap Step

Before you can deploy the rest of the infrastructure (`02 cloudinfra`), you must **manually create** or **bootstrap** the following resources:

|Resource|Example Name|Purpose|
|---|---|---|
|S3 Bucket|`caremesh-tf-2723`|Store Terraform state|
|DynamoDB Table|`caremesh-tf-locks`|Lock state to prevent race conditions|

```bash
# Create S3 bucket
aws s3api create-bucket --bucket caremesh-tf-2723 --region us-east-1

# Create DynamoDB lock table
aws dynamodb create-table \
  --table-name caremesh-tf-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --region us-east-1
```

Alternatively, you can:

- Use a **separate Terraform config** (`01_terraform_s3_state_file/`) _without_ a backend block
    
- Run `terraform init && terraform apply` to provision backend resources
    
- Then enable remote backend in `02_cloudinfra` using `terraform init -migrate-state`
    

> 💼 **In real enterprise environments**, many teams use [Terraform Cloud](https://www.terraform.io/cloud) or tools like Spacelift or Atlantis for easier collaboration, secure state handling, and CI/CD workflows.

---

### 🧠 Subnetting Refresher + VPC IaC

You can refer to:

- 📄 [`docs/Quick Subnetting Refresher (For Cloud Engineers).md`](https://github.com/OOyaluade/cloud-infra-bootstrapping/blob/main/docs/Quick%20Subnetting%20Refresher%20\(For%20Cloud%20Engineers\).md) for binary subnetting concepts
    
- 🧱 [`02 cloudinfra/modules/vpc/`](https://github.com/OOyaluade/cloud-infra-bootstrapping/tree/main/02%20cloudinfra) for the modular Terraform code that defines:
    
    - Public and private subnets
        
    - Route tables and associations
        
    - NAT and Internet Gateways
        

---

### 📁 Folder Structure

```plaintext
cloud-infra-bootstrapping/
├── README.md
├── docs/
│   ├── aws-cli-setup.md
│   └── Quick Subnetting Refresher (For Cloud Engineers).md
├── 01_terraform_s3_state_file/
│   ├── main.tf
│   └── variables.tf
├── 02_cloudinfra/
│   ├── local.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tf
│   └── modules/
│       └── vpc/
│           ├── main.tf
│           ├── output.tf
│           └── variables.tf
```

> 🔁 **Pro Tip:** Use `git prune` periodically to clean up unreachable loose objects if you encounter Git warnings during local development.

---

### 📌 Recommendations

✅ Start with `01_terraform_s3_state_file/` to bootstrap the backend. This makes it easy to:

- Track the creation of state storage infrastructure
    
- Cleanly separate bootstrapping from full infra provisioning
    

Then proceed to `02_cloudinfra/` to deploy the rest of the infrastructure.

---

Happy provisioning! 🚀