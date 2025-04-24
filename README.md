# 🏥 Cloud Infra Bootstrapping for Healthcare Startup

This repo sets up secure AWS cloud infrastructure for a healthcare-focused SaaS product.
We will build everything using Terraform — from IAM to EKS to ML model deployment.

## 🔐 Day 1: AWS CLI & IAM Setup

To deploy AWS infrastructure with Terraform, I began by:
- Configuring the AWS CLI using least-privilege IAM credentials
- Targeting `us-east-1` as my default region
- Verifying CLI access via `aws sts get-caller-identity`

> 📁 See `docs/aws-cli-setup.md` for full config steps



| Account      | Purpose                          |
|--------------|----------------------------------|
| Management   | Root account, billing, SCPs      |
| Dev          | All non-prod resources & testing |
| Prod         | Critical workloads (future setup)|


