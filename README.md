# [AWS CLI & IAM Setup](https://github.com/OOyaluade/cloud-infra-bootstrapping/tree/main/docs)
> ✉️ See `docs/aws-cli-setup.md` for full config steps.

### 📂 Account Design (Planned Structure)

|                |                                   |
| -------------- | --------------------------------- |
| VPC            | Root account, billing, SCPs       |
| Private-Subnet | All non-prod resources & testing  |
| Public-Subnet  | Critical workloads (future setup) |

| Account    | Purpose                           |
| ---------- | --------------------------------- |
| Management | Root account, billing, SCPs       |
| Dev        | All non-prod resources & testing  |
| Prod       | Critical workloads (future setup) |
 