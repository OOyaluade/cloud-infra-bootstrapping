# 📌 AWS CLI & IAM Setup
## 🏥 Cloud Infra Bootstrapping for Healthcare Startup

This repository is the landing site. Links to provisioning secure and scalable AWS infrastructure using Terraform in a sequential manner are found in the table bellow.  
These links bootstraps everything from IAM to VPC networking to EKS; E.T.C — powering a regulated, fast-moving healthcare SaaS.

---

## 🧠 Enterprise Scenario: *CareMesh Health*

**CareMesh Health** is expanding from a monolithic, single-account AWS setup into a secure multi-account, multi-region architecture.  
Their product suite includes telehealth apps, predictive analytics tools, and AI-powered services — all of which must run on scalable, compliant infrastructure.

### 👩‍⚕️ Core Business Needs:
- HIPAA-compliant data storage & processing
- CI/CD pipelines for rapid deployment of patient-facing web apps and ML services
- A scalable architecture to support predictive analytics (e.g., patient no-shows, risk scoring)
- Team-based access separation: Dev, ML, Security, Compliance, and Production
- Cost transparency and control across business units

### 🌐 Cloud Infrastructure Goals:
1. **Multi-Account AWS Org** to isolate environments
2. **Terraform Modules** for repeatable networking and services
3. **EKS for App & ML Workloads** with GitHub Actions CI/CD
4. **Centralized Logging & Monitoring** for operations and incident response
5. **S3 + RDS + DynamoDB** as core data services
6. **MLflow + FastAPI + Prometheus/Grafana** stack for machine learning operations
7. **KMS, IAM SCPs, and GuardDuty** for security

## 🔧 [Cloud Infrastructure Bootstrapping](https://github.com/OOyaluade/cloud-infra-bootstrapping)


### *CareMesh Health* Progress & Roadmap

| Step | Module                                         | Status         |
| ---- | ---------------------------------------------- | -------------- |
| 1    | Backend Bootstrap (S3, DynamoDB)               | ✅ Completed    |
| 2    | Modular VPC Deployment                         | ✅ Completed    |
| 3    | IAM Policies + SCPs Setup                      | 🚧 In Progress |
| 4    | Secure Networking (Subnets, NAT, Route Tables) | 🔜 Upcoming    |
| 5    | RDS Database Setup (Private Subnets)           | 🔜 Upcoming    |
| 6    | EKS Cluster Creation (w/ OIDC)                 | 🔜 Upcoming    |
| 7    | Flask App Deployment (EC2 → EKS)               | 🔜 Upcoming    |
| 8    | Observability Stack (Grafana, Prometheus)      | 🔜 Upcoming    |
| 9    | Model Training + Deployment (MLflow)           | 🔜 Upcoming    |
| 10   | CI/CD Pipelines for Apps & Models              | 🔜 Upcoming    |
| 11   | Monitoring + Drift Detection                   | 🔜 Upcoming    |
###  [Resource Provisioning Guide](https://github.com/OOyaluade/cloud-infra-bootstrapping/blob/main/docs/Resource%20Provisioning%20Guide.md)
A complete guide for provisioning this infrastructure with Terraform, including backend initialization, resource deployment, and backend state migration [available here](https://github.com/OOyaluade/cloud-infra-bootstrapping/blob/main/docs/Resource%20Provisioning%20Guide.md). If you feel confident, skip the above and continue with the details below. 

> ✉️ For full configuration steps, see [`docs/AWSCLI-setup`](https://github.com/OOyaluade/cloud-infra-bootstrapping/blob/main/docs/AWS-CLI%20setup.md)

---

> [!IMPORTANT]  
> Terraform requires that the **S3 bucket** (for storing the state file) and the **DynamoDB table** (for state locking) already exist before initializing the backend.  
> This creates a _“chicken-and-egg” problem_ because you can’t create them using Terraform if Terraform itself hasn’t been initialized yet.
---

#### ✅ Solution: Manual or Bootstrap Step

Before you can deploy the rest of the infrastructure (`02_cloudinfra`), you must **manually create** or **bootstrap** the following resources:

| Resource       | Example Name        | Purpose                               |
| -------------- | ------------------- | ------------------------------------- |
| S3 Bucket      | `caremesh-tf-2723`  | Store Terraform state                 |
| DynamoDB Table | `caremesh-tf-locks` | Lock state to prevent race conditions |

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

- Use a **separate Terraform config** (`01_bootstrap_backend/`) _without_ a backend block
    
- Run `terraform init && terraform apply` to provision backend resources
    
- Then enable remote backend in `02_cloudinfra` using `terraform init -migrate-state`
    

> 💼 **In real enterprise environments**, many teams use [Terraform Cloud](https://www.terraform.io/cloud) or tools like Spacelift or Atlantis for easier collaboration, secure state handling, and CI/CD workflows.

---

### 🧠 Subnetting Refresher + VPC IaC

You can refer to:

- 📄 [`docs/Quick Subnetting Refresher (For Cloud Engineers).md`](https://github.com/OOyaluade/cloud-infra-bootstrapping/blob/main/docs/Quick%20Subnetting%20Refresher%20\(For%20Cloud%20Engineers\).md) for binary subnetting concepts
    
- 🧱 [`02_cloudinfra/modules/vpc/`](https://github.com/OOyaluade/cloud-infra-bootstrapping/tree/main/02_core_infra/modules/vpc) for the modular Terraform code that defines:
    
    - Public and private subnets
        
    - Route tables and associations
        
    - NAT and Internet Gateways
        

---

### 📁 Folder Structure
```shell
cloud-infra-bootstrapping/
├── README.md
├── docs/
│   ├── aws-cli-setup.md
│   ├── resource-provisioning-guide.md
│   └── quick-subnetting-refresher.md
├── 01_bootstrap_backend/
│   ├── main.tf         
│   ├── variables.tf
├── 02_core_infra/
│   ├── main.tf         
│   ├── outputs.tf
│   ├── variables.tf
│   ├── terraform.tf    
│   └── locals.tf      
└── 03_ modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── iam/
    │   ├── dev_policies.tf
    │   ├── ml_policies.tf
    │   ├── prod_policies.tf
    │   ├── audit_policies.tf
    │   ├── scp.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── rds/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── eks/
    │   ├── main.tf
    │   ├── node_groups.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── observability/
        ├── main.tf
        ├── grafana_config.tf
        ├── outputs.tf
        └── variables.tf
```

> 🔁 **Pro Tip:** Use `git prune` periodically to clean up unreachable loose objects if you encounter Git warnings during local development.

---
### 📌 Recommendations

✅ Start with `01_bootstrap_backend/` to bootstrap the backend. This makes it easy to:

- Track the creation of state storage infrastructure
    
- Cleanly separate bootstrapping from full infra provisioning
    

Then proceed to `02_cloudinfra/` to deploy the rest of the infrastructure.

---
### 🏛️ Account Design (Planned Structure)
---
|Account|Purpose|
|---|---|
|**Management**|Root account, billing, SCPs|
|**Dev**|All non-prod resources & testing|
|**Prod**|Critical workloads (future setup)|

---

Happy provisioning! 🚀
