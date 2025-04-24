# 🏥 Cloud Infra Bootstrapping for Healthcare Startup

This repo sets up secure AWS cloud infrastructure for a healthcare-focused SaaS product. We will build everything using Terraform — from IAM to EKS to ML model deployment.

I will first get the basic manual clicking and setup steps out of the way, like configuring AWS CLI access and creating the initial IAM user identity with administrative privileges for Terraforming. This is where Infrastructure as Code (IaC) will take over.

> ✉️ See `docs/aws-cli-setup.md` for full config steps.

Keep in mind that most of the initial manual setup steps are not demonstrated here, since AWS and other engineers already provide surplus documentation outlining them in great detail.

What I will be doing after setting up the environment is using Terraform to:

- Create all other accounts categorized by department
    
- Define IAM policies for least-privilege access
    
- Establish a secure multi-account structure with AWS Organizations
    
- Build foundational infrastructure for scalable ML & DevOps workflows
    

---

## 🔐 AWS CLI & IAM Setup

To deploy AWS infrastructure with Terraform, I began by:

- Configuring the AWS CLI using least-privilege IAM credentials
    
- Targeting `us-east-1` as my default region
    
- Verifying CLI access via `aws sts get-caller-identity`
    

> 📁 See `docs/aws-cli-setup.md` for full config steps

---

### 📂 Account Design (Planned Structure)

|Account|Purpose|
|---|---|
|Management|Root account, billing, SCPs|
|Dev|All non-prod resources & testing|
|Prod|Critical workloads (future setup)|