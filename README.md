# 📌 [AWS CLI & IAM Setup](https://github.com/OOyaluade/cloud-infra-bootstrapping/tree/main/docs)

> ✉️ For full configuration steps, see [`docs/aws-cli-setup.md`](URL)

---

### 🏛️ Account Design (Planned Structure)

|Account|Purpose|
|---|---|
|**Management**|Root account, billing, SCPs|
|**Dev**|All non-prod resources & testing|
|**Prod**|Critical workloads (future setup)|

---

### 🗃️ Terraform State File Tracking

> [!NOTE] **Terraform Backend Design**  
> This project uses an **S3 + DynamoDB backend** for state file storage and locking.  
> While realistic for production use, **Terraform Cloud** is also a great alternative for collaboration, audit logging, and visibility for recruiters and hiring managers.

---

### 🧠 Subnetting Refresher + VPC IaC

You can refer to:

- 📄 [`docs/Quick Subnetting Refresher (For Cloud Engineers).md`](https://chatgpt.com/c/docs/Quick%20Subnetting%20Refresher%20\(For%20Cloud%20Engineers\).md) for binary subnetting concepts
    
- 🧱 [`cloudinfra/modules/vpc/`](https://chatgpt.com/c/cloudinfra/modules/vpc/) for the modular Terraform code that defines:
    
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
├── cloudinfra/
│   ├── main.tf
│   ├── variables.tf
│   ├── local.tf
│   ├── outputs.tf
│   ├── terraform.tf         # Will define S3 + DynamoDB backend here
│   └── modules/
│       └── vpc/
│           ├── main.tf
│           ├── output.tf
│           └── variables.tf
└── hold.tf                  # (placeholder for later use)
```

Let me know if you'd like this inserted into your actual `README.md` file — or if you'd like help integrating the backend config block!