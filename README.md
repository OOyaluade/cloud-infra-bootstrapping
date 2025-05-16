# 📌 AWS CLI & IAM Setup
*| This project is evolving until launch in ~6 months (November 2025). Early contributors are welcome. |*

# 🏥 Cloud Infra Bootstrapping for Startups in:

- Healthcare  
- MLE / DS  
- etc.

This project bootstraps a **production-ready cloud platform** designed for **healthcare SaaS applications, machine learning workflows, and enterprise observability**, with tooling to allow experts to customize later — without blocking early progress.

Originally built for the fictional company **CareMesh Health**, this platform simulates real-world AWS cloud infrastructure needs for fast-growing SaaS and ML-driven healthcare companies.

---

## 🩼 Linting & Commit Standards Setup

To enforce consistent formatting and commit hygiene across Terraform, Markdown, YAML, and Git messages, this project includes a setup script:

```bash
chmod +x .githooks/commit-msgs
git config core.hooksPath .githooks
```

---

## 🧠 Enterprise Scenario: _CareMesh Health_

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

### _CareMesh Health_ Progress & Roadmap

> [Note!!!] While you are programmatically able to create new AWS accounts using Terraform, programmatic deletion like `terraform destroy` will fail to remove both new and existing accounts. Ensure that before you apply, you or your team members have access to the email address(es) for the accounts you plan to create.

> [Note!!!] **AWS IAM Identity Center (formerly AWS SSO)** must be manually activated in each AWS Organization's management account. Terraform **cannot** enable Identity Center automatically, just like it cannot delete AWS accounts. You must first log in via the console, activate Identity Center, and configure your identity source (built-in, Active Directory, or external IdP). Only then can Terraform manage permission sets and assignments.

|Step|Module|Status|
|---|---|---|
|1|Backend Bootstrap (S3, DynamoDB)|✅ Completed|
|2|Modular VPC Deployment|✅ Completed|
|3|IAM Policies + SCPs Setup \| IAM Identity Center + Role & Groups + SCPs|⚠️ In Progress|
|4|Secure Networking (Subnets, NAT, Route Tables)|🔜 Upcoming|
|5|Account Vending Machine|🔜 Upcoming|
|6|RDS Database Setup (Private Subnets)|🔜 Upcoming|
|7|EKS Cluster Creation (w/ OIDC, GPU Nodes for ML)|🔜 Upcoming|
|8|Flask App Deployment (EC2 → EKS)[OOyaluade/Website_Terraform_Code](https://github.com/OOyaluade/Website_Terraform_Code)
[OOyaluade/Extract_Transform_Load_AWS_WEB_APP](https://github.com/OOyaluade/Extract_Transform_Load_AWS_WEB_APP)|⚠️ Integration Pending|
|9|Observability Stack (Grafana, Prometheus)|🔜 Upcoming|
|10|Model Training + Deployment (MLflow)|🔜 Upcoming|
|11|CI/CD Pipelines for Apps & Models|🔜 Upcoming|
|12|Monitoring + Drift Detection|🔜 Upcoming|

---

> [!IMPORTANT]  
> Terraform requires that the **S3 bucket** (for storing the state file) and the **DynamoDB table** (for state locking) already exist before initializing the backend.  
> Terraform no longer requires DynamoDB to be explicitly configured. You only need to set an existing S3 bucket with `use_lockfile = true`. This method is already included in `terraform.tf` for your convenience. Just create the bucket manually or use the CLI script below.

---

### ✅ Solution: Manual or Bootstrapped Step

Before you can deploy the rest of the infrastructure (`01_cloudinfra`), you must **manually create** or **bootstrap** the following resources:

|Resource|Example Name|Purpose|
|---|---|---|
|S3 Bucket|`caremesh-tf-2723`|Store Terraform state|

```bash
# Create S3 bucket
aws s3api create-bucket --bucket caremesh-tf-2723 --region us-east-1
```

> 💼 **In real enterprise environments**, many teams use [Terraform Cloud](https://www.terraform.io/cloud) or tools like Spacelift or Atlantis for easier collaboration, secure state handling, and CI/CD workflows.

---

### 🧠 Subnetting Refresher + VPC IaC

You can refer to:

- 📄 [`docs/Quick Subnetting Refresher (For Cloud Engineers).md`](https://github.com/OOyaluade/cloud-infra-bootstrapping/blob/main/docs/Quick%20Subnetting%20Refresher%20%28For%20Cloud%20Engineers%29.md) — for binary subnetting concepts
    
- 🧱 [`02_modules/vpc/`](https://github.com/OOyaluade/cloud-infra-bootstrapping/tree/main/02_modules/vpc) — for modular Terraform code that defines:
    
    - Public and private subnets
        
    - Route tables and associations
        
    - NAT and Internet Gateways
        

---

### 📁 Current Folder Structure | Evolving Until Project Launch

```shell
cloud-infra-bootstrapping/
├── 01_core_infra
│   ├── locals.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── terraform.tf
│   └── variables.tf
├── 02_modules
│   ├── 01_org_structure
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── 02_iam_roles
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tf
│   │   └── variables.tf
│   ├── scp
│   └── vpc
│       ├── main.tf
│       ├── output.tf
│       └── variables.tf
├── CONTRIBUTING.MD
├── docs
│   ├── AWS-CLI setup.md
│   ├── Quick Subnetting Refresher (For Cloud Engineers).md
│   └── Resource Provisioning Guide.md
├── LICENSE
├── output.txt
├── package.json
├── package-lock.json
└── README.md
```

> 🔁 **Pro Tip:** Use `git prune` periodically to clean up unreachable loose objects if you encounter Git warnings during local development.

---

### 🏩 Account Design (Planned Structure)

|Account|Purpose|
|---|---|
|**Management**|Root account, billing, SCPs|
|**Dev**|All non-prod resources & testing|
|**MLE / DS**|Model training, evaluation, critical ML workloads|
|**Prod**|Production systems, regulated and external-facing|

