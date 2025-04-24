# 🏥 Cloud Infra Bootstrapping for Healthcare Startup

This repo sets up secure AWS cloud infrastructure for a healthcare-focused SaaS product.
We will build everything using Terraform — from IAM to EKS to ML model deployment.

## 🔐 Day 1 Goals
- Configure AWS CLI
- Define IAM strategy
- Design AWS Org structure


| Account      | Purpose                          |
|--------------|----------------------------------|
| Management   | Root account, billing, SCPs      |
| Dev          | All non-prod resources & testing |
| Prod         | Critical workloads (future setup)|


